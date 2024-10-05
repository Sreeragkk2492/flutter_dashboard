import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/settings/industry_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class IndustryController extends GetxController {
  final industryname = TextEditingController();

  final remarksController = TextEditingController();
  String? selectedStatus;
RxBool isSortasc=true.obs;
  var industries = <Industry>[].obs;

  @override
  void onInit() {
    fetchIndustry();
    super.onInit();
  }

  // to add industry

  addIndustry() async {
    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_INDUSTRY,
        method: 'post',
        isAuthRequired: false,
        data: {
          "name": industryname.text,
          "remarks": remarksController.text,
          "status": selectedStatus,
          "isactive": true
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      final message = result.right['message'];
      // awesomeOkDialog(message: message);
      await fetchIndustry();
    }
  }

// to fetch all industries


  fetchIndustry() async {
    try {
      // Making the GET request to the API
      var response = await http
          .get(Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_INDUSTRY));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        industries.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return Industry.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();
      }
    } catch (e) {
      print("Error$e");
    }
    //   try {
    //   final result = await NetWorkManager.shared().request(
    //     url: ApiUrls.BASE_URL + ApiUrls.GET_ALL_DEPARTMENT,
    //     isAuthRequired: false,
    //     method: 'get'
    //   );
    //   if (result.isLeft) {
    //     print("Error fetching departments: ${result.left.message}");
    //     awesomeOkDialog(message: result.left.message);
    //   } else {
    //     print("Raw API response: ${result.right}");
    //     print("Type of result.right: ${result.right.runtimeType}");
    //    if (result.right is String) {
    //       var data = json.decode(result.right as String) as List;
    //       departments.value = data.map((item) => Department.fromJson(item as Map<String, dynamic>)).toList();
    //     } else if (result.right is List) {
    //       departments.value = (result.right as List).map((item) => Department.fromJson(item as Map<String, dynamic>)).toList();
    //     } else {
    //       print("Unexpected type for result.right");
    //     }

    //     print("Parsed departments: ${departments.value}");
    //   }
    // } catch(e, stackTrace) {
    //   print("Exception while fetching departments: $e");
    //   print("Stack trace: $stackTrace");
    // }
  }


  // update industry

  updateIndustry(Industry industry) async {
    final result = await NetWorkManager.shared().request(
        isAuthRequired: false,
        method: 'put',
        url: ApiUrls.BASE_URL + ApiUrls.UPDATE_INDUSTRY,
        params: {
          "company_type_id": industry.id
        },
        data: {
          "name": industry.name,
          "remarks": industry.remarks,
          "status": selectedStatus,
          "is_active": true
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      awesomeOkDialog(message: result.right['message']);
    }
  }
}
