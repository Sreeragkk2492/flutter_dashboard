import 'dart:convert';

import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/payroll/generated_payslip_details_model.dart';

import 'package:flutter_dashboard/models/employee_models/user_model.dart';
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
    var totalAllowances = 0.obs;
  var totalDeductions = 0.obs;

  @override
  void onInit() {
    super.onInit();
   // resetSelection(); 
    fetchUsersForCompany(companyId);
    ever(payslipDetails, (_) => update());
  }


   // Method to reset selection state
  // void resetSelection() {
  //   isCompanySelected.value = false;
  //   isUserSelected.value = false;
  //   isYearSelected.value = false;
  //   isMonthSelected.value = false;
  //   selectedCompanyId.value = '';
  //   selectedUserId.value = '';
  //   selectedYear.value = '';
  //   selectedMonth.value = '';
  //   showTabBar.value = false;
  //   noDataFound.value = false;

  //   // Reset data
  //   filteredUsers.clear();
  //   users.clear();
  //   payslip.clear();
  //   allowances.clear();
  //   deductions.clear();

  //   // Reset totals
  //   totalAllowances.value = 0;
  //   totalDeductions.value = 0;

  //   // Reset payslipDetails to default values
  //   payslipDetails.value = PayslipDetails(
  //     employeeId: '',
  //     year: 0,
  //     month: 0,
  //     payperiodStartDate: DateTime.now(),
  //     payperiodEndDate: DateTime.now(),
  //     paydate: DateTime.now(),
  //     paymentMethod: '',
  //     totalAmount: 0,
  //     overtimeHours: 0,
  //     regularHours: 0,
  //     leavedays: 0,
  //     holidays: 0,
  //     workfromhomeDays: 0,
  //     projectCode: '',
  //     location: '',
  //     department: '',
  //     remarks: '',
  //     approved: false,
  //     approvedBy: '',
  //     payslipFileName: '',
  //     status: '',
  //     allowances: [],
  //     deductions: [],
  //     companyId: '',
  //     userId: '',
  //     isActive: false,
  //     id: ''
  //   );
  // }

 // Set selected values for company, user, year, and month

  void setSelectedValues(String companyId, String userId, String year, String month) {
    selectedCompanyId.value = companyId;
    selectedUserId.value = userId;
    selectedYear.value = year;
    selectedMonth.value = month;
    isCompanySelected.value = true;
    isUserSelected.value = true;
    isYearSelected.value = true;
    isMonthSelected.value = true;
  }

  //Add a method to set the selected employee's data
  void setSelectedEmployeeData(String userId) {
    selectedUserId.value = userId;
    fetchPayslipDetails(userId);
  }

  // Check if all necessary selections have been made

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
      fetchPayslipDetails(selectedUserId.value);
    } else {
      print("Not all selections made, hiding tab bar");
      showTabBar.value = false;
    }
  }

    // Handle year selection

  void onYearSelected(String year) {
    selectedYear.value = year;
    isYearSelected.value = true;
    checkAllSelections();
  }

    // Handle month selection

  void onMonthSelected(String month) {
    selectedMonth.value = month;
    isMonthSelected.value = true;
    checkAllSelections();
  }

  // Handle company selection

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

 // Handle user selection

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

 // Fetch users for a given company

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
     // awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

 // Fetch payslip details based on selected company, user, year, and month
  Future<void> fetchPayslipDetails(String userid) async {
    isLoading.value = true;
    noDataFound.value = false;
    try {
      final url = Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_EMPLOYEE_GENERATED_PAYSLIP_DETAILS)
          .replace(queryParameters: {
        "company_id": selectedCompanyId.value,
        "user_id": userid,
        "year": selectedYear.value,
        "month": selectedMonth.value
      });

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
          // Parse the entire response as GeneratedPayslipDetails
        final generatedPayslipDetails = GeneratedPayslipDetails.fromJson(jsonData);
        
        // Update controller variables
        payslipDetails.value = generatedPayslipDetails.payslipDetails;
        allowances.value = generatedPayslipDetails.payslipDetails.allowances;
        deductions.value = generatedPayslipDetails.payslipDetails.deductions;
        
        // Update totals
        totalAllowances.value = generatedPayslipDetails.totalAllowances;
        totalDeductions.value = generatedPayslipDetails.totalDeductions;
        showTabBar.value = true;
      } else if (response.statusCode == 404) {
        noDataFound.value = true;
        showTabBar.value = false;
      } else {
        throw Exception("Failed to fetch payslip details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching payslip details: $e");
      showTabBar.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
