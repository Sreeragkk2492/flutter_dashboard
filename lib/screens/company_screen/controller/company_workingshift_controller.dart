import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/company_models/workingshift_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyWorkingshiftController extends GetxController {

   // Observable variables for managing state

  var workingShifts = <WorkingShiftModel>[].obs;

  var selectedCompanyId = ''.obs;
  var selectedCompanyCode = ''.obs;
  // final selectedModules = <String>[].obs;
  var modulesName = ''.obs;
  var remarks = ''.obs;
//  var companyModules = <CompanyModule>[].obs;

  var isCompanySelected = false.obs;
  var isLoading = false.obs;
  var hasExplicitlySelectedCompany = false.obs;
  final shiftNameController=TextEditingController();
  final startTimeController=TextEditingController();
  final endTimeController=TextEditingController();

  @override
  void onInit() {
    super.onInit();
    resetSelection();
  }

  void resetSelection() {
    isCompanySelected.value = false;
    hasExplicitlySelectedCompany.value = false;
    workingShifts.clear();
    selectedCompanyId.value = '';
    selectedCompanyCode.value = '';
  }

  void onCompanySelected(String? companyId, String? companyCode) {
    if (companyId != null &&
        companyId.isNotEmpty &&
        companyCode != null &&
        companyCode.isNotEmpty) {
      selectedCompanyId.value = companyId;
      selectedCompanyCode.value = companyCode;
      isCompanySelected.value = true;
      hasExplicitlySelectedCompany.value = true;
      fetchCompanyWorkingShifts();
    } else {
      resetSelection();
    }
  }

//to add working shifts
  addWorkingShifts() async {
    final result = await NetWorkManager.shared().request(
        url: ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_WORKING_SHIFTS,
        params: {
          "company_code":selectedCompanyCode.value
        },
        method: 'post',
        isAuthRequired: false,
        data: {
          "company_id": selectedCompanyId.value,
          "shift_name": shiftNameController.text,
          "start_time": startTimeController.text,
          "end_time": endTimeController.text,
          "description": "string",
          "created_by": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
        });

    if (result.isLeft) {
      awesomeOkDialog(message: result.left.message);
    } else {
      final message = result.right['message'];
      // awesomeOkDialog(message: message);
      await fetchCompanyWorkingShifts();
    }
  }

//to fetch working shifts

  fetchCompanyWorkingShifts() async {
    try {
      // Making the GET request to the API
      var response = await http.get(
          Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY_WORKING_SHIFTS));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        workingShifts.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return WorkingShiftModel.fromJson(jsonItem);
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
