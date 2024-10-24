import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyController extends GetxController {
  // Observable boolean values for VAT and GST selection
  RxBool isVATSelected = false.obs;
  RxBool isGSTSelected = false.obs;

  // Observable list to store company details

  var companydetails = <Company>[].obs;

  // Observable boolean for sorting order

  RxBool isSortasc = true.obs;

  // TextEditingControllers for various input fields

  final companyNameController = TextEditingController();
  final companyCodeController = TextEditingController();
  final remarksController = TextEditingController();
  final groupNameController = TextEditingController();
  final legalNameController = TextEditingController();
  final founderorOwnerController = TextEditingController();
  final emailController = TextEditingController();
  final panController = TextEditingController();
  final whatsappController = TextEditingController();
  final phonenumberController = TextEditingController();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final vatnumberController = TextEditingController();
  final vatrateController = TextEditingController();
  final gstnumberController = TextEditingController();
  final gstcompoundingController = TextEditingController();

  // Observable string for selected company type code

  var selectedCompanyTypecode = ''.obs;

  // Nullable strings for selected status and company

  String? selectedStatus;
  String? selectedCompany;

  // Function to toggle VAT selection

  void toggleVAT(bool? value) {
    isVATSelected.value = value ?? false;
  }

  // Function to toggle GST selection

  void toggleGST(bool? value) {
    isGSTSelected.value = value ?? false;
  }

  // Override onInit to fetch company details when the controller is initialized

  @override
  void onInit() {
    fetchCompanyDetails();

    super.onInit();
  }

  // Function to set the selected company type ID

  setSelectedCompanyTypeID(
    String companyTypeId,
  ) {
    selectedCompanyTypecode.value = companyTypeId;
  }

// Function to add a new company

  addCompany() async {
    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY,
        method: 'post',
        isAuthRequired: false,
        data: {
          "company_code": companyCodeController.text,
          "company_name": companyNameController.text,
          "company_type_id": selectedCompanyTypecode.value,
          "remarks": "",
          "status": selectedStatus,
          "is_active": true,
          "single_shift": true
        });

    if (result.isLeft) {
      awesomeOkDialog(
        message: result.left.message,
        onOk: () {
          Get.back();
        },
      );
    } else {
      final message = result.right['message'];
      await awesomeSuccessDialog(
          message: message,
          onOk: () {
           // Get.back();
          });
      // Get.back();
      await fetchCompanyDetails();
    }
  }

  // Function to fetch all company details

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

  // update industry

  updateIndustry(Company company) async {
    final result = await NetWorkManager.shared().request(
        isAuthRequired: true,
        method: 'put',
        url: ApiUrls.BASE_URL + ApiUrls.UPDATE_COMPANY,
        params: {
          "company_type_id": company.id
        },
        data: {
          "company_code": company.companyCode,
          "company_name": company.companyName,
          "company_type_id": selectedCompanyTypecode.value,
          "single_shift": true,
          "is_active": true
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      final message = result.right['message'];
      await awesomeSuccessDialog(
          message: message,
          onOk: () {
           // Get.back();
          });
      //  Get.back();
      await fetchCompanyDetails();
    }
  }
}
