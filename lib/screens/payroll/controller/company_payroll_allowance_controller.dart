import 'dart:convert';
import 'dart:io';

import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/payroll/prcompany_payroll_allowance_model.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyPayrollAllowanceController extends GetxController {
  var companypayrollallowance = CompanyPayrollAllowancesModel(
    companyId: '',
    allowance: [],
    remarks: '',
    status: '',
    isActive: false,
  ).obs;
  var selectedCompanyId = ''.obs;
  final selectedAllowances = <String>[].obs;
  var allowanceName = ''.obs;
  var remarks = ''.obs;
  var companyAllowances = <Allowance>[].obs;

  var isCompanySelected = false.obs;
  var isLoading = false.obs;
  var selectedCompanycode = ''.obs;
  var hasExplicitlySelectedCompany = false.obs;
  RxBool isSortasc=true.obs;

  @override
  void onInit() {
    super.onInit();
    final employeeController = Get.put(EmployeeController());
    if (!employeeController.isSuperAdmin.value &&
        employeeController.companydetails.isNotEmpty) {
      final company = employeeController.companydetails[0];
      onCompanySelected(company.id, company.companyCode);
    }
   
  }

 // Method to reset selection state

  void resetSelection() {
    isCompanySelected.value = false;
    hasExplicitlySelectedCompany.value = false;
    companyAllowances.clear();
    selectedAllowances.clear();
    selectedCompanyId.value = '';
    selectedCompanycode.value = '';
  }

   // Method to handle company selection

  void onCompanySelected(String? companyId, String? companyCode) {
    if (companyId != null && companyId.isNotEmpty && companyCode != null && companyCode.isNotEmpty) {
      selectedCompanyId.value = companyId;
      selectedCompanycode.value = companyCode;
      isCompanySelected.value = true;
      hasExplicitlySelectedCompany.value = true;
      fetchCompanyPayrollAllowance();
    } else {
      resetSelection();
    }
  }

  //  setSelectedCompany(String companyId,String companycode) {
  //   selectedCompanyId.value = companyId;
  //   selectedCompanycode.value=companycode;
  // }

 // Method to fetch company payroll allowances from the API

  Future<void> fetchCompanyPayrollAllowance() async {
    isLoading.value = true;
    try {
      final url = Uri.parse(
              ApiUrls.BASE_URL + ApiUrls.GET_ALL_PRCOMPANYPAYROLL_ALLOWANCE)
          .replace(queryParameters: {
        "company_id": selectedCompanyId.value,
        "company_code": selectedCompanycode.value
      });

      print("Fetching company payroll allowances from URL: $url");

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final companyPayrollAllowance =
            CompanyPayrollAllowancesModel.fromJson(jsonData);

        companypayrollallowance.value = companyPayrollAllowance;
        companyAllowances.value = companyPayrollAllowance.allowance;
        selectedAllowances.value = companyPayrollAllowance.allowance
            .where((allowance) => allowance.isSelected)
            .map((allowance) => allowance.allowanceId)
            .toList();

        print("Fetched ${companyAllowances.length} allowances successfully");
      } else {
        throw HttpException(
            "Failed to fetch company payroll allowances. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("Error fetching company payroll allowances: $e");
      print("Stack trace: $stackTrace");
      awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

   // Method to toggle selection of an allowance

  void toggleAllowance(String allowanceId) {
    var index =
        companyAllowances.indexWhere((a) => a.allowanceId == allowanceId);
    if (index != -1) {
      var allowance = companyAllowances[index];
      companyAllowances[index] = Allowance(
          allowanceId: allowance.allowanceId,
          allowance: allowance.allowance,
          isSelected: !allowance.isSelected);

      if (allowance.isSelected) {
        selectedAllowances.remove(allowanceId);
      } else {
        selectedAllowances.add(allowanceId);
      }

      companyAllowances.refresh();
      selectedAllowances.refresh();
    }
  }

   // Method to add company payroll allowance to the API

  addCompanyPayrollAllowance() async {
    final requestBody = {
      "company_id": selectedCompanyId.value,
      "allowance": companyAllowances.map((allowance) {
        return {
          "allowance_id": allowance.allowanceId,
          "allowance": allowance.allowance,
          "is_selected": allowance.isSelected
        };
      }).toList(),
      "remarks": remarks.value,
      "status": "Active",
      "is_active": true
    };

    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_PAYROLL_ALLOWANCE,
        method: 'post',
        isAuthRequired: true,
        params: {"company_code": selectedCompanycode.value},
        data: requestBody);

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      // Show success message
      awesomeOkDialog(message: "Allowances added successfully");
      fetchCompanyPayrollAllowance();

      // Navigate back
      Get.back();
    }
  }
}
