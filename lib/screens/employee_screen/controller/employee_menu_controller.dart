import 'dart:convert';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/employee_menu_model.dart';
import 'package:flutter_dashboard/models/user_model.dart';
import 'package:flutter_dashboard/models/usertype_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmployeeMenuController extends GetxController {
  var employeemenus = EmployeeMenuModel(
          userTypeId: '',
          companyId: '',
          userId: '',
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
  var filteredUsers = <UserModel>[].obs;
  var companydetails = <Company>[].obs;
  var users = <UserModel>[].obs;
  var filteredMenus = <Menu>[].obs;
  var remarks = ''.obs;
  var isCompanySelected = false.obs;
  var isUserSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
    resetMenuSelectionState();
    resetSelectionState();
  }

  void resetMenuSelectionState() {
    menus.clear();
    filteredMenus.clear();
    isUserSelected.value = false;
    selectedUserId.value = '';
    selectedUserTypeId.value = '';
  }

  void resetSelectionState() {
    isCompanySelected.value = false;
    isUserSelected.value = false;
    selectedCompanyId.value = '';
    selectedUserId.value = '';
    filteredMenus.clear();
  }

  void onCompanySelected(String companyId) {
    selectedCompanyId.value = companyId;
    isCompanySelected.value = true;
    isUserSelected.value = false;
    selectedUserId.value = '';
    filteredMenus.clear();
    fetchUsersForCompany(companyId);
  }

  Future<void> fetchCompanies() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_COMPANY),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
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

  Future<void> fetchUsersForCompany(String companyId) async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_ALL_USER_BY_COMPANY_ID)
            .replace(queryParameters: {"company_id": selectedCompanyId.value}),
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
      awesomeOkDialog(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void onUserSelected(String userTypeId, String companyId, String userId) {
    selectedUserTypeId.value = userTypeId;
    selectedCompanyId.value = companyId;
    selectedUserId.value = userId;
    isUserSelected.value = true;
    if (isCompanySelected.value && isUserSelected.value) {
      fetchMenusForUser();
    }
  }

  Future<void> fetchMenusForUser() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(ApiUrls.BASE_URL + ApiUrls.GET_EMPLOYEE_MENU)
            .replace(queryParameters: {
          "user_type_id": selectedUserTypeId.value,
          "company_id": selectedCompanyId.value,
          "user_id": selectedUserId.value
        }),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final employeemenulist = EmployeeMenuModel.fromJson(data);
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

  void toggleSubMenu(String mainMenuId, String subMenuId, {bool? forceValue}) {
    final mainMenuIndex =
        menus.indexWhere((menu) => menu.mainMenuId == mainMenuId);
    if (mainMenuIndex != -1) {
      final subMenuIndex = menus[mainMenuIndex]
          .subMenus
          .indexWhere((subMenu) => subMenu.subMenuId == subMenuId);
      if (subMenuIndex != -1) {
        final newIsSelected = forceValue ??
            !menus[mainMenuIndex].subMenus[subMenuIndex].isSelected;
        menus[mainMenuIndex].subMenus[subMenuIndex].isSelected = newIsSelected;

        // Update the main menu selection based on submenu selections
        updateMainMenuSelection(mainMenuId);
      }
    }
    menus.refresh();
  }

  void updateMainMenuSelection(String mainMenuId) {
    final index = menus.indexWhere((menu) => menu.mainMenuId == mainMenuId);
    if (index != -1) {
      final anySubMenuSelected =
          menus[index].subMenus.any((subMenu) => subMenu.isSelected);
      menus[index].isSelected = anySubMenuSelected;
    }
  }

  Future<void> addMenu() async {
    isLoading.value = true;
    try {
      final requestBody = {
        "user_type_id": selectedUserTypeId.value,
        "company_id": selectedCompanyId.value,
        "user_id": selectedUserId.value,
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
          url: ApiUrls.BASE_URL + ApiUrls.ADD_EMPLOYEE_MENU,
          method: 'post',
          isAuthRequired: true,
          data: requestBody);

      if (result.isLeft) {
        awesomeOkDialog(message: result.left.message);
      } else {
        awesomeOkDialog(message: "Menu added successfully");
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