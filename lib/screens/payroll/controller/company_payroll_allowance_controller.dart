import 'dart:convert';
import 'dart:io';

import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/payroll/prcompany_payroll_allowance_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyPayrollAllowanceController extends GetxController {
  var companypayrollallowance = <PrCompanyPayrollAllowance>[].obs;


    @override
  void onInit() {
    fetchCompanyPayrollAllowance(); 
    super.onInit();
  }

  fetchCompanyPayrollAllowance() async {
    try {
      // final token = await StorageServices().read('token');
      final url = Uri.parse(
          ApiUrls.BASE_URL + ApiUrls.GET_ALL_PRCOMPANYPAYROLL_ALLOWANCE);

      print("Fetching users from URL: $url");

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "token": "$token",
        "Authorization": "Bearer $token",
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        companypayrollallowance.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return PrCompanyPayrollAllowance.fromJson(jsonItem);
          } else {
            throw FormatException("Unexpected data format: $jsonItem");
          }
        }).toList();
        print(
            "Fetched ${companypayrollallowance.value.length} users successfully");
      } else {
        throw HttpException(
            "Failed to fetch users. Status code: ${response.statusCode}");
      }
      //   var response = await NetWorkManager.shared().request(
      //       url: ApiUrls.BASE_URL + ApiUrls.GET_ALL_ALLOWANCE,
      //       params: {'token': token},
      //       method: 'get',
      //       isAuthRequired: true);
      //  response.fold((error){
      //   awesomeOkDialog(message: error.message,title: error.title);
      //  }, (success){
      //   var data = response.right;

      //     allowance.value = (data as List).map((jsonItem) {
      //       if (jsonItem is Map<String, dynamic>) {
      //         return Allowance.fromJson(jsonItem);
      //       } else {
      //         throw Exception("Unexpected data format");
      //       }
      //     }).toList();

      //     print("Fetched ${allowance.value.length} allowances successfully");
      //   }
      //  );
    } catch (e, stackTrace) {
      print("Error fetching users: $e");
      print("Stack trace: $stackTrace");

      // Show error dialog
      awesomeOkDialog(message: e.toString());
    }
  }
}
