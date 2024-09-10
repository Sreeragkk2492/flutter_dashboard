// To parse this JSON data, do
//
//     final getAllowaceAndDeductionForAddModel = getAllowaceAndDeductionForAddModelFromJson(jsonString);

import 'dart:convert';

GetAllowaceAndDeductionForAddModel getAllowaceAndDeductionForAddModelFromJson(String str) => GetAllowaceAndDeductionForAddModel.fromJson(json.decode(str));

String getAllowaceAndDeductionForAddModelToJson(GetAllowaceAndDeductionForAddModel data) => json.encode(data.toJson());

class GetAllowaceAndDeductionForAddModel {
    String companyId;
    String userId;
    String employeeId;
    List<Allowances> allowance;
    List<Deductions> deduction;
    String remarks;
    String status;
    bool isActive;

    GetAllowaceAndDeductionForAddModel({
        required this.companyId,
        required this.userId,
        required this.employeeId,
        required this.allowance,
        required this.deduction,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory GetAllowaceAndDeductionForAddModel.fromJson(Map<String, dynamic> json) => GetAllowaceAndDeductionForAddModel(
        companyId: json["company_id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        allowance: List<Allowances>.from(json["allowance"].map((x) => Allowances.fromJson(x))),
        deduction: List<Deductions>.from(json["deduction"].map((x) => Deductions.fromJson(x))),
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "user_id": userId,
        "employee_id": employeeId,
        "allowance": List<dynamic>.from(allowance.map((x) => x.toJson())),
        "deduction": List<dynamic>.from(deduction.map((x) => x.toJson())),
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}

class Allowances {
    String allowanceId;
    String allowance;
    int amount;

    Allowances({
        required this.allowanceId,
        required this.allowance,
        required this.amount,
    });

    factory Allowances.fromJson(Map<String, dynamic> json) => Allowances(
        allowanceId: json["allowance_id"],
        allowance: json["allowance"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "allowance_id": allowanceId,
        "allowance": allowance,
        "amount": amount,
    };
}

class Deductions {
    String deductionId;
    String deduction;
    int amount;

    Deductions({
        required this.deductionId,
        required this.deduction,
        required this.amount,
    });

    factory Deductions.fromJson(Map<String, dynamic> json) => Deductions(
        deductionId: json["deduction_id"],
        deduction: json["deduction"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "deduction_id": deductionId,
        "deduction": deduction,
        "amount": amount,
    };
}
