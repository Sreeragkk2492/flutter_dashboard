import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/settings/designation_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DesignationController extends GetxController {
  final designationController = TextEditingController();
  final remarksController = TextEditingController();
 // final statusController = TextEditingController();
  String? selectedStatus;
  String? selectedCategory;
  String? selectedDepartment;
  var designations = <Designation>[].obs;

  @override
  void onInit() {
    fetchDesignaation();
    super.onInit();
  }

  addDesignation() async {
    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_DESIGNATION,
        method: 'post',
        isAuthRequired: false,
        data: {
          "designation": designationController.text,
          "remarks": remarksController.text,
          "status": selectedStatus,
          "isactive": true
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      final message = result.right['message'];
      await fetchDesignaation();
    }
  }

  fetchDesignaation() async {
    try {
      // Making the GET request to the API
      var response = await http
          .get(Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_DESIGNATION));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        designations.value =
            jsonData.map((json) => Designation.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error");
    }
  }

  updateDesignation(Designation designation) async {
    final result = await NetWorkManager.shared().request(
        isAuthRequired: false,
        method: 'put',
        url: ApiUrls.BASE_URL + ApiUrls.UPDATE_DESIGNATION,
        params: {"designation_id": designation.id},
        data: {"designation": designation.designation, "is_active": true});

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      awesomeOkDialog(message: result.right['message']);
    }
  }
}
