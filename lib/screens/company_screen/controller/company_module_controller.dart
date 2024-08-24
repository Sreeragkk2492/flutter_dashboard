import 'dart:convert';

import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/company_models/company_module_list_model.dart';
import 'package:flutter_dashboard/models/company_models/pr_application_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CompanyModuleController extends GetxController {
  var applicationmodules = <PrApplicationModule>[].obs;
  var companydetails = <Company>[].obs;
  var companymodules = <CompanyModuleList>[].obs;
  Rx<String?> selectedCompany = Rx<String?>(null);
  RxString selectedmodule = ''.obs;

  void setSelectedCompany(String? value) {
    selectedCompany.value = value;
  }

  // void setSelectedModule(String? value) {
  //   selectedModule.value = value;
  // }

  @override
  void onInit() {
    fetchCompanyModules();
    fetchCompanyDetails();
    fetchPrApplicationModule();
    super.onInit();
  }

  addCompanyModule() async {
    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_MODULE,
        method: 'post',
        isAuthRequired: false,
        data: {
          "remarks": "",
          "status": "",
          "company_id": selectedCompany.value,
          "module_id": selectedmodule.value,
          "is_active": true
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      final message = result.right['message'];
      // awesomeOkDialog(message: message);
      // await fetchCompanyDetails();
    }
  }

  fetchPrApplicationModule() async {
    try {
      // Making the GET request to the API
      var response = await http.get(
          Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_PRAPPLICATION_MODULE));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        applicationmodules.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return PrApplicationModule.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();
      }
    } catch (e) {
      print("Error$e");
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

  fetchCompanyModules() async {
    try {
      // Making the GET request to the API
      var response = await http
          .get(Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY_MODULE));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        companymodules.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return CompanyModuleList.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();
      } else {
        throw Exception(
            "Failed to load company modules. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error$e");
    }
  }
}
