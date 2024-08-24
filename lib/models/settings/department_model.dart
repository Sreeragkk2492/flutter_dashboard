// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromJson(jsonString);

import 'dart:convert';

List<DepartmentModel> departmentModelFromJson(String str) => List<DepartmentModel>.from(json.decode(str).map((x) => DepartmentModel.fromJson(x)));

String departmentModelToJson(List<DepartmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentModel {
    String id;
    String departmentName;
    String companyTypeId;
    String categoryIndustry;
    String remarks;
    String status;
    bool isActive;

    DepartmentModel({
        required this.id,
        required this.departmentName,
        required this.companyTypeId,
        required this.categoryIndustry,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory DepartmentModel.fromJson(Map<String, dynamic> json) => DepartmentModel(
        id: json["id"],
        departmentName: json["department_name"],
        companyTypeId: json["company_type_id"],
        categoryIndustry: json["category/industry"],
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
        "company_type_id": companyTypeId,
        "category/industry": categoryIndustry,
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}
