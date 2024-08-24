import 'dart:convert';
import 'dart:io';

import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class CompanyPayrollDeductionController extends GetxController{

 // var companydeductionallowance = <>[].obs;

  
     @override
  void onInit() {
  //  fetchCompanyPayrollDeduction(); 
    super.onInit();
  }

  // fetchCompanyPayrollDeduction() async {
  //   try {
  //     // final token = await StorageServices().read('token');
  //     final url = Uri.parse(
  //         ApiUrls.BASE_URL + ApiUrls.GET_ALL_PRCOMPANYPAYROLL_ALLOWANCE);

  //     print("Fetching users from URL: $url");

  //     final response = await http.get(url, headers: {
  //       "Accept": "application/json",
  //       "token": "$token",
  //       "Authorization": "Bearer $token",
  //     });

  //     print("Response status code: ${response.statusCode}");
  //     print("Response body: ${response.body}");

  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body) as List;
  //       companydeductionallowance.value = jsonData.map((jsonItem) {
  //         if (jsonItem is Map<String, dynamic>) {
  //           return PrCompanyPayrollAllowance.fromJson(jsonItem);
  //         } else {
  //           throw FormatException("Unexpected data format: $jsonItem");
  //         }
  //       }).toList();
  //       print(
  //           "Fetched ${companypayrollallowance.value.length} users successfully");
  //     } else {
  //       throw HttpException(
  //           "Failed to fetch users. Status code: ${response.statusCode}");
  //     }
  //   
  //   } catch (e, stackTrace) {
  //     print("Error fetching users: $e");
  //     print("Stack trace: $stackTrace");

  //     // Show error dialog
  //     awesomeOkDialog(message: e.toString());
  //   }
  // }
}