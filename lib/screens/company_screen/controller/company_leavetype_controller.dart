import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/models/company_models/company_leave_type_model.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyLeavetypeController extends GetxController {
  // Observable variables for managing state

  var companydetails = <Company>[].obs;
  var selectedCompanyId = ''.obs;
  var selectedCompanyCode = ''.obs;
  String? selectedStatus;
  var isLoading = false.obs;
  var isCompanySelected = false.obs;
  var leaveTypes = <CompanyLeaveTypeModel>[].obs;
  final leavenameController = TextEditingController();
  final RxList<TextEditingController> leaveTypeControllers =
      <TextEditingController>[TextEditingController()].obs;
  RxBool isSortasc = true.obs;

  // Add a new variable to track if we've attempted to fetch leave types
  RxBool hasFetchedLeaveTypes = false.obs;

  @override
  void onInit() {
    super.onInit();
    // resetMenuSelectionState();
    resetSelectionState();
  }

  

  // Reset the selection state and clear all entries

  void resetSelectionState() {
    isCompanySelected.value = false;
    selectedCompanyId.value = '';
    selectedCompanyCode.value = '';
    leaveTypes.clear(); // Clear the leave types list
    hasFetchedLeaveTypes.value = false;
    leaveTypeControllers.clear();
    leaveTypeControllers.add(TextEditingController());
  }

  // Add a new leave type controller

  void addLeaveType() {
    leaveTypeControllers.add(TextEditingController());
  }

  // Handle company selection and fetch leave types for the selected company

  // Updated onCompanySelected method
  Future<void> onCompanySelected(String companyId, String companycode) async {
    if (selectedCompanyId.value != companyId &&
        selectedCompanyCode.value != companycode) {
      selectedCompanyId.value = companyId;
      selectedCompanyCode.value = companycode;
      isCompanySelected.value = true;
      leaveTypes.clear();
      hasFetchedLeaveTypes.value = false; // Reset before new fetch
      await fetchLeavesForCompany(); // Wait for fetch to complete
    }
  }

  // Updated fetchLeavesForCompany method
  Future<void> fetchLeavesForCompany() async {
    if (selectedCompanyId.value.isEmpty && selectedCompanyCode.value.isEmpty)
      return;

    isLoading.value = true;
    try {
      final tokens = await StorageServices().read('token');
      var response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY_LEAVE_TYPE)
            .replace(queryParameters: {
          "company_id": selectedCompanyId.value,
          "company_code": selectedCompanyCode.value
        }),
        headers: {
          "Accept": "application/json",
          // "Authorization": "Bearer $tokens",
        },
      );

      if (response.statusCode == 200) {
        print("Debug: Fetching leaves for company: ${selectedCompanyId.value}");
        var jsonData = json.decode(response.body) as List;
        leaveTypes.value = jsonData
            .whereType<Map<String, dynamic>>()
            .map((jsonItem) => CompanyLeaveTypeModel.fromJson(jsonItem))
            .toList();
      } else {
        print("Error: ${response.statusCode}");
        // Optionally handle non-200 status codes
      }
    } catch (e) {
      print("Error fetching leave types: $e");
      // Optionally show an error message to the user
    } finally {
      isLoading.value = false;
      hasFetchedLeaveTypes.value = true; // Mark that we've attempted to fetch
    }
  }

  // Add leave types for the selected company
  Future<void> addCompanyLeaveTypes() async {
    if (selectedCompanyId.value.isEmpty) {
      print("No company selected");
      return;
    }

    List<Map<String, dynamic>> leaveTypesToAdd = leaveTypeControllers
        .where((controller) => controller.text.isNotEmpty)
        .map((controller) => {
              "company_id": selectedCompanyId.value,
              "type": controller.text,
              "is_active": true,
              "deactivated_by_id": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
            })
        .toList();

    if (leaveTypesToAdd.isEmpty) {
      print("No leave types to add");
      return;
    }

    try {
      final tokens = await StorageServices().read('token');
      isLoading.value = true;
      var response = await http.post(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_LEAVETYPE).replace(
            queryParameters: {"company_code": selectedCompanyCode.value}),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          // "Authorization": "Bearer $tokens",
        },
        body: json.encode(leaveTypesToAdd),
      );

      if (response.statusCode == 201) {
        print("Leave types added successfully");
        await awesomeSuccessDialog(message: 'Leave type created successfully',onOk: () {
        //  Get.back();
        },);
       // Get.back();
        await fetchLeavesForCompany(); // Refresh the list after adding
        resetSelectionState();
      } else {
        print("Error adding leave types: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error adding leave types: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
