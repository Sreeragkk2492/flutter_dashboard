// To parse this JSON data, do
//
//     final department = departmentFromJson(jsonString);

import 'dart:convert';

List<Department> departmentFromJson(String str) => List<Department>.from(json.decode(str).map((x) => Department.fromJson(x)));

String departmentToJson(List<Department> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Department {
    String id;
    String departmentName; 

    Department({
        required this.id,
        required this.departmentName,
    });

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"]as String, 
        departmentName: json["department_name"]as String,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
    };
}
