// To parse this JSON data, do
//
//     final employeeMenuModel = employeeMenuModelFromJson(jsonString);

import 'dart:convert';

EmployeeMenuModel employeeMenuModelFromJson(String str) => EmployeeMenuModel.fromJson(json.decode(str));

String employeeMenuModelToJson(EmployeeMenuModel data) => json.encode(data.toJson());

class EmployeeMenuModel {
    String userTypeId;
    String companyId;
    String userId;
    List<Menu> menus;
    String remarks;
    String status;
    bool isActive;

    EmployeeMenuModel({
        required this.userTypeId,
        required this.companyId,
        required this.userId,
        required this.menus,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory EmployeeMenuModel.fromJson(Map<String, dynamic> json) => EmployeeMenuModel(
        userTypeId: json["user_type_id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "user_type_id": userTypeId,
        "company_id": companyId,
        "user_id": userId,
        "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}

class Menu {
    String mainMenuId;
    String mainMenuName;
    bool isSelected;
    List<SubMenu> subMenus;

    Menu({
        required this.mainMenuId,
        required this.mainMenuName,
        required this.isSelected,
        required this.subMenus,
    });

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        mainMenuId: json["main_menu_id"],
        mainMenuName: json["main_menu_name"],
        isSelected: json["is_selected"],
        subMenus: List<SubMenu>.from(json["sub_menus"].map((x) => SubMenu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "main_menu_id": mainMenuId,
        "main_menu_name": mainMenuName,
        "is_selected": isSelected,
        "sub_menus": List<dynamic>.from(subMenus.map((x) => x.toJson())),
    };
}

class SubMenu {
    String subMenuId;
    String subMenuName;
    bool isSelected;

    SubMenu({
        required this.subMenuId,
        required this.subMenuName,
        required this.isSelected,
    });

    factory SubMenu.fromJson(Map<String, dynamic> json) => SubMenu(
        subMenuId: json["sub_menu_id"],
        subMenuName: json["sub_menu_name"],
        isSelected: json["is_selected"],
    );

    Map<String, dynamic> toJson() => {
        "sub_menu_id": subMenuId,
        "sub_menu_name": subMenuName,
        "is_selected": isSelected,
    };
}
