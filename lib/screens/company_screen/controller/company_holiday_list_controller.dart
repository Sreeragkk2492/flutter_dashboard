import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/models/company_models/company_holiday_model.dart';
import 'package:flutter_dashboard/models/company_models/holiday_textcontrollerModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CompanyHolidayListController extends GetxController {

    // Observable variables for managing state

  //var companydetails = <Company>[].obs;
  var selectedCompanyId = ''.obs;
   var selectedCompanyCode = ''.obs;
  String? selectedStatus;
  var isLoading = false.obs;
  var isCompanySelected = false.obs;
  var holiday = <CompanyHolidayModel>[].obs;
RxBool isSortasc=true.obs;
  final RxList<HolidayTypeEntry> leaveTypeEntries = <HolidayTypeEntry>[].obs;

  @override
  void onInit() {
    super.onInit();
    resetSelectionState();
  }

 // Reset the selection state and clear all entries
 
  void resetSelectionState() {
    isCompanySelected.value = false;
    selectedCompanyId.value = '';
    holiday.clear(); // Clear the holiday list
    leaveTypeEntries.clear();
    leaveTypeEntries.add(HolidayTypeEntry(
      typeController: TextEditingController(),
      dateController: TextEditingController(),
    ));
  }

   // Add a new leave type entry

  void addLeaveType() {
    leaveTypeEntries.add(HolidayTypeEntry(
      typeController: TextEditingController(),
      dateController: TextEditingController(),
    ));
  }

  Future<void> onCompanySelected(String companyId, String companycode) async {
  print("Selecting company: ID=$companyId, Code=$companycode"); // Add logging
  selectedCompanyId.value = companyId;
  selectedCompanyCode.value = companycode;
  isCompanySelected.value = true;
  holiday.clear();
  await fetchHolidayForCompany();
}


  // Fetch holidays for the selected company
  fetchHolidayForCompany() async {
    isLoading.value = true;
    try {
      var response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY_HOLIDAY)
            .replace(queryParameters: {"company_id": selectedCompanyId.value,"company_code":selectedCompanyCode.value}),
        headers: {
          "Accept": "application/json",
         // "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        holiday.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return CompanyHolidayModel.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

 // Add company holidays for the selected company
 Future<void> addCompanyHoliday() async {
   print("Adding holiday for company ID: ${selectedCompanyId.value}");
    if (selectedCompanyId.value.isEmpty) {
      print("No company selected");
      return;
    }

    List<Map<String, dynamic>> holidaysToAdd = leaveTypeEntries
        .where((entry) =>
            entry.typeController.text.isNotEmpty &&
            entry.dateController.text.isNotEmpty)
        .map((entry) => {
              "date": entry.dateController.text ,
              "description": entry.typeController.text,
              "is_active": true
            })
        .toList();

    if (holidaysToAdd.isEmpty) {
      print("No valid holidays to add");
      return;
    }

    try {
      final tokens = await StorageServices().read('token');
      isLoading.value = true;
      var response = await http.post(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_HOLIDAY).replace(
          queryParameters: {
            "company_id": selectedCompanyId.value,
            "token": tokens
          },
        ),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "token":tokens,
          "Authorization": "Bearer $tokens",
        },
        body: json.encode(holidaysToAdd),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 201) {
        print("Holidays added successfully");
        await awesomeSuccessDialog(message: 'Holiday created successfully',onOk: () {
          Get.back();
        },);
       // Get.back();
       await fetchHolidayForCompany();
         resetSelectionState();
      } else {
        print("Failed to add holidays: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error adding holidays: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
