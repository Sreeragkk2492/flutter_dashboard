// To parse this JSON data, do
//
//     final companyPayrollDeductionModel = companyPayrollDeductionModelFromJson(jsonString);

import 'dart:convert';

CompanyPayrollDeductionModel companyPayrollDeductionModelFromJson(String str) => CompanyPayrollDeductionModel.fromJson(json.decode(str));

String companyPayrollDeductionModelToJson(CompanyPayrollDeductionModel data) => json.encode(data.toJson());

class CompanyPayrollDeductionModel {
    String companyId;
    List<Deduction> deduction;
    String remarks;
    String status;
    bool isActive;

    CompanyPayrollDeductionModel({
        required this.companyId,
        required this.deduction,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory CompanyPayrollDeductionModel.fromJson(Map<String, dynamic> json) => CompanyPayrollDeductionModel(
        companyId: json["company_id"],
        deduction: List<Deduction>.from(json["deduction"].map((x) => Deduction.fromJson(x))),
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "deduction": List<dynamic>.from(deduction.map((x) => x.toJson())),
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}

class Deduction {
    String deductionId;
    String deduction;
    bool isSelected;

    Deduction({
        required this.deductionId,
        required this.deduction,
        required this.isSelected,
    });

    factory Deduction.fromJson(Map<String, dynamic> json) => Deduction(
        deductionId: json["deduction_id"],
        deduction: json["deduction"],
        isSelected: json["is_selected"],
    );

    Map<String, dynamic> toJson() => {
        "deduction_id": deductionId,
        "deduction": deduction,
        "is_selected": isSelected,
    };
}
