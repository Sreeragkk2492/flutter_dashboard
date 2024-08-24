import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/company_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyController extends GetxController {
  RxBool isVATSelected = false.obs;
  RxBool isGSTSelected = false.obs;
  var companydetails = <Company>[].obs;
  
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
  var selectedCompanyTypecode = ''.obs;
  String? selectedStatus;
  String?selectedCompany;

  void toggleVAT(bool? value) {
    isVATSelected.value = value ?? false;
  }

  void toggleGST(bool? value) {
    isGSTSelected.value = value ?? false;
  }

  @override
  void onInit() {
    fetchCompanyDetails();

    super.onInit();
  }

  setSelectedCompanyTypeID(
    String companyTypeId,
  ) {
    selectedCompanyTypecode.value = companyTypeId;
  }

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
          "is_active": true
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      final message = result.right['message'];
      // awesomeOkDialog(message: message);
      await fetchCompanyDetails();
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
 
}
