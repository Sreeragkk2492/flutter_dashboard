import 'dart:convert';
import 'dart:io';

import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/payroll/company_payroll_deduc_model.dart';
import 'package:flutter_dashboard/models/payroll/prcompany_payroll_allowance_model.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyPayrollDeductionController extends GetxController {
  var companypayrolldeduction = CompanyPayrollDeductionModel(
    companyId: '',
    remarks: '',
    status: '',
    isActive: false, deduction: [],
  ).obs;
  var selectedCompanyId = ''.obs;
  final selectedDeduction = <String>[].obs;
  var allowanceName = ''.obs;
  var remarks = ''.obs;
  var companyDeduction = <Deduction>[].obs;

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
   // resetSelection();
  }

 // Method to reset selection state

  void resetSelection() {
    isCompanySelected.value = false;
    hasExplicitlySelectedCompany.value = false;
    companyDeduction.clear();
    selectedDeduction.clear();
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
      fetchCompanyPayrollDeduction();
    } else {
      resetSelection();
    }
  }

  //  setSelectedCompany(String companyId,String companycode) {
  //   selectedCompanyId.value = companyId;
  //   selectedCompanycode.value=companycode;
  // }

 // Method to fetch company payroll deductions from the API

  Future<void> fetchCompanyPayrollDeduction() async {
    isLoading.value = true;
    try {
      final url = Uri.parse(
              ApiUrls.BASE_URL + ApiUrls.GET_ALL_PRCOMPANYPAYROLL_DEDUCTION)
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
        final companyPayrollDeduction =
            CompanyPayrollDeductionModel.fromJson(jsonData);

        companypayrolldeduction.value = companyPayrollDeduction;
        companyDeduction.value = companyPayrollDeduction.deduction;
        selectedDeduction.value = companyPayrollDeduction.deduction
            .where((deduction) => deduction.isSelected)
            .map((deduction) => deduction.deductionId)
            .toList();

        print("Fetched ${companyDeduction.length} allowances successfully");
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

  // Method to toggle selection of a deduction

  void toggleDeduction(String deductionId) {
    var index =
        companyDeduction.indexWhere((a) => a.deductionId == deductionId);
    if (index != -1) {
      var deduction = companyDeduction[index];
      companyDeduction[index] = Deduction(
          deductionId: deduction.deductionId,
          deduction: deduction.deduction,
          isSelected: !deduction.isSelected);

      if (deduction.isSelected) {
        selectedDeduction.remove(deductionId);
      } else {
        selectedDeduction.add(deductionId);
      }

      companyDeduction.refresh();
      selectedDeduction.refresh();
    }
  }

   // Method to add company payroll deduction to the API

  addCompanyPayrollDeduction() async {
    final requestBody = {
      "company_id": selectedCompanyId.value,
      "deduction": companyDeduction.map((deduction) {
        return {
          "deduction_id": deduction.deductionId,
          "deduction": deduction.deduction,
          "is_selected": deduction.isSelected
        };
      }).toList(),
      "remarks": remarks.value,
      "status": "Active",
      "is_active": true
    };

    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_PAYROLL_DEDUCTION,
        method: 'post',
        isAuthRequired: true,
        params: {"company_code": selectedCompanycode.value},
        data: requestBody);

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      // Show success message
      awesomeOkDialog(message: "Deduction  added successfully",onOk: () {
          Get.back();
      },);
      fetchCompanyPayrollDeduction();

      // Navigate back
     // Get.back();
    }
  }
}
