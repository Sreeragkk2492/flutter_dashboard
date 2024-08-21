// To parse this JSON data, do
//
//     final employeeCategory = employeeCategoryFromJson(jsonString);

import 'dart:convert';

List<EmployeeCategory> employeeCategoryFromJson(String str) => List<EmployeeCategory>.from(json.decode(str).map((x) => EmployeeCategory.fromJson(x)));

String employeeCategoryToJson(List<EmployeeCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeCategory {
    String id;
    String name;
    String? remarks;
    String? status;
    bool? isActive;

    EmployeeCategory({
        required this.id,
        required this.name,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory EmployeeCategory.fromJson(Map<String, dynamic> json) => EmployeeCategory(
        id: json["id"],
        name: json["name"],
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}
