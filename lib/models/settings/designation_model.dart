// To parse this JSON data, do
//
//     final designation = designationFromJson(jsonString);

import 'dart:convert';

List<Designation> designationFromJson(String str) => List<Designation>.from(json.decode(str).map((x) => Designation.fromJson(x)));

String designationToJson(List<Designation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Designation {
    String id;
    String designation;
    String departmentId;
    String departmentName;
    String companyTypeId;
    String companyTypeName;
    String remarks;
    String status;
    bool isActive;

    Designation({
        required this.id,
        required this.designation,
        required this.departmentId,
        required this.departmentName,
        required this.companyTypeId,
        required this.companyTypeName,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        designation: json["designation"],
        departmentId: json["department_id"],
        departmentName: json["department_name"],
        companyTypeId: json["company_type_id"],
        companyTypeName: json["company_type_name "],
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "designation": designation,
        "department_id": departmentId,
        "department_name": departmentName,
        "company_type_id": companyTypeId,
        "company_type_name ": companyTypeName,
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}
