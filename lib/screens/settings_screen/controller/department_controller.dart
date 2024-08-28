import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/settings/department_company_id.dart';
import 'package:flutter_dashboard/models/settings/department_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SettingsController extends GetxController {
  //final categoryOrIndustryController = TextEditingController();
  final departmentNameController = TextEditingController();
  //final statusController = TextEditingController();
  final remarksController = TextEditingController();

  String? selectedStatus;
  String? selectedCategory;
  var departments = <DepartmentModel>[].obs;
   var departmentsbycompanyid = <DepartmentByCompanyId>[].obs;

  @override
  void onInit() {
    fetchDepartments();
   // fetchDepartmentByCompanyId();
    super.onInit();
  }

  addDepartment() async {
    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_DEPARTMENT,
        method: 'post',
        isAuthRequired: false,
        data: {
          "department_name": departmentNameController.text,
          "company_type_id": selectedCategory,
          "remarks": remarksController.text,
          "status": selectedStatus,
          "isactive": true
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      final message = result.right['message'];
      // awesomeOkDialog(message: message);
      await fetchDepartments();
    }
  }

  fetchDepartments() async {
    try {
      // Making the GET request to the API
      var response = await http
          .get(Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_DEPARTMENT));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        departments.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return DepartmentModel.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();
      }
    } catch (e) {
      print("Error$e");
    }
   
  }

  fetchDepartmentByCompanyId() async {
    try {
      // Making the GET request to the API
      var response = await http
          .get(Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_DEPARTMENTBYCOMPANYID).replace(queryParameters: {
            "company_type_id":selectedCategory
          }));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        departmentsbycompanyid.value =
            jsonData.map((json) => DepartmentByCompanyId.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error");
    }
  }

  updateDepartment(DepartmentModel department) async {
    final result = await NetWorkManager.shared().request(
        isAuthRequired: false,
        method: 'put',
        url: ApiUrls.BASE_URL + ApiUrls.UPDATE_DEPARTMENT,
        params: {
          "department_id": department.id
        },
        data: {
          "department_name": department.departmentName,
          "is_active": true
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      awesomeOkDialog(message: result.right['message']);
    }
  }
}
