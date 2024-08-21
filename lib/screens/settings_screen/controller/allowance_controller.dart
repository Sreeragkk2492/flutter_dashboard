import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/models/settings/allowance_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AllowanceController extends GetxController {
  var allowance = <Allowance>[].obs;
  final allowanceNameController = TextEditingController();
  final remarksController = TextEditingController();
  String? selectedStatus;

 

  // var attendence = <Attendence>[].obs;

  @override
  void onInit() {
    fetchAllowance(); 
    super.onInit();
  }

  addAllowance() async {
    var response = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_ALLOWANCE,
        method: 'post',
        isAuthRequired: true,
        data: {
          "allowance_name": allowanceNameController.text,
          "remarks": remarksController.text,
          "status": selectedStatus,
          "is_active": true
        });
    if (response.isLeft) {
      awesomeOkDialog(message: response.left.message);
    } else {
      final message = response.right['message'];
      // awesomeOkDialog(message: message);
      await fetchAllowance();
    }
    // response.fold((error){
    //   awesomeOkDialog(message: error.message);
    // }, (success)async{
    //    final message = response.right['message'];
    //   await fetchAllowance();
    // });
  }

  fetchAllowance() async {
    try {
     // final token = await StorageServices().read('token');
      final url = Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_ALLOWANCE)
          ;

      print("Fetching users from URL: $url");

      final response = await http.get(url, 
      headers: {
        "Accept": "application/json",
        "token":"$token",
        "Authorization": "Bearer $token",
      }
      );

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        allowance.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return Allowance.fromJson(jsonItem);
          } else {
            throw FormatException("Unexpected data format: $jsonItem");
          }
        }).toList();
        print("Fetched ${allowance.value.length} users successfully");
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

  //   Future<void> fetchAttendence() async {
  //   try {
  //     // Retrieve token if needed
  //   //  final token = await StorageServices().read('token'); // Adjust as necessary

  //     final url = Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_ATTENDENCE)
  //         .replace(queryParameters: {
  //       'year': int.tryParse(allowanceNameController.text)?.toString(),
  //       'month': int.tryParse(remarksController.text)?.toString(),
  //       "token":" $token"
  //     });

  //     print("Fetching data from URL: $url");

  //     final response = await http.get(
  //       url,
  //       headers: {
  //         "Accept": "application/json",
  //         "token":" $token",
  //         "Authorization": "Bearer $token",
  //       },
  //     );

  //     print("Response status code: ${response.statusCode}");
  //     print("Response body: ${response.body}");

  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);

  //       if (jsonData is Map<String, dynamic>) {
  //         // Parse the JSON data into the Attendence model
  //         attendence = Attendence.fromJson(jsonData);

  //         print("Fetched attendance data successfully");
  //       } else {
  //         throw FormatException("Unexpected JSON format");
  //       }

  //       // Notify listeners if using a state management solution
       
  //     } else {
  //       throw HttpException(
  //           "Failed to fetch data. Status code: ${response.statusCode}");
  //     }
  //   } catch (e, stackTrace) {
  //     print("Error fetching data: $e");
  //     print("Stack trace: $stackTrace");

  //     // Show error dialog if needed
  //     awesomeOkDialog(message: e.toString());
  //   }
  // }
}
