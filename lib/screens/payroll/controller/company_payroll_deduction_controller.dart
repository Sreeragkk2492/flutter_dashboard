import 'dart:convert';
import 'dart:io';

import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/payroll/company_payroll_deduc_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyPayrollDeductionController extends GetxController {
  var companypayrolldeduction = CompanyPayrollDeductionModel(
    companyId: '',
    deduction: [],
    remarks: '',
    status: '',
    isActive: false,
  ).obs;
  var selectedCompanyId = ''.obs;
  final selecteddeductions = <String>[].obs;
  var deductionName = ''.obs;
  var remarks = ''.obs;

  @override
  void onInit() {
    fetchCompanyPayrollDeduction();
    super.onInit();
  }

   void toggleDeduction(String deductionId) {
    if (selecteddeductions.contains(deductionId)) {
      selecteddeductions.remove(deductionId);
    } else {
      selecteddeductions.add(deductionId);
    }
  }

  addCompanyPayrollDeduction() async {
    for (var deduction in selecteddeductions) {
      final requestBody = {
        "company_id": selectedCompanyId.value,
        "payroll_deduction_id": deduction,
        "deduction_name": deductionName.value,
        "remarks": remarks.value,
        "status": "Active", // You might want to make this configurable
        "is_active": true
      };
      final result = await NetWorkManager.shared().request(
          url: ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_PAYROLL_DEDUCTION,
          method: 'post',
          isAuthRequired: true,
          data: requestBody);

      if (result.isLeft) {
        awesomeOkDialog(message: result.left.message);
      } else {
        final message = result.right['message'];
        // awesomeOkDialog(message: message);
        await fetchCompanyPayrollDeduction();
      }
    }
  }

  Future<void> fetchCompanyPayrollDeduction() async {
    try {
      final url = Uri.parse(
          ApiUrls.BASE_URL + ApiUrls.GET_ALL_PRCOMPANYPAYROLL_DEDUCTION);

      print("Fetching company payroll allowances from URL: $url");

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "token": "$token",
        "Authorization": "Bearer $token",
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        // Parse the response into the model
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Now parse the Map into the model
        final companyPayrollDeduction =
            CompanyPayrollDeductionModel.fromJson(jsonData);

        // Update your observable with the entire model
        companypayrolldeduction.value = companyPayrollDeduction;

        print(
            "Fetched ${companypayrolldeduction.value.deduction.length} deduction successfully");
      } else {
        throw HttpException(
            "Failed to fetch company payroll deduction. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("Error fetching company payroll allowances: $e");
      print("Stack trace: $stackTrace");

      // Show error dialog
      awesomeOkDialog(message: e.toString());
    }
  }
}
