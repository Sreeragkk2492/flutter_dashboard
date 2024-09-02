// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

List<Company> companyFromJson(String str) => List<Company>.from(json.decode(str).map((x) => Company.fromJson(x)));

String companyToJson(List<Company> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Company {
    String id;
    String companyName;
    String companyCode;
    String databaseName;
    String companyTypeId;
    String? remarks;
    String? status;
    bool? isActive;
    Companytype companytype;

    Company({
        required this.id,
        required this.companyName,
        required this.companyCode,
        required this.databaseName,
        required this.companyTypeId,
        required this.remarks,
        required this.status,
        required this.isActive,
        required this.companytype,
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        companyName: json["company_name"],
        companyCode: json["company_code"],
        databaseName: json["database_name"],
        companyTypeId: json["company_type_id"],
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
        companytype: Companytype.fromJson(json["companytype"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "company_code": companyCode,
        "database_name": databaseName,
        "company_type_id": companyTypeId,
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
        "companytype": companytype.toJson(),
    };
}

class Companytype {
    String id;
    String name;
    String remarks;
    String status;
    bool isActive;

    Companytype({
        required this.id,
        required this.name,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory Companytype.fromJson(Map<String, dynamic> json) => Companytype(
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
