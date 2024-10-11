import 'dart:convert';
import 'dart:io';

import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/company_models/company_module_list_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyModuleController extends GetxController {

  // Observable variables for managing state

  var companyModuleList = CompanyModuleList(
          companyId: '',
          companyModules: [],
          remarks: '',
          status: '',
          isActive: false)
      .obs;

  var selectedCompanyId = ''.obs;
  final selectedModules = <String>[].obs;
  var modulesName = ''.obs;
  var remarks = ''.obs;
  var companyModules = <CompanyModule>[].obs;

  var isCompanySelected = false.obs;
  var isLoading = false.obs;
  var hasExplicitlySelectedCompany = false.obs;

  @override
  void onInit() {
    super.onInit();
    resetSelection();
  }

  // Reset the selection state and clear all entries
  
  void resetSelection() {
    isCompanySelected.value = false;
    hasExplicitlySelectedCompany.value = false;
    companyModules.clear();
    selectedModules.clear();
    selectedCompanyId.value = '';
  }

  void onCompanySelected(
    String? companyId,
  ) {
    if (companyId != null && companyId.isNotEmpty) {
      selectedCompanyId.value = companyId;
      isCompanySelected.value = true;
      hasExplicitlySelectedCompany.value = true;
      fetchCompanyModules();
    } else {
      resetSelection();
    }
  }


//to fetch all the company modules of specific company
  Future<void> fetchCompanyModules() async {
    isLoading.value = true;
    try {
      final url = Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY_MODULE)
          .replace(queryParameters: {
        "company_id": selectedCompanyId.value,
      });

      print("Fetching company payroll allowances from URL: $url");

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final companyModuless = CompanyModuleList.fromJson(jsonData);

        companyModuleList.value = companyModuless;
        companyModules.value = companyModuless.companyModules;
        selectedModules.value = companyModuless.companyModules
            .where((modules) => modules.isSelected)
            .map((modules) => modules.moduleId)
            .toList();

        print("Fetched ${companyModules.length} allowances successfully");
      } else {
        throw HttpException(
            "Failed to fetch company payroll allowances. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("Error fetching company payroll allowances: $e");
      print("Stack trace: $stackTrace");
      awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toggleAllowance(String moduleId) {
    var index = companyModules.indexWhere((a) => a.moduleId == moduleId);
    if (index != -1) {
      var modules = companyModules[index];
      companyModules[index] = CompanyModule(
          moduleId: modules.moduleId,
          moduleName: modules.moduleName,
          isSelected: !modules.isSelected);

      if (modules.isSelected) {
        selectedModules.remove(moduleId);
      } else {
        selectedModules.add(moduleId);
      }

      companyModules.refresh();
      selectedModules.refresh();
    }
  }


//to add the modules for specific company
  addCompanyModule() async {
    final requestBody = {
      "company_id": selectedCompanyId.value,
      "company_modules": companyModules.map((modules) {
        return {
          "module_id": modules.moduleId,
          "module_name": modules.moduleName,
          "is_selected": modules.isSelected
        };
      }).toList(),
      "remarks": "string",
      "status": "string",
      "is_active": true
    };

    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_MODULE,
        method: 'post',
        isAuthRequired: true,
        data: requestBody);

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      // Show success message
      awesomeSuccessDialog(message: "Modules added successfully",onOk: () {
         Get.back();
      },);
      fetchCompanyModules();

      // Navigate back
    //  Get.back();
    }
  }
}
