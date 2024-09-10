import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/payroll/employee_payroll_model.dart';
import 'package:flutter_dashboard/models/user_model.dart';
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
  var payslipDetails = PayslipDetails(
      id: '',
      employeeId: '',
      year: 0,
      month: 0,
      payperiodStartDate: DateTime.now(),
      payperiodEndDate: DateTime.now(),
      paydate: DateTime.now(),
      paymentMethod: '',
      totalAmount: 0,
      overtimeHours: '',
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
      deductions: []).obs;
  var showTabBar = false.obs;
  var payslip = <PayslipDetails>[].obs;
  var allowances = <Allowance>[].obs;
  var deductions = <Deduction>[].obs;
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

  @override
  void onInit() {
    // resetSelectionState();
    super.onInit();
    ever(payslip, (_) => _updatePayslipControllers());
    ever(allowances, (_) => _updateAllowanceControllers());
    ever(deductions, (_) => _updateDeductionControllers());
  }

  void _updatePayslipControllers() {
    for (var payslip in payslip) {
      if (!payslipController.containsKey(payslip.id)) {
        payslipController[payslip.id] = TextEditingController();
      }
    }
  }

  void _updateAllowanceControllers() {
    for (var allowance in allowances) {
      if (!allowanceControllers.containsKey(allowance.id)) {
        allowanceControllers[allowance.id] =
            TextEditingController(text: allowance.amount.toString());
      }
    }
  }

  void _updateDeductionControllers() {
    for (var deduction in deductions) {
      if (!deductionControllers.containsKey(deduction.id)) {
        deductionControllers[deduction.id] =
            TextEditingController(text: deduction.amount.toString());
      }
    }
  }

  void checkAllSelections() {
    print("Checking selections:");
    print("Company selected: ${isCompanySelected.value}");
    print("User selected: ${isUserSelected.value}");
    print("Year selected: ${isYearSelected.value}");
    print("Month selected: ${isMonthSelected.value}");

    if (isCompanySelected.value &&
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
            .replace(queryParameters: {"company_id": selectedCompanyId.value}),
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
      final url =
          Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_EMPLOYEE_PAYSLIP_DETAILS)
              .replace(queryParameters: {
        "company_id": "75c88902-eeb1-4775-8ce2-42401c44090e",
        "user_id": "62b8f5d3-ae95-4d63-b2ba-113c4060e4dd",
        "year": selectedYear.value,
        "month": selectedMonth.value
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

        // Update controllers with fetched data

        yearController.text = payslipData.year.toString();
        monthController.text = payslipData.month.toString();
        payPeriodStartController.text =
            DateFormat('yyyy-MM-dd').format(payslipData.payperiodStartDate);
        payPeriodEndController.text =
            DateFormat('yyyy-MM-dd').format(payslipData.payperiodEndDate);
        payDateController.text =
            DateFormat('yyyy-MM-dd').format(payslipData.paydate);
        paymentMethodController.text = payslipData.paymentMethod;
        totalAmountController.text = payslipData.totalAmount.toString();
        overtimeHoursController.text = payslipData.overtimeHours;
        regularHoursController.text = payslipData.regularHours.toString();
        leaveDaysController.text = payslipData.leavedays.toString();
        holidaysController.text = payslipData.holidays.toString();
        workFromHomeDaysController.text =
            payslipData.workfromhomeDays.toString();
        projectCodeController.text = payslipData.projectCode;
        locationController.text = payslipData.location;
        departmentController.text = payslipData.department;
        remarksController.text = payslipData.remarks;
        approvedController.text = payslipData.approved.toString();
        approvedByController.text = payslipData.approvedBy;
        payslipFileNameController.text = payslipData.payslipFileName;
        statusController.text = payslipData.status;
        print("Fetched payslip details successfully");
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
      print("Error fetching payslip details: $e");
      print("Stack trace: $stackTrace");
      awesomeOkDialog(message: e.toString());
      showTabBar.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  addPayslipDetails() async {
    final requestBody = {
      "payslip_details": {
        "company_id": "75c88902-eeb1-4775-8ce2-42401c44090e",
        "user_id": "62b8f5d3-ae95-4d63-b2ba-113c4060e4dd",
        "employee_id": "string",
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
        "is_active": true
      },
      "allowances": {
        "allowance": allowances.map((allowances) {
          return {
            "allowance_id": allowances.id,
            "allowance": allowances.allowanceName,
            "amount": allowanceControllers[allowances.id]?.text ?? '0'
          };
        }).toList(),
        "remarks": "string",
        "status": "string",
        "is_active": true
      },
      "deductions": {
        "deduction": deductions.map((deductions) {
          return {
            "deduction_id": deductions.id,
            "deduction": deductions.deductionName,
            "amount": deductionControllers[deductions.id]?.text ?? '0'
          };
        }).toList(),
        "remarks": "string",
        "status": "string",
        "is_active": true
      }
    };

    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_PAYSLIP_DETAILS,
        method: 'post',
        isAuthRequired: true,
        data: requestBody);

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      // Show success message
      awesomeOkDialog(message: "Updated successfully");
      fetchPayslipDetails();

      // Navigate back
      Get.back();
    }
  }
}
