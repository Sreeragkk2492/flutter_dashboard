import 'dart:convert';
import 'dart:io';

import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/payroll/prcompany_payroll_allowance_model.dart';
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

  @override
  void onInit() {
    fetchCompanyPayrollAllowance();
    super.onInit();
  }

   void toggleAllowance(String allowanceId) {
    if (selectedAllowances.contains(allowanceId)) {
      selectedAllowances.remove(allowanceId);
    } else {
      selectedAllowances.add(allowanceId);
    }
  }

 addCompanyPayrollAllowance() async {
   for (var allowance in selectedAllowances) {
        final requestBody = {
          "company_id": selectedCompanyId.value,
          "payroll_allowance_id": allowance,
          "allowance_name": allowanceName.value,
          "remarks": remarks.value,
          "status": "Active",  // You might want to make this configurable
          "is_active": true
        };
    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_PAYROLL_ALLOWANCE,
        method: 'post',
        isAuthRequired: true,
        data: requestBody);

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      final message = result.right['message'];
      // awesomeOkDialog(message: message);
       await fetchCompanyPayrollAllowance();
    }
  }
 }

  
  Future<void> fetchCompanyPayrollAllowance() async {
    try {
      final url = Uri.parse(
          ApiUrls.BASE_URL + ApiUrls.GET_ALL_PRCOMPANYPAYROLL_ALLOWANCE);

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
        final companyPayrollAllowance =
            CompanyPayrollAllowancesModel.fromJson(jsonData);

        // Update your observable with the entire model
        companypayrollallowance.value = companyPayrollAllowance;

        print(
            "Fetched ${companypayrollallowance.value.allowance.length} allowances successfully");
      } else {
        throw HttpException(
            "Failed to fetch company payroll allowances. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("Error fetching company payroll allowances: $e");
      print("Stack trace: $stackTrace");

      // Show error dialog
      awesomeOkDialog(message: e.toString());
    }
  }
}
