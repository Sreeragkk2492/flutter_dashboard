import 'dart:convert';

import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/company_models/company_menu_model.dart';
import 'package:flutter_dashboard/models/usertype_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class CompanyMenuController extends GetxController {

   // Observable variables for managing state

  var employeemenus = CompanyMenuModel(
          userTypeId: '',
          companyId: '',
          menus: [],
          remarks: '',
          status: '',
          isActive: false)
      .obs;
  var isLoading = false.obs;
  var isUserTypeSelected = false.obs;
  //var isUserTypeSelected = false.obs;
  var selectedmenus = <String>[].obs;
  var selectedsubmenu = <String>[].obs;
  var userTypes = <UserType>[].obs;
  var menus = <Menu>[].obs;
  var submenus = <SubMenu>[].obs;
  var selectedUserTypeId = ''.obs;
  var selectedCompanyId = ''.obs;
  var selectedUserId = ''.obs;
  var filteredMenus = <Menu>[].obs;
  var remarks = ''.obs;
  var isCompanySelected = false.obs;
  var isUserSelected = false.obs;

@override
  void onInit() {
    super.onInit();
   //fetchUserType();
    resetMenuSelectionState();
    resetSelectionState();
  }

 // Reset menu selection state

   void resetMenuSelectionState() {
    menus.clear();
    filteredMenus.clear();
    isUserTypeSelected.value = false;
    selectedUserTypeId.value = '';
  }

  // Reset selection state

  void resetSelectionState() {
    isCompanySelected.value = false;
    isUserTypeSelected.value = false;
    selectedCompanyId.value = '';
    selectedUserTypeId.value = '';
    filteredMenus.clear();
  }

 // Handle company selection

   void onCompanySelected(String companyId) {
    selectedCompanyId.value = companyId;
    isCompanySelected.value = true;
    isUserSelected.value = false;
    selectedUserTypeId.value = '';
    filteredMenus.clear();
    fetchUserType();
  }

// Handle user type selection

  void onUserTypeSelected(String userTypeId,) {
    selectedUserTypeId.value = userTypeId;
    isUserTypeSelected.value = true;
  
      if (isCompanySelected.value && isUserTypeSelected.value) {
      fetchMenusForUser();
    }
  
  }

 // Fetch user types

   fetchUserType() async {
    try {
      // Making the GET request to the API
      var response = await http
          .get(Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_USERTYPE));
      if (response.statusCode == 200) {
        // Decoding the JSON response body into a List
        var jsonData = json.decode(response.body) as List;
        // Mapping the List to a List of Department objects
        userTypes.value = jsonData.map((jsonItem) {
          if (jsonItem is Map<String, dynamic>) {
            return UserType.fromJson(jsonItem);
          } else {
            throw Exception("Unexpected data format");
          }
        }).toList();
      }
    } catch (e) {
      print("Error$e");
    }
  }

 // Fetch menus for selected user type and company

   Future<void> fetchMenusForUser() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY_MENU)
            .replace(queryParameters: {
          "user_type_id": selectedUserTypeId.value,
          "company_id": selectedCompanyId.value,
        }),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final employeemenulist = CompanyMenuModel.fromJson(data);
        employeemenus.value = employeemenulist;
        menus.value = employeemenulist.menus;

        filteredMenus.value =
            menus.where((menu) => menu.isSelected).map((menu) {
          return Menu(
            mainMenuId: menu.mainMenuId,
            mainMenuName: menu.mainMenuName,
            isSelected: menu.isSelected,
            subMenus:
                menu.subMenus.where((subMenu) => subMenu.isSelected).toList(),
          );
        }).toList();
      } else {
        throw Exception('Failed to load menus for user type');
      }
    } catch (e) {
      print("Error fetching menus: $e");
      awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

 // Toggle main menu selection

  void toggleMainMenu(String mainMenuId) {
    final index = menus.indexWhere((menu) => menu.mainMenuId == mainMenuId);
    if (index != -1) {
      final newIsSelected = !menus[index].isSelected;
      menus[index].isSelected = newIsSelected;
      for (var subMenu in menus[index].subMenus) {
        toggleSubMenu(mainMenuId, subMenu.subMenuId, forceValue: newIsSelected);
      }
      menus.refresh();
    }
  }

   // Toggle submenu selection

  void toggleSubMenu(String mainMenuId, String subMenuId, {bool? forceValue}) {
    final mainMenuIndex = menus.indexWhere((menu) => menu.mainMenuId == mainMenuId);
    if (mainMenuIndex != -1) {
      final subMenuIndex = menus[mainMenuIndex].subMenus.indexWhere((subMenu) => subMenu.subMenuId == subMenuId);
      if (subMenuIndex != -1) {
        final newIsSelected = forceValue ?? !menus[mainMenuIndex].subMenus[subMenuIndex].isSelected;
        menus[mainMenuIndex].subMenus[subMenuIndex].isSelected = newIsSelected;
        
        // Update the main menu selection based on submenu selections
        updateMainMenuSelection(mainMenuId);
      }
    }
    menus.refresh();
  }

 // Update main menu selection based on submenu selections

  void updateMainMenuSelection(String mainMenuId) {
    final index = menus.indexWhere((menu) => menu.mainMenuId == mainMenuId);
    if (index != -1) {
      final anySubMenuSelected = menus[index].subMenus.any((subMenu) => subMenu.isSelected);
      menus[index].isSelected = anySubMenuSelected;
    }
  }

 // Add menu for selected company and user type

  Future<void> addMenu() async {
    isLoading.value = true;
    try {
      final requestBody = {
        "user_type_id": selectedUserTypeId.value,
        "company_id": selectedCompanyId.value,
        "menus": menus
            .map((menu) => {
                  "main_menu_id": menu.mainMenuId,
                  "main_menu_name": menu.mainMenuName,
                  "is_selected": menu.isSelected ||
                      menu.subMenus.any((subMenu) => subMenu.isSelected),
                  "sub_menus": menu.subMenus
                      .map((subMenu) => {
                            "sub_menu_id": subMenu.subMenuId,
                            "sub_menu_name": subMenu.subMenuName,
                            "is_selected": subMenu.isSelected
                          })
                      .toList()
                })
            .where((menu) =>
                menu["is_selected"] == true ||
                (menu["sub_menus"] as List<Map<String, dynamic>>)
                    .any((subMenu) => subMenu["is_selected"] == true))
            .toList(),
        "remarks": remarks.value,
        "status": "Active",
        "is_active": true
      };

      final result = await NetWorkManager.shared().request(
          url: ApiUrls.BASE_URL + ApiUrls.ADD_COMPANY_MENU,
          method: 'post',
          isAuthRequired: true,
          data: requestBody);

      if (result.isLeft) {
        awesomeOkDialog(message: result.left.message);
      } else {
       await awesomeOkDialog(message: "Menu added successfully");
        Get.back();
      }
    } catch (e) {
      print("Error adding menu: $e");
      awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
