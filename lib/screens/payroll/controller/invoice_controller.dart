import 'dart:convert';

import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/payroll/generated_payslip_details_model.dart';

import 'package:flutter_dashboard/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InvoiceController extends GetxController {
  var filteredUsers = <UserModel>[].obs;
  var isLoading = false.obs;
  var users = <UserModel>[].obs;
  var selectedCompanyId = ''.obs;
  var isCompanySelected = false.obs;
  var isUserSelected = false.obs;
  var selectedUserId = ''.obs;
  var isYearSelected = false.obs;
  var isMonthSelected = false.obs;
  var selectedYear = ''.obs;
  var selectedMonth = ''.obs;
  var noDataFound = false.obs;
  var payslipDetails = PayslipDetails(
          employeeId: '',
          year: 0,
          month: 0,
          payperiodStartDate: DateTime.now(),
          payperiodEndDate: DateTime.now(),
          paydate: DateTime.now(),
          paymentMethod: '',
          totalAmount: 0,
          overtimeHours: 0,
          regularHours: 0,
          leavedays: 0,
          holidays: 0,
          workfromhomeDays: 0,
          projectCode: '',
          location: '',
          department: '',
          remarks: '',
          approved: false,
          approvedBy: '',
          payslipFileName: '',
          status: '',
          allowances: [],
          deductions: [],
          companyId: '',
          userId: '',
          isActive: false,
          id: '')
      .obs;
  var showTabBar = false.obs;
  var payslip = <PayslipDetails>[].obs;
  var allowances = <Allowance>[].obs;
  var deductions = <Deduction>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsersForCompany(companyId);
    ever(payslipDetails, (_) => update());
  }

  void setSelectedValues(
      String companyId, String userId, String year, String month) {
    selectedCompanyId.value = companyId;
    selectedUserId.value = userId;
    selectedYear.value = year;
    selectedMonth.value = month;
  }

   void checkAllSelections() {
    print("Checking selections:");
    print("Company selected: ${isCompanySelected.value}");
    print("User selected: ${isUserSelected.value}");
    print("Year selected: ${isYearSelected.value}");
    print("Month selected: ${isMonthSelected.value}");

    if (
        isUserSelected.value &&
        isYearSelected.value &&
        isMonthSelected.value) {
      print("All selections made, fetching payslip details");
      fetchPayslipDetails();
    } else {
      print("Not all selections made, hiding tab bar");
      showTabBar.value = false;
    }
  }

  void onYearSelected(String year) {
    selectedYear.value = year;
    isYearSelected.value = true;
    checkAllSelections();
  }

  void onMonthSelected(String month) {
    selectedMonth.value = month;
    isMonthSelected.value = true;
    checkAllSelections();
  }

  void onCompanySelected(String companyId) {
    selectedCompanyId.value = companyId;
    isCompanySelected.value = true;
    isUserSelected.value = false;
    selectedUserId.value = '';
    isYearSelected.value = false;
    isMonthSelected.value = false;
    selectedYear.value = '';
    selectedMonth.value = '';
    fetchUsersForCompany(companyId);
    checkAllSelections();
  }

  void onUserSelected(String userTypeId, String companyId, String userId) {
    selectedCompanyId.value = companyId;
    selectedUserId.value = userId;
    isUserSelected.value = true;
    isYearSelected.value = false;
    isMonthSelected.value = false;
    selectedYear.value = '';
    selectedMonth.value = '';
    checkAllSelections();
  }

   Future<void> fetchUsersForCompany(String companyId) async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_USER_BY_COMPANY_ID)
            .replace(queryParameters: {"company_id": companyId}),
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
      awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> fetchPayslipDetails() async {
    isLoading.value = true;
    noDataFound.value = false;
    try {
      // Validate year and month
      if (selectedYear.value.isEmpty || selectedMonth.value.isEmpty) {
        throw Exception("Year and month must be selected");
      }

      int year = int.parse(selectedYear.value);
      int month = int.parse(selectedMonth.value);

      final url = Uri.parse(ApiUrls.BASE_URL +
              ApiUrls.GET_ALL_EMPLOYEE_GENERATED_PAYSLIP_DETAILS)
          .replace(queryParameters: {
        "company_id": "75c88902-eeb1-4775-8ce2-42401c44090e",
        "user_id": "62b8f5d3-ae95-4d63-b2ba-113c4060e4dd",
        "year": year.toString(),
        "month": month.toString()
      });

      print("Fetching payslip details from URL: $url");

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final payslipData =
            PayslipDetails.fromJson(jsonData['payslip_details']);

        payslipDetails.value = payslipData;
        allowances.value = payslipData.allowances;
        deductions.value = payslipData.deductions;

        print("Fetched payslip invoice details successfully");
        print("Allowances: ${allowances.length}");
        print("Deductions: ${deductions.length}");
        showTabBar.value = true;
      } else if (response.statusCode == 404) {
        noDataFound.value = true;
        showTabBar.value = false;
      } else {
        throw Exception(
            "Failed to fetch payslip details. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("Error fetching payslip details for invoice: $e");
      print("Stack trace: $stackTrace");
      awesomeOkDialog(message: e.toString());
      showTabBar.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
