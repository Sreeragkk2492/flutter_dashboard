import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/company_models/company_leave_type_model.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CompanyLeavetypeController extends GetxController {
  // Observable variables for managing state

  var companydetails = <Company>[].obs;
  var selectedCompanyId = ''.obs;
  String? selectedStatus;
  var isLoading = false.obs;
  var isCompanySelected = false.obs;
  var leaveTypes = <CompanyLeaveTypeModel>[].obs;
  final leavenameController = TextEditingController();
  final RxList<TextEditingController> leaveTypeControllers =
      <TextEditingController>[TextEditingController()].obs;
  RxBool isSortasc = true.obs;

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
    leaveTypes.clear(); // Clear the leave types list
    leaveTypeControllers.clear();
    leaveTypeControllers.add(TextEditingController());
  }

  // Add a new leave type controller

  void addLeaveType() {
    leaveTypeControllers.add(TextEditingController());
  }

  // Handle company selection and fetch leave types for the selected company

  void onCompanySelected(String companyId) {
    if (selectedCompanyId.value != companyId) {
      selectedCompanyId.value = companyId;
      isCompanySelected.value = true;
      leaveTypes.clear(); // Clear the previous company's leave type data
      fetchLeavesForCompany();
    }
  }

  // Fetch leave types for the selected company
  fetchLeavesForCompany() async {
    isLoading.value = true;
    try {
      // Making the GET request to the API
      var response = await http.get(
          Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY_LEAVE_TYPE)
              .replace(
                  queryParameters: {"company_id": selectedCompanyId.value}),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          });
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        leaveTypes.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return CompanyLeaveTypeModel.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();
      }
    } catch (e) {
      print("Error$e");
    } finally {
      isLoading.value = false;
    }
  }

  // Add leave types for the selected company
  Future<void> addCompanyLeaveTypes() async {
    if (selectedCompanyId.value.isEmpty) {
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
      return;
    }

    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_LEAVETYPE),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode(leaveTypesToAdd),
      );

      if (response.statusCode == 200) {
        resetSelectionState();
        fetchLeavesForCompany();
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
