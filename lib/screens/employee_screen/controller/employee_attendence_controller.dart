import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/employee_models/employee_attendence_details_model.dart';
import 'package:flutter_dashboard/models/employee_models/employee_menu_model.dart';
import 'package:flutter_dashboard/models/employee_models/user_model.dart';
import 'package:flutter_dashboard/models/employee_models/usertype_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EmployeeAttendenceController extends GetxController {
  var isLoading = false.obs;
  var isUserTypeSelected = false.obs;
  //var isUserTypeSelected = false.obs;
  var attendenceDetails = <AttendanceDetails>[].obs;
  var attendance = <AttendanceDatum>[].obs;
  var userTypes = <UserType>[].obs;
  var menus = <Menu>[].obs;
 // Add this to track the currently selected user
  final selectedUser = Rx<UserModel?>(null);
  var selectedUserTypeId = ''.obs;
  var selectedCompanyId = ''.obs;
  var selectedUserId = ''.obs;
  var filteredUsers = <UserModel>[].obs;
  var companydetails = <Company>[].obs;
  var users = <UserModel>[].obs;
  var filteredMenus = <Menu>[].obs;
  var remarks = ''.obs;
  var isCompanySelected = false.obs;
  var isUserSelected = false.obs;
  final selectedFromDate = Rx<DateTime?>(null);
  final selectedToDate = Rx<DateTime?>(null);
  var fromDate = Rxn<String>();
  var toDate = Rxn<String>();
  var isFromdateSelected = false.obs;
  var isTodateSelected = false.obs;
  final todateController = TextEditingController();
  final fromdateController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    fetchCompanies();
   // resetMenuSelectionState();
    // For qts_admin, this will be null or empty
    // Fetch company ID and user details for cmp_admin
    String? companyIds = await StorageServices().read('company_id');
    await fetchUsersForCompany(companyIds);
   // resetSelectionState();
  }

 

  // Resets all selection states (company and user)
  void resetSelectionState() {
    isCompanySelected.value = false;
   // isUserSelected.value = false;
    selectedCompanyId.value = '';
   // selectedUserId.value = '';
   // filteredMenus.clear();
  }

  // Handles company selection, fetches users based on company selection

  void onCompanySelected(String companyId) {
    selectedCompanyId.value = companyId;
    isCompanySelected.value = true;
    isUserSelected.value = false;
    selectedUserId.value = '';
    filteredMenus.clear();
    fetchUsersForCompany(companyId);
  }

  // Fetches the list of companies from the server

  Future<void> fetchCompanies() async {
    isLoading.value = true;
    try {
      final tokens = await StorageServices().read('token');
      final response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $tokens",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        companydetails.value =
            data.map((json) => Company.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (e) {
      print("Error fetching companies: $e");
      awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetches the users for the selected company from the server

  Future<void> fetchUsersForCompany(String companyId) async {
    isLoading.value = true;
    try {
      final tokens = await StorageServices().read('token');
      final compid = await StorageServices().read('company_id');
      String? effectiveCompanyId = companyId;

      // If no companyId is provided, try to fetch the cmp_admin_company_id
      if (effectiveCompanyId == null || effectiveCompanyId.isEmpty) {
        effectiveCompanyId = await StorageServices().read('company_id');
      }

      // If we still don't have a company ID, throw an error
      if (effectiveCompanyId == null || effectiveCompanyId.isEmpty) {
        throw Exception('No company ID available');
      }
      final response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_USER_BY_COMPANY_ID)
            .replace(queryParameters: {"company_id": effectiveCompanyId}),
        headers: {
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("Raw JSON data: $data");
        users.value = data.map((json) => UserModel.fromJson(json)).toList();
        //sort users in alphabetic order
        users.sort((a, b) => a.name.compareTo(b.name));

        filteredUsers.value = users;
      } else {
        throw Exception('Failed to load users for company');
      }
    } catch (e) {
      print("Error fetching users: $e");
      // awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void onUserSelected(String userTypeId, String companyId, String userId,UserModel user) {
    selectedUserTypeId.value = userTypeId;
    selectedCompanyId.value = companyId;
    selectedUserId.value = userId;
     selectedUser.value = user;  // Store the selected user
    isUserSelected.value = true;
    checkAllSelections();
  }

   // Add method to check if a user is selected
  bool isUserCurrentlySelected(UserModel user) {
    return selectedUser.value?.id == user.id;
  }


  void checkAllSelections() {
    print("Checking selections:");
    print("Company selected: ${isCompanySelected.value}");
    print("User selected: ${isUserSelected.value}");
    print("Year selected: ${isFromdateSelected.value}");
    print("Month selected: ${isTodateSelected.value}");

    if (isUserSelected.value &&
        isFromdateSelected.value &&
        isTodateSelected.value) {
      print("All selections made, fetching payslip details");
      fetchAttendanceDetails();
    } else {
      print("Not all selections made, hiding tab bar");
      // showTabBar.value = false;
    }
  }

  void onFromDateSelected(DateTime? date) {
    selectedFromDate.value = date;
    isFromdateSelected.value = true;
    if (date != null) {
      fromdateController.text = DateFormat('yyyy-MM-dd').format(date);
    }
    if (isUserSelected.value && selectedToDate.value != null) {
      checkAllSelections();
    }
  }

  void onToDateSelected(DateTime? date) {
    selectedToDate.value = date;
    isTodateSelected.value = true;
    if (date != null) {
      todateController.text = DateFormat('yyyy-MM-dd').format(date);
    }
    if (isUserSelected.value && selectedFromDate.value != null) {
      checkAllSelections();
    }
  }

  // Fetch payslip details based on selected company, user, year, and month
  Future<void> fetchAttendanceDetails() async {
    isLoading.value = true;
    // noDataFound.value = false;
    try {
      final tokens = await StorageServices().read('token');
      final url =
          Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_EMPLOYEE_ATTENDENCE_REPORT)
              .replace(queryParameters: {
        "from_date": DateFormat('yyyy-MM-dd').format(selectedFromDate.value!),
        "to_date": DateFormat('yyyy-MM-dd').format(selectedToDate.value!),
        "user_id": selectedUserId.value
      });

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tokens",
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        // Parse the entire response as GeneratedPayslipDetails
        final generatedPayslipDetails = AttendanceDetails.fromJson(jsonData);
        attendance.value = generatedPayslipDetails.attendanceData;
      } else if (response.statusCode == 404) {
      } else {
        throw Exception(
            "Failed to fetch payslip details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching payslip details: $e");
      if (e is http.Response) {
        print("Response body: ${e.body}");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
