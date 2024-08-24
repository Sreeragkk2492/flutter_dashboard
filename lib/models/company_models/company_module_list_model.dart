// To parse this JSON data, do
//
//     final companyModuleList = companyModuleListFromJson(jsonString);

import 'dart:convert';

List<CompanyModuleList> companyModuleListFromJson(String str) => List<CompanyModuleList>.from(json.decode(str).map((x) => CompanyModuleList.fromJson(x)));

String companyModuleListToJson(List<CompanyModuleList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyModuleList {
    String id;
    String remarks;
    String status;
    bool isActive;
    String companyId;
    String moduleId;
    Company company;
    Modules modules;

    CompanyModuleList({
        required this.id,
        required this.remarks,
        required this.status,
        required this.isActive,
        required this.companyId,
        required this.moduleId,
        required this.company,
        required this.modules,
    });

    factory CompanyModuleList.fromJson(Map<String, dynamic> json) => CompanyModuleList(
        id: json["id"],
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
        companyId: json["company_id"],
        moduleId: json["module_id"],
        company: Company.fromJson(json["company"]),
        modules: Modules.fromJson(json["modules"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
        "company_id": companyId,
        "module_id": moduleId,
        "company": company.toJson(),
        "modules": modules.toJson(),
    };
}

class Company {
    String id;
    String companyName;
    String companyCode;
    String databaseName;
    String companyTypeId;
    dynamic remarks;
    dynamic status;
    dynamic isActive;
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

class Modules {
    String id;
    String moduleName;
    String status;
    bool isActive;

    Modules({
        required this.id,
        required this.moduleName,
        required this.status,
        required this.isActive,
    });

    factory Modules.fromJson(Map<String, dynamic> json) => Modules(
        id: json["id"],
        moduleName: json["module_name"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "module_name": moduleName,
        "status": status,
        "is_active": isActive,
    };
}
