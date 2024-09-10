// To parse this JSON data, do
//
//     final showAllowanceAndDeductionUserModel = showAllowanceAndDeductionUserModelFromJson(jsonString);

import 'dart:convert';

ShowAllowanceAndDeductionUserModel showAllowanceAndDeductionUserModelFromJson(String str) => ShowAllowanceAndDeductionUserModel.fromJson(json.decode(str));

String showAllowanceAndDeductionUserModelToJson(ShowAllowanceAndDeductionUserModel data) => json.encode(data.toJson());

class ShowAllowanceAndDeductionUserModel {
    String companyId;
    String userId;
    String employeeId;
    List<Allowance> allowance;
    List<Deduction> deduction;
    String remarks;
    String status;
    bool isActive;

    ShowAllowanceAndDeductionUserModel({
        required this.companyId,
        required this.userId,
        required this.employeeId,
        required this.allowance,
        required this.deduction,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory ShowAllowanceAndDeductionUserModel.fromJson(Map<String, dynamic> json) => ShowAllowanceAndDeductionUserModel(
        companyId: json["company_id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        allowance: List<Allowance>.from(json["allowance"].map((x) => Allowance.fromJson(x))),
        deduction: List<Deduction>.from(json["deduction"].map((x) => Deduction.fromJson(x))),
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

class Allowance {
    String allowanceId;
    String allowance;
    int amount;

    Allowance({
        required this.allowanceId,
        required this.allowance,
        required this.amount,
    });

    factory Allowance.fromJson(Map<String, dynamic> json) => Allowance(
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

class Deduction {
    String deductionId;
    String deduction;
    int amount;

    Deduction({
        required this.deductionId,
        required this.deduction,
        required this.amount,
    });

    factory Deduction.fromJson(Map<String, dynamic> json) => Deduction(
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
