import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/models/payroll/employee_payroll_model.dart';
import 'package:flutter_dashboard/models/employee_models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PayrollSettingsController extends GetxController {
  var selectedSegment = 1.obs; // Observable variable to track segment
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
  var payslipDetails = PayslipDetail(
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
          isActive: false, userName: '', name: '', phoneNumber: 0, address: '')
      .obs;
  var showTabBar = false.obs;
  var payslip = <PayslipDetail>[].obs;
  var allowances = <AllowanceElement>[].obs;
  var deductions = <Deduction>[].obs;
  var companyPayroll=<CompanyPayroll>[].obs;
 // var companySelectedDeduction=<CompanySelectedDeduction>[].obs;
  final payslipController = <String, TextEditingController>{}.obs;
  final allowanceControllers = <String, TextEditingController>{}.obs;
  final deductionControllers = <String, TextEditingController>{}.obs;
  final yearController = TextEditingController();
  final monthController = TextEditingController();
  final payPeriodStartController = TextEditingController();
  final payPeriodEndController = TextEditingController();
  final payDateController = TextEditingController();
  final paymentMethodController = TextEditingController();
  final totalAmountController = TextEditingController();
  final overtimeHoursController = TextEditingController();
  final regularHoursController = TextEditingController();
  final leaveDaysController = TextEditingController();
  final holidaysController = TextEditingController();
  final workFromHomeDaysController = TextEditingController();
  final projectCodeController = TextEditingController();
  final locationController = TextEditingController();
  final departmentController = TextEditingController();
  final remarksController = TextEditingController();
  final approvedController = TextEditingController();
  final approvedByController = TextEditingController();
  final payslipFileNameController = TextEditingController();
  final statusController = TextEditingController();
  var noDataFound = false.obs;
  var isGenerated = false.obs;
   var showDataTable = false.obs;
     var isPayslipGenerated = false.obs;

  @override
  void onInit() async {
    // resetSelectionState();
    // For qts_admin, this will be null or empty
    // For cmp_admin, this should contain the company ID
    String? companyIds = await StorageServices().read('company_id');
    fetchUsersForCompany(companyIds);
    super.onInit();
    ever(payslip, (_) => _updatePayslipControllers());
    ever(allowances, (_) => _updateAllowanceControllers());
    ever(deductions, (_) => _updateDeductionControllers());
    String? userType = await StorageServices().read('user_type');
    String? companyId = await StorageServices().read('company_id');
    
    if (userType == 'CMP_ADMIN' && companyId != null) {
      selectedCompanyId.value = companyId;
      isCompanySelected.value = true;
    }
  }

  // Methods to update controllers based on data changes

  void _updatePayslipControllers() {
    for (var payslip in payslip) {
      if (!payslipController.containsKey(payslip.companyId)) {
        payslipController[payslip.companyId] = TextEditingController();
      }
    }
  }

  // Methods to update controllers based on data changes
  void _updateAllowanceControllers() {
    for (var allowance in allowances) {
      if (!allowanceControllers.containsKey(allowance.id)) {
        allowanceControllers[allowance.id] =
            TextEditingController(text: allowance.amount.toString());
      }
    }
  }

  // Methods to update controllers based on data changes
  void _updateDeductionControllers() {
    for (var deduction in deductions) {
      if (!deductionControllers.containsKey(deduction.id)) {
        deductionControllers[deduction.id] =
            TextEditingController(text: deduction.amount.toString());
      }
    }
  }

  // Check if all necessary selections are made to fetch payslip details

  void checkAllSelections() {
    print("Checking selections:");
    print("Company selected: ${isCompanySelected.value}");
    print("Company ID: ${selectedCompanyId.value}");
    print("Year selected: ${isYearSelected.value}");
    print("Year: ${selectedYear.value}");
    print("Month selected: ${isMonthSelected.value}");
    print("Month: ${selectedMonth.value}");

    if (isCompanySelected.value && isYearSelected.value && isMonthSelected.value) {
      print("All selections made, fetching payslip details");
      fetchPayslipDetails();
    } else {
      print("Not all selections made, hiding data table");
      showDataTable.value = false;
    }
  }

  // Methods to handle year selections

  void onYearSelected(String year) {
    selectedYear.value = year;
    isYearSelected.value = true;
    checkAllSelections();
  }

  // Methods to handle month selections

  void onMonthSelected(String month) {
    selectedMonth.value = month;
    isMonthSelected.value = true;
    checkAllSelections();
  }

  // Methods to handle company selections

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
   // checkAllSelections();
  }

  //  void onCompanySelectedForVerify(String companyId) async {
  //   selectedCompanyId.value = companyId;
  //   isCompanySelected.value = true;
  //  checkAllSelections(); 
  // }

  // Methods to handle user selections

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

  // Fetch users for a specific company

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
      // awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch payslip details based on selected criteria

  Future<void> fetchPayslipDetails() async {
    isLoading.value = true;
    showDataTable.value = false;
    noDataFound.value = false;
    try {
      final tokens = await StorageServices().read('token');
       String? effectiveCompanyId = companyId;
      // If no companyId is provided, try to fetch the cmp_admin_company_id
      if (effectiveCompanyId == null || effectiveCompanyId.isEmpty) {
        effectiveCompanyId = await StorageServices().read('company_id');
      }

      // If we still don't have a company ID, throw an error
      if (effectiveCompanyId == null || effectiveCompanyId.isEmpty) {
        throw Exception('No company ID available');
      }
      final url =
          Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_EMPLOYEE_PAYSLIP_DETAILS)
              .replace(queryParameters: {
        "company_id": selectedCompanyId.value,
      //  "user_id": selectedUserId.value, 
        "year": selectedYear.value,
        "month": selectedMonth.value
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
         final employeePayroll = EmployeePayroll.fromJson(jsonData);

      // Update observable variables
      companyPayroll.value = employeePayroll.companyPayrolls;
    //  companySelectedDeduction.value = employeePayroll.companySelectedDeduction;
      payslip.value = employeePayroll.payslipDetails;

      if (employeePayroll.payslipDetails.isNotEmpty) {
        final payslipData = employeePayroll.payslipDetails.first;
        payslipDetails.value = payslipData;
        allowances.value = payslipData.allowances;
        deductions.value = payslipData.deductions;

        // Update controllers with fetched data

        yearController.text = payslipData.year.toString();
        monthController.text = payslipData.month.toString();
        payPeriodStartController.text =
            DateFormat('yyyy-MM-dd').format(payslipData.payperiodStartDate);
        payPeriodEndController.text =
            DateFormat('yyyy-MM-dd').format(payslipData.payperiodEndDate);
        payDateController.text =
            DateFormat('yyyy-MM-dd').format(payslipData.paydate);
        paymentMethodController.text = payslipData.paymentMethod.toString();
        totalAmountController.text = payslipData.totalAmount.toString();
        overtimeHoursController.text = payslipData.overtimeHours.toString();
        regularHoursController.text = payslipData.regularHours.toString();
        leaveDaysController.text = payslipData.leavedays.toString();
        holidaysController.text = payslipData.holidays.toString();
        workFromHomeDaysController.text =
            payslipData.workfromhomeDays.toString();
        projectCodeController.text = payslipData.projectCode.toString();
        locationController.text = payslipData.location.toString();
        departmentController.text = 'null';
        remarksController.text = payslipData.remarks.toString();
        approvedController.text = payslipData.approved.toString();
        approvedByController.text = payslipData.approvedBy;
        payslipFileNameController.text = payslipData.payslipFileName.toString();
        statusController.text = payslipData.status.toString();
        print("Fetched payslip details successfully");
        print("Allowances: ${allowances.length}");
        print("Deductions: ${deductions.length}");
        showTabBar.value = true;
         showDataTable.value = true;
      } else {
        noDataFound.value = true;
        showTabBar.value = false;
          showDataTable.value = false;
      }
    } else if (response.statusCode == 404) {
      noDataFound.value = true;
      showTabBar.value = false;
      showDataTable.value = false;
    } else {
      throw Exception("Failed to fetch payslip details. Status code: ${response.statusCode}");
    }
    } catch (e, stackTrace) {
      print("Error fetching payslip details: $e");
      print("Stack trace: $stackTrace");
      awesomeOkDialog(message: e.toString());
       showDataTable.value = false;
      showTabBar.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  // Add or update payslip details

 Future<void> addPayslipDetails(String userid) async {
  isLoading.value = true;
  isGenerated.value = false;
  isPayslipGenerated.value = false;

  // Find the specific employee's payslip details
  final employeePayslip = payslip.firstWhere((p) => p.userId == userid);

  final requestBody = {
    "payslip_details": {
      "company_id": selectedCompanyId.value,
      "user_id": userid,
      "employee_id": employeePayslip.employeeId,
      "year": yearController.text,
      "month": monthController.text,
      "payperiod_start_date": payPeriodStartController.text,
      "payperiod_end_date": payPeriodEndController.text,
      "paydate": payDateController.text,
      "payment_method": paymentMethodController.text,
      "total_amount": totalAmountController.text,
      "overtime_hours": double.tryParse(overtimeHoursController.text),
      "regular_hours": regularHoursController.text,
      "leavedays": leaveDaysController.text,
      "holidays": holidaysController.text,
      "workfromhome_days": workFromHomeDaysController.text,
      "project_code": projectCodeController.text,
      "location": locationController.text,
      "department": departmentController.text,
      "remarks": remarksController.text,
      "approved": true,
      "approved_by": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "payslip_file_name": payslipFileNameController.text,
      "status": statusController.text,
      "is_active": true,
      "allowances": employeePayslip.allowances.map((allowance) {
        return {
          "id": allowance.id,
          "allowance_name": allowance.allowanceName,
          "amount": allowance.amount
        };
      }).toList(),
      "deductions": employeePayslip.deductions.map((deduction) {
        return {
          "id": deduction.id,
          "deduction_name": deduction.deductionName,
          "amount": deduction.amount
        };
      }).toList(),
    }
  };

  final result = await NetWorkManager.shared().request(
    url: ApiUrls.BASE_URL + ApiUrls.ADD_PAYSLIP_DETAILS,
    method: 'post',
    isAuthRequired: true,
    data: requestBody
  );

  if (result.isLeft) {
    isGenerated.value = true;
    isPayslipGenerated.value = true;
    awesomeOkDialog(message: "Payslip already generated for this month");
  } else {
    final message = result.right['message'];
    print(message);
    isGenerated.value = true;
    isPayslipGenerated.value = true;
   await awesomeSuccessDialog(message: "Payslip generated successfully",onOk: () {
     Get.back();
   },);
  }

  isLoading.value = false;
}
}
