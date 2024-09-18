import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
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
  // Add this line to store the logged-in user's company ID
  final Rx<String?> loggedInCompanyId = Rx<String?>(null);
  final Rx<String?> loggedInUserType = Rx<String?>(null);
  var filteredUsers = <UserModel>[].obs;
  final RxBool isSuperAdmin = false.obs;
  final RxBool isLoading = true.obs;
   RxBool isSortasc=true.obs;
 

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
    initializeController();
    fetchUsers();
    super.onInit();
  }

void setSelectedCompany(String companyId, String companyCode) {
    selectedCompanyId.value = companyId;
    selectedCompanycode.value = companyCode;
    print("Selected company set - ID: $companyId, Code: $companyCode");
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

    Future<void> initializeController() async {
    try {
      await fetchLoggedInCompanyId();
      await fetchLoggedInUserType();
      await fetchCompanyDetails();
    } catch (e) {
      print("Error initializing controller: $e");
      awesomeOkDialog(message: "Failed to initialize. Please try again later.");
    }
  }

  Future<void> fetchLoggedInCompanyId() async {
    try {
      final companyId = await StorageServices().read('company_id');
      print("Fetched logged in company ID: $companyId");
      loggedInCompanyId.value = companyId;
    } catch (e) {
      print("Error fetching logged in company ID: $e");
      loggedInCompanyId.value = null;
    }
  }

  Future<void> fetchLoggedInUserType() async {
  try {
    // Fetch the user type from storage and store it in `loggedInUserType`
    final userType = await StorageServices().read('user_type');
    print("Fetched logged in user type: $userType");

    // Update the Rx variable
    loggedInUserType.value = userType;

    // Set isSuperAdmin based on the fetched user type
    isSuperAdmin.value = loggedInUserType.value == 'QTS_ADMIN';
    print("Is super admin: ${isSuperAdmin.value}");
  } catch (e) {
    print("Error fetching logged in user type: $e");
    loggedInUserType.value = null;
    isSuperAdmin.value = false;
  }
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

      final response = await http.get(url, headers: {
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
        //sort users in alphabetic order
        users.sort((a, b) => a.name.compareTo(b.name));

        filteredUsers.value = users;
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

  Future<void> fetchCompanyDetails() async {
    isLoading.value = true;
    try {
      print("Fetching company details...");
      final url = Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY);
      print("API URL: $url");
      
     // final token = await StorageServices().read('token');
      
      var response = await http.get(
        url,
        headers: {
          "accept": "application/json",
         /// "Authorization": "Bearer $token",
        },
      );
      
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        print("Parsed JSON data: $jsonData");

        if (isSuperAdmin.value) {
          companydetails.value = jsonData.map((jsonItem) => Company.fromJson(jsonItem)).toList();
        } else {
          companydetails.value = jsonData
              .map((jsonItem) => Company.fromJson(jsonItem))
              .where((company) => company.id == loggedInCompanyId.value)
              .toList();
        }

        print("Fetched ${companydetails.length} companies");
        print("Is super admin: ${isSuperAdmin.value}");
        print("Logged in company ID: ${loggedInCompanyId.value}");
        
        if (companydetails.isEmpty) {
          print("Warning: No companies fetched. This might be due to filtering or empty response.");
        }
      } else {
        throw Exception("Failed to load companies. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching company details: $e");
      companydetails.value = []; // Clear the list on error
      awesomeOkDialog(message: "Failed to fetch company details. Please try again later.");
    } finally {
      isLoading.value = false;
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
