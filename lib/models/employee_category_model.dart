// To parse this JSON data, do
//
//     final employeeCategory = employeeCategoryFromJson(jsonString);

import 'dart:convert';

List<EmployeeCategory> employeeCategoryFromJson(String str) => List<EmployeeCategory>.from(json.decode(str).map((x) => EmployeeCategory.fromJson(x)));

String employeeCategoryToJson(List<EmployeeCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeCategory {
    String id;
    String name;

    EmployeeCategory({
        required this.id,
        required this.name,
    });

    factory EmployeeCategory.fromJson(Map<String, dynamic> json) => EmployeeCategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
