import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/models/payroll/company_process_date_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyProccesingDateController extends GetxController {
  var companypayrollprocessingdate = <CompanyProcessingDate>[].obs;
  final processingdayController = TextEditingController();
  final remarksController = TextEditingController();
  String? selectedStatus;
  var selectedCompanyId = ''.obs;
    var isCompanySelected = false.obs;
  RxBool isSortasc=true.obs;
  @override
  void onInit() {
    fetchCompanyPayrollProcessingDate();
    super.onInit();
  }

   void onCompanySelected(String? companyId, String? companyCode) {
    if (companyId != null && companyId.isNotEmpty && companyCode != null && companyCode.isNotEmpty) {
      selectedCompanyId.value = companyId;
     // selectedCompanycode.value = companyCode;
      isCompanySelected.value = true;
      // hasExplicitlySelectedCompany.value = true;
      // fetchCompanyPayrollAllowance();
    } else {
     // resetSelection();
    }
  }

  // Method to add a new processing date

  addProcessingDate() async {
    var response = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_PROCESSING_DATE,
        method: 'post',
        isAuthRequired: true,
        data: {
          "company_id": selectedCompanyId.value,
          "processing_day": processingdayController.text,
          "status": selectedStatus,
          "is_active": true
        });
    if (response.isLeft) {
      awesomeOkDialog(message: response.left.message);
    } else {
      final message = response.right['message'];
       awesomeOkDialog(message: message,onOk: () {
       //  Get.back();
       },);
      await fetchCompanyPayrollProcessingDate();
      processingdayController.clear();
      remarksController.clear();
    }
    // response.fold((error){
    //   awesomeOkDialog(message: error.message);
    // }, (success)async{
    //    final message = response.right['message'];
    //   await fetchAllowance();
    // });
  }

    // Method to fetch company payroll processing dates

  fetchCompanyPayrollProcessingDate() async {
    try {
      final tokens = await StorageServices().read('token');
      final url = Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_PROCESSING_DATE);

      print("Fetching users from URL: $url");

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "token": "$tokens",
        "Authorization": "Bearer $tokens",
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        companypayrollprocessingdate.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return CompanyProcessingDate.fromJson(jsonItem);
          } else {
            throw FormatException("Unexpected data format: $jsonItem");
          }
        }).toList();
        print(
            "Fetched ${companypayrollprocessingdate.value.length} processing date successfully");
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
     // awesomeOkDialog(message: e.toString());
    }
  }
}
