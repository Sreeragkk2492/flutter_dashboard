// To parse this JSON data, do
//
//     final prCompanyPayrollAllowance = prCompanyPayrollAllowanceFromJson(jsonString);

import 'dart:convert';

List<PrCompanyPayrollAllowance> prCompanyPayrollAllowanceFromJson(String str) => List<PrCompanyPayrollAllowance>.from(json.decode(str).map((x) => PrCompanyPayrollAllowance.fromJson(x)));

String prCompanyPayrollAllowanceToJson(List<PrCompanyPayrollAllowance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrCompanyPayrollAllowance {
    String id;
    String companyId;
    String payrollAllowanceId;
    String rremarks;
    String status;
    bool isActive;

    PrCompanyPayrollAllowance({
        required this.id,
        required this.companyId,
        required this.payrollAllowanceId,
        required this.rremarks,
        required this.status,
        required this.isActive,
    });

    factory PrCompanyPayrollAllowance.fromJson(Map<String, dynamic> json) => PrCompanyPayrollAllowance(
        id: json["id"],
        companyId: json["company_id"],
        payrollAllowanceId: json["payroll_allowance_id"],
        rremarks: json["rremarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "payroll_allowance_id": payrollAllowanceId,
        "rremarks": rremarks,
        "status": status,
        "is_active": isActive,
    };
}
