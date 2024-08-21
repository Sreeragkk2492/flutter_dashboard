// To parse this JSON data, do
//
//     final department = departmentFromJson(jsonString);

import 'dart:convert';

List<Department> departmentFromJson(String str) => List<Department>.from(json.decode(str).map((x) => Department.fromJson(x)));

String departmentToJson(List<Department> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Department {
    String id;
    String departmentName;
    String remarks;
    String status;
    bool isActive;

    Department({
        required this.id,
        required this.departmentName,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        departmentName: json["department_name"],
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}
