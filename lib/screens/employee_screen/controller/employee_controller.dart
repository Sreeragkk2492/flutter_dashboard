import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/models/company_models.dart';
import 'package:flutter_dashboard/models/user_model.dart';
import 'package:flutter_dashboard/models/usertype_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmployeeController extends GetxController {
  RxList<UserModel> users = <UserModel>[].obs;
  var companydetails = <Company>[].obs;
  var usertype = <UserType>[].obs;
  var selectedCompanyId = ''.obs;
  var selectedCompanycode = ''.obs;
  var selectedUserTypeId = ''.obs;
  var selectedDesignationId = ''.obs;
  var selectedEmployeeCategoryId = ''.obs;
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dobController = TextEditingController();
  final joiningDateController = TextEditingController();
  final employeeIdController = TextEditingController();
  final biometricIdController = TextEditingController();
  final reportingIdController = TextEditingController();

  // //test
  //  final _currentPage = 0.obs;
  // final _rowsPerPage = 10.obs;

  // // List<User> get users => users.value;
  // int get currentPage => _currentPage.value;
  // int get rowsPerPage => _rowsPerPage.value;

  //  void setCurrentPage(int page) {
  //   _currentPage.value = page;
  // }

  // void setRowsPerPage(int rows) {
  //   _rowsPerPage.value = rows;
  // }

  @override
  void onInit() {
    fetchUsers();
    fetchCompanyDetails();
    fetchUserType();
    super.onInit();
  }

  

  setSelectedCompany(String companyId,String companycode) {
    selectedCompanyId.value = companyId;
    selectedCompanycode.value=companycode;
  }

  setSelectedUserTypeId(String userTypeId) {
    selectedUserTypeId.value = userTypeId;
  }

  setSelectedDesignation(String designationId) {
    selectedDesignationId.value = designationId;
  }

  setSelectedEmployeeCategory(String empCategoryId) {
    selectedEmployeeCategoryId.value = empCategoryId;
  }

  addUser(Map<String, dynamic> employeeData) async {
    var result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_USER,
        params: {
          'company_code': selectedCompanycode.value,
        },
        method: 'post',
        data: {
          "user_name": usernameController.text,
          "name": nameController.text,
          "password": passwordController.text,
          "employee_first_name": firstNameController.text,
          "employee_last_name": lastNameController.text,
          "father_name": fatherNameController.text,
          "mother_name": motherNameController.text,
          "address": addressController.text,
          "phone_number": int.tryParse(phoneNumberController.text),
          "dob": dobController.text,
          "joining_date": joiningDateController.text,
          "employee_id": employeeIdController.text,
          "company_id": selectedCompanyId.value,
          "user_type_id": selectedUserTypeId.value,
          "designation_id": selectedDesignationId.value,
          "emp_category_id": selectedEmployeeCategoryId.value, 
          "biometric_id": biometricIdController.text,
          "reporting_to_id": reportingIdController.text
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      final message = result.right['message'];
      await fetchUsers();
    }
  }

  fetchUsers() async {
    try {
     // final token = await StorageServices().read('token');
      final url = Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_USER)
          .replace(queryParameters: {'token': token});

      print("Fetching users from URL: $url");

      final response = await http.get(url,headers: {
         "Accept": "application/json",
        "token": "$token", 
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        users.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return UserModel.fromJson(jsonItem);
          } else {
            throw FormatException("Unexpected data format: $jsonItem");
          }
        }).toList();
        print("Fetched ${users.value.length} users successfully");
      } else {
        throw HttpException(
            "Failed to fetch users. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("Error fetching users: $e");
      print("Stack trace: $stackTrace");

      // Show error dialog
      awesomeOkDialog(message: e.toString());
    }
  }

  fetchCompanyDetails() async {
    try {
      // Making the GET request to the API
      var response =
          await http.get(Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        companydetails.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return Company.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();
      }
    } catch (e) {
      print("Error$e");
    }
  }

  fetchUserType() async {
    try {
      // Making the GET request to the API
      var response = await http
          .get(Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_USERTYPE));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        usertype.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return UserType.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();
      }
    } catch (e) {
      print("Error$e");
    }
  }

  // updateEmployee(User user) async {
  //   final result = await NetWorkManager.shared().request(
  //       isAuthRequired: false,
  //       method: 'put',
  //       url: ApiUrls.BASE_URL + ApiUrls.UPDATE_USER,
  //       params: {
  //         "user_id": user.id
  //       },
  //       data: {
  //         "father_name": fatherNameController.text,
  //         "mother_name": motherNameController.text,
  //         "address": addressController.text,
  //         "phone_number": int.tryParse(phoneNumberController.text),
  //         "dob": dobController.text,
  //         "email": 'string',
  //         "employee_first_name": firstNameController.text,
  //         "employee_last_name": lastNameController.text
  //       });

  //   if (result.isLeft) {
  //     awesomeOkDialog(message: result.left.message);
  //   } else {
  //     awesomeOkDialog(message: result.right['message']);
  //   }
  // }
}
