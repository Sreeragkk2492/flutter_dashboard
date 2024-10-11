import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/settings/deduction_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeductionController extends GetxController {
  var deduction = <Deduction>[].obs;
  final deductionNameController = TextEditingController();
  final remarksController = TextEditingController();
  String? selectedStatus;
  RxBool isSortasc =true.obs;

  @override
  void onInit() {
    fetchDeduction();
    super.onInit();
  }
//add deduction

  addDeduction() async {
    var response = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_DEDUCTION,
        method: 'post',
        isAuthRequired: true,
        data: {
          "deduction_name": deductionNameController.text,
          "remarks": remarksController.text,
          "status": selectedStatus,
          "is_active": true
        });
    if (response.isLeft) {
      awesomeOkDialog(message: response.left.message);
    } else {
      final message = response.right['message'];
      await awesomeSuccessDialog(message: message,onOk: (){
        Get.back();
      });
   //  Get.back();
      await fetchDeduction();
      deductionNameController.clear();
      remarksController.clear();
    }
    // response.fold((error){
    //   awesomeOkDialog(message: error.message);
    // }, (success)async{
    //    final message = response.right['message'];
    //   await fetchAllowance();
    // });
  }

  // to fetch all deductions

  fetchDeduction() async {
    try {
      //final token = await StorageServices().read('token');
      final url = Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_DEDUCTION);

      print("Fetching users from URL: $url");

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        // "token":"$token",
        // "Authorization": "Bearer $token",
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        deduction.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return Deduction.fromJson(jsonItem);
          } else {
            throw FormatException("Unexpected data format: $jsonItem");
          }
        }).toList();
        print("Fetched ${deduction.value.length} users successfully");
      } else {
        throw HttpException(
            "Failed to fetch users. Status code: ${response.statusCode}");
      }
      // var response = await NetWorkManager.shared().request(
      //     url: ApiUrls.BASE_URL + ApiUrls.GET_ALL_ALLOWANCE,
      //     params: {'token': token},
      //     method: 'get',
      //     isAuthRequired: true);
      // response.fold((error) {
      //   awesomeOkDialog(message: error.message, title: error.title);
      // }, (success) {
      //   var data = response.right;

      //   deduction.value = (data as List).map((jsonItem) {
      //     if (jsonItem is Map<String, dynamic>) {
      //       return Deduction.fromJson(jsonItem);
      //     } else {
      //       throw Exception("Unexpected data format");
      //     }
      //   }).toList();

      //   print("Fetched ${deduction.value.length} allowances successfully");
      // });
    } catch (e, stackTrace) {
      print("Error fetching users: $e");
      print("Stack trace: $stackTrace");

      // Show error dialog
      // awesomeOkDialog(message: e.toString());
    }
  }


  //update deduction

  updateDeduction(Deduction deduction) async {
    final result = await NetWorkManager.shared().request(
        isAuthRequired: false,
        method: 'put',
        url: ApiUrls.BASE_URL + ApiUrls.UPDATE_DEDUCTION,
        params: {
          "deduction_id": deduction.id
        },
        data: {
          "deduction_name": deduction.deductionName,
          "status": deduction.status,
          "is_active": true
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
       final message = result.right['message']; 
     await awesomeSuccessDialog(message: message,onOk: (){
        Get.back();
      });
    //  Get.back();
      await fetchDeduction();
    }
  }
}
