// To parse this JSON data, do
//
//     final departmentByCompanyId = departmentByCompanyIdFromJson(jsonString);

import 'dart:convert';

List<DepartmentByCompanyId> departmentByCompanyIdFromJson(String str) => List<DepartmentByCompanyId>.from(json.decode(str).map((x) => DepartmentByCompanyId.fromJson(x)));

String departmentByCompanyIdToJson(List<DepartmentByCompanyId> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepartmentByCompanyId {
    String id;
    String departmentName;
    String companyTypeId;
    String remarks;
    String status;

    DepartmentByCompanyId({
        required this.id,
        required this.departmentName,
        required this.companyTypeId,
        required this.remarks,
        required this.status,
    });

    factory DepartmentByCompanyId.fromJson(Map<String, dynamic> json) => DepartmentByCompanyId(
        id: json["id"],
        departmentName: json["department_name"],
        companyTypeId: json["company_type_id"],
        remarks: json["remarks"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
        "company_type_id": companyTypeId,
        "remarks": remarks,
        "status": status,
    };
}
