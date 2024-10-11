import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/models/payroll/add_payroll_model.dart';
import 'package:flutter_dashboard/models/payroll/show_allowance_deduction_usermodel.dart';
import 'package:flutter_dashboard/models/employee_models/user_model.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmployeePayrollSettingsController extends GetxController {
  var selectedSegment = 1.obs; // Observable variable to track segment
  var filteredUsers = <UserModel>[].obs;
  var isLoading = false.obs;
  var users = <UserModel>[].obs;
  var selectedCompanyId = ''.obs;
  var isCompanySelected = false.obs;
  var isUserSelected = false.obs;
  var selectedUserId = ''.obs;

  var showallowanceanddeduction = ShowAllowanceAndDeductionUserModel(
          companyId: '',
          userId: '',
          employeeId: '',
          allowance: [],
          deduction: [],
          remarks: '',
          status: '',
          isActive: false)
      .obs;

  var showaddallowanceanddeduction = GetAllowaceAndDeductionForAddModel(
          companyId: '',
          userId: '',
          employeeId: '',
          allowance: [],
          deduction: [],
          remarks: '',
          status: '',
          isActive: false)
      .obs;
  var showTabBar = false.obs;
  var allowances = <Allowance>[].obs;
  var deductions = <Deduction>[].obs;
  var getaddallowances = <Allowances>[].obs;
  var getadddeduction = <Deductions>[].obs;
  // Observable maps for storing text controllers
  final allowanceControllers = <String, TextEditingController>{}.obs;
  final deductionControllers = <String, TextEditingController>{}.obs;
  var noDataFound = false.obs;


   @override
  void onInit() async{
    resetSelectionState();
    super.onInit();
      // For qts_admin, this will be null or empty
  // For cmp_admin, this should contain the company ID
  String? companyIds = await StorageServices().read('company_id');
    fetchUsersForCompany(companyIds);
    ever(getaddallowances, (_) => _updateAllowanceControllers());
     ever(getadddeduction, (_) => _updateDeductionControllers());
  }

// Update allowance controllers when allowances change

  void _updateAllowanceControllers() {
    for (var allowance in getaddallowances) {
      if (!allowanceControllers.containsKey(allowance.allowanceId)) {
        allowanceControllers[allowance.allowanceId] = TextEditingController(text: '0');
      }
    }
  }

   // Update deduction controllers when deductions change

   void _updateDeductionControllers() {
    for (var deduction in getadddeduction) {
      if (!deductionControllers.containsKey(deduction.deductionId)) {
        deductionControllers[deduction.deductionId] = TextEditingController(text: '0');
      }
    }
  }

 // Dispose of controllers when the widget is disposed

  @override
  void onClose() {
    for (var controller in allowanceControllers.values) {
      controller.dispose();
    }
     for (var controller in deductionControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }

  // Reset selection state

   void resetSelectionState() {
    isCompanySelected.value = false;
    showTabBar.value=false; 
    selectedCompanyId.value = '';
    
  }

// Check if all necessary selections have been made

  void checkAllSelections() {
    print("Checking selections:");
    print("Company selected: ${isCompanySelected.value}");
    print("User selected: ${isUserSelected.value}");

    if ( isUserSelected.value) {
      print("All selections made, fetching payslip details");
      fetchAllowanceAndDeductionDetails();
      fetchAllowanceAndDeductionDetailsForAdding();
    } else {
      print("Not all selections made, hiding tab bar");
      showTabBar.value = false;
    }
  }

 // Handle company selection

  void onCompanySelected(String companyId) {
    selectedCompanyId.value = companyId;
    isCompanySelected.value = true;
    isUserSelected.value = false;
    selectedUserId.value = '';

    fetchUsersForCompany(companyId);
    checkAllSelections();
  }

 // Handle user selection

  void onUserSelected(String userTypeId, String companyId, String userId) {
    selectedCompanyId.value = companyId;
    selectedUserId.value = userId;
    isUserSelected.value = true;

    checkAllSelections();
  }

 // Fetch users for a given company

  Future<void> fetchUsersForCompany(String companyId) async {
    isLoading.value = true;
    try {
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
      awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

 // Fetch allowance and deduction details for a selected user

  Future<void> fetchAllowanceAndDeductionDetails() async {
    isLoading.value = true;
     noDataFound.value = false;
    try {
       final tokens = await StorageServices().read('token');
      final url = Uri.parse(ApiUrls.BASE_URL +
              ApiUrls.GET_ALL_EMPLOYEE_PAYROLL_ALLOWANCE_AND_DEDUCTION)
          .replace(queryParameters: {
        "company_id": selectedCompanyId.value,
        "user_id": selectedUserId.value,
      });

      print("Fetching payslip details from URL: $url");

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization":
            "Bearer $tokens", 
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final payrollData =
            ShowAllowanceAndDeductionUserModel.fromJson(jsonData);

        showallowanceanddeduction.value = payrollData;
        allowances.value = payrollData.allowance;
        deductions.value = payrollData.deduction;

        print("Fetched payslip details successfully");
        print("Allowances: ${allowances.length}");
        print("Deductions: ${deductions.length}");
         
        showTabBar.value = true;
      }else if (response.statusCode == 404) {
        noDataFound.value = true;
        showTabBar.value = false;
      } 
       else {
        throw Exception(
            "Failed to fetch payroll details. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("Error fetching payroll details: $e");
      print("Stack trace: $stackTrace");
      awesomeOkDialog(message: e.toString());
      showTabBar.value = false;
    } finally {
      isLoading.value = false;
    }
  }

 // Fetch allowance and deduction details for adding new entries

  Future<void> fetchAllowanceAndDeductionDetailsForAdding() async {
    isLoading.value = true;
    try {
        final tokens = await StorageServices().read('token');
      final url = Uri.parse(ApiUrls.BASE_URL +
              ApiUrls.GET_ALL_EMPLOYEE_PAYROLL_ALLOWANCE_AND_DEDUCTION_IN_ADD)
          .replace(queryParameters: {
        "company_id": selectedCompanyId.value,
      });

      print("Fetching payslip details from URL: $url");

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $tokens",
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final payrollAddData =
            GetAllowaceAndDeductionForAddModel.fromJson(jsonData);

        showaddallowanceanddeduction.value = payrollAddData;
        getaddallowances.value = payrollAddData.allowance;
        getadddeduction.value = payrollAddData.deduction;

        print("Fetched payroll details successfully");
        print("Allowances: ${getaddallowances.length}");
        print("Deductions: ${getadddeduction.length}");
        showTabBar.value = true;
      } else if(response.statusCode == 404){
        awesomeOkDialog(message: 'No payroll allowances and deductions found');
      }
    } catch (e, stackTrace) {
      print("Error fetching payroll details: $e");
      print("Stack trace: $stackTrace");
      awesomeOkDialog(message: e.toString());
      showTabBar.value = false;
    } finally {
      isLoading.value = false;
    }
  }

   // Add new payroll entry

  addPayroll() async {
    final requestBody = {
      "company_id": selectedCompanyId.value,
      "user_id": selectedUserId.value,
      "employee_id": "string",
      "allowance": getaddallowances.map((allowances) {
         final amount = double.tryParse(allowanceControllers[allowances.allowanceId]?.text ?? "") ?? 0.0;
        return {
          "allowance_id": allowances.allowanceId,
          "allowance": allowances.allowance,
          "amount": amount.toString()
        };
      }).toList(),
      "deduction": getadddeduction.map((deductions) {
         final amount = double.tryParse(deductionControllers[deductions.deductionId]?.text ?? "") ?? 0.0;
        return {
          "deduction_id": deductions.deductionId,
          "deduction": deductions.deduction,
          "amount": amount.toString()
        };
      }).toList(),
      "remarks": "string",
      "status": "string",
      "is_active": true
    };

    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_EMPLOYEE_PAYROLL,
        method: 'post',
        isAuthRequired: true,
        data: requestBody);

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      allowanceControllers.clear();
      deductionControllers.clear();
      // Show success message
     await awesomeSuccessDialog(message: "Amounts added successfully",onOk: () {
       Get.back();
     },);
     //  fetchAllowanceAndDeductionDetails();

      // Navigate back
     // Get.back();
    }
  }
}
