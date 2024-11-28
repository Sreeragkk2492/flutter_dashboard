import 'dart:convert';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/employee_models/employee_menu_model.dart';
import 'package:flutter_dashboard/models/employee_models/employee_selected_holiday_model.dart';
import 'package:flutter_dashboard/models/employee_models/user_model.dart';
import 'package:flutter_dashboard/models/employee_models/usertype_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmployeeSelectedHolidayController extends GetxController {
 
  var isLoading = false.obs;
  var isUserTypeSelected = false.obs;
  //var isUserTypeSelected = false.obs;
 
  var userTypes = <UserType>[].obs;
 var seletedHolidays=<EmployeeSelectedHoliday>[].obs;
  var selectedUserTypeId = ''.obs;
  var selectedCompanyId = ''.obs;
  var selectedUserId = ''.obs;
  var filteredUsers = <UserModel>[].obs;
  var companydetails = <Company>[].obs;
  var users = <UserModel>[].obs;
  var remarks = ''.obs;
  var isCompanySelected = false.obs;
  var isUserSelected = false.obs;

 

  @override
  void onInit() async{
    super.onInit();
    fetchCompanies();
   
     // For qts_admin, this will be null or empty
  // Fetch company ID and user details for cmp_admin
  String? companyIds = await StorageServices().read('company_id');
   await fetchUsersForCompany(companyIds);
    resetSelectionState();
  }

 // Resets the menu selection state when no user is selected

  

 // Resets all selection states (company and user)
  void resetSelectionState() {
    isCompanySelected.value = false;
    isUserSelected.value = false;
    selectedCompanyId.value = '';
    selectedUserId.value = '';
    
  }

 // Handles company selection, fetches users based on company selection

  void onCompanySelected(String companyId) {
    selectedCompanyId.value = companyId;
    isCompanySelected.value = true;
    isUserSelected.value = false;
    selectedUserId.value = '';
   
    fetchUsersForCompany(companyId);
  }

  // Fetches the list of companies from the server

  Future<void> fetchCompanies() async {
    isLoading.value = true;
    try {
       final tokens = await StorageServices().read('token');
      final response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $tokens",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        companydetails.value =
            data.map((json) => Company.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (e) {
      print("Error fetching companies: $e");
      awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

 // Fetches the users for the selected company from the server

  Future<void> fetchUsersForCompany(String companyId) async {
    isLoading.value = true;
    try {
       final tokens = await StorageServices().read('token');
        final compid= await StorageServices().read('company_id');
         String? effectiveCompanyId = companyId;
    
    // If no companyId is provided, try to fetch the cmp_admin_company_id
    if (effectiveCompanyId == null || effectiveCompanyId.isEmpty) {
      effectiveCompanyId = await StorageServices().read('company_id');
    }
    
    // If we still don't have a company ID, throw an error
    if (effectiveCompanyId == null || effectiveCompanyId.isEmpty) {
      throw Exception('No company ID available');
    }
      final response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_USER_BY_COMPANY_ID)
            .replace(queryParameters: {"company_id": effectiveCompanyId}),
        headers: {
          "Accept": "application/json",
       
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("Raw JSON data: $data");
        users.value = data.map((json) => UserModel.fromJson(json)).toList();
        //sort users in alphabetic order
        users.sort((a, b) => a.name.compareTo(b.name));

        filteredUsers.value = users;
      } else {
        throw Exception('Failed to load users for company');
      }
    } catch (e) {
      print("Error fetching users: $e");
     // awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

 

  void onUserSelected(String userTypeId, String companyId, String userId) {
    selectedUserTypeId.value = userTypeId;
    selectedCompanyId.value = companyId;
    selectedUserId.value = userId;
    isUserSelected.value = true;
   
      fetchSelectedHolidays();
    
  }

  

  Future<void> fetchSelectedHolidays() async {
    isLoading.value = true;
    try {
       final tokens = await StorageServices().read('token');
      final response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_EMPLOYEE_SELECTED_HOLIDAYS)
            .replace(queryParameters: {
              "user_id": selectedUserId.value
         
        }),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $tokens", 
        },
      );
     seletedHolidays.clear();
      if (response.statusCode == 200) {
         var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        seletedHolidays.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return EmployeeSelectedHoliday.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();

      } else if(response.statusCode==404) {
       
        awesomeOkDialog(message: "No Optional Holiday Found");
         seletedHolidays.value = []; 
       
      }else{
          throw Exception('Failed to load selected holiday for user '); 
      }
    } catch (e) {
      print("Error fetching menus: $e");
     //  awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

 // Toggles the selection of a main menu and its associated submenus

}
