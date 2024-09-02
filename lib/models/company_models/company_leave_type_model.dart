// To parse this JSON data, do
//
//     final companyLeaveTypeModel = companyLeaveTypeModelFromJson(jsonString);

import 'dart:convert';

List<CompanyLeaveTypeModel> companyLeaveTypeModelFromJson(String str) => List<CompanyLeaveTypeModel>.from(json.decode(str).map((x) => CompanyLeaveTypeModel.fromJson(x)));

String companyLeaveTypeModelToJson(List<CompanyLeaveTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyLeaveTypeModel {
    String id;
    String companyId;
    String type;
    bool isActive;
    dynamic deactivatedById;

    CompanyLeaveTypeModel({
        required this.id,
        required this.companyId,
        required this.type,
        required this.isActive,
        required this.deactivatedById,
    });

    factory CompanyLeaveTypeModel.fromJson(Map<String, dynamic> json) => CompanyLeaveTypeModel(
        id: json["id"],
        companyId: json["company_id"],
        type: json["type"],
        isActive: json["is_active"],
        deactivatedById: json["deactivated_by_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "type": type,
        "is_active": isActive,
        "deactivated_by_id": deactivatedById,
    };
}
