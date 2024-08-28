// To parse this JSON data, do
//
//     final companyModuleList = companyModuleListFromJson(jsonString);

import 'dart:convert';

CompanyModuleList companyModuleListFromJson(String str) => CompanyModuleList.fromJson(json.decode(str));

String companyModuleListToJson(CompanyModuleList data) => json.encode(data.toJson());

class CompanyModuleList {
    String companyId;
    List<CompanyModule> companyModules;
    String remarks;
    String status;
    bool isActive;

    CompanyModuleList({
        required this.companyId,
        required this.companyModules,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory CompanyModuleList.fromJson(Map<String, dynamic> json) => CompanyModuleList(
        companyId: json["company_id"],
        companyModules: List<CompanyModule>.from(json["company_modules"].map((x) => CompanyModule.fromJson(x))),
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "company_modules": List<dynamic>.from(companyModules.map((x) => x.toJson())),
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}

class CompanyModule {
    String moduleId;
    String moduleName;
    bool isSelected;

    CompanyModule({
        required this.moduleId,
        required this.moduleName,
        required this.isSelected,
    });

    factory CompanyModule.fromJson(Map<String, dynamic> json) => CompanyModule(
        moduleId: json["module_id"],
        moduleName: json["module_name"],
        isSelected: json["is_selected"],
    );

    Map<String, dynamic> toJson() => {
        "module_id": moduleId,
        "module_name": moduleName,
        "is_selected": isSelected,
    };
}
