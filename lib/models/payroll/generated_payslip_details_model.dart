// To parse this JSON data, do
//
//     final generatedPayslipDetails = generatedPayslipDetailsFromJson(jsonString);

import 'dart:convert';

GeneratedPayslipDetails generatedPayslipDetailsFromJson(String str) => GeneratedPayslipDetails.fromJson(json.decode(str));

String generatedPayslipDetailsToJson(GeneratedPayslipDetails data) => json.encode(data.toJson());

class GeneratedPayslipDetails {
    PayslipDetails payslipDetails;
     int totalAllowances;
    int totalDeductions;

    GeneratedPayslipDetails({
        required this.payslipDetails,
         required this.totalAllowances,
        required this.totalDeductions,
    });

    factory GeneratedPayslipDetails.fromJson(Map<String, dynamic> json) => GeneratedPayslipDetails(
        payslipDetails: PayslipDetails.fromJson(json["payslip_details"]),
         totalAllowances: json["total_allowances"],
        totalDeductions: json["total_deductions"],
    );

    Map<String, dynamic> toJson() => {
        "payslip_details": payslipDetails.toJson(),
         "total_allowances": totalAllowances,
        "total_deductions": totalDeductions,
    };
}

class PayslipDetails {
    String? id;
    String? companyId;
    String? userId;
    String? employeeId;
    int? year;
    int? month;
    DateTime? payperiodStartDate;
    DateTime? payperiodEndDate;
    DateTime? paydate;
    String? paymentMethod;
    int? totalAmount;
    int? overtimeHours;
    int? regularHours;
    int? currentMonthLeaves;
    int? lopLeaveDays;
    int? paidLeaves;
    int? totalTakenPaidLeaves;
    int? allowedPaidLeaves;
    int? holidays;
    int? workfromhomeDays;
    String? projectCode;
    String? location;
    String? department;
    String? remarks;
    bool? approved;
    String? approvedBy;
    String? payslipFileName;
    String? status;
    bool? isActive;
    List<Allowance>? allowances;
    List<Deduction>? deductions;

    PayslipDetails({
        this.id,
        this.companyId,
        this.userId,
        this.employeeId,
        this.year,
        this.month,
        this.payperiodStartDate,
        this.payperiodEndDate,
        this.paydate,
        this.paymentMethod,
        this.totalAmount,
        this.overtimeHours,
        this.regularHours,
        this.currentMonthLeaves,
        this.lopLeaveDays,
        this.paidLeaves,
        this.totalTakenPaidLeaves,
        this.allowedPaidLeaves,
        this.holidays,
        this.workfromhomeDays,
        this.projectCode,
        this.location,
        this.department,
        this.remarks,
        this.approved,
        this.approvedBy,
        this.payslipFileName,
        this.status,
        this.isActive,
        this.allowances,
        this.deductions,
    });

    factory PayslipDetails.fromJson(Map<String, dynamic> json) => PayslipDetails(
        id: json["id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        year: json["year"],
        month: json["month"],
        payperiodStartDate: json["payperiod_start_date"] == null ? null : DateTime.parse(json["payperiod_start_date"]),
        payperiodEndDate: json["payperiod_end_date"] == null ? null : DateTime.parse(json["payperiod_end_date"]),
        paydate: json["paydate"] == null ? null : DateTime.parse(json["paydate"]),
        paymentMethod: json["payment_method"],
        totalAmount: json["total_amount"],
        overtimeHours: json["overtime_hours"],
        regularHours: json["regular_hours"],
        currentMonthLeaves: json["current_month_leaves"],
        lopLeaveDays: json["lop_leave_days"],
        paidLeaves: json["paid_leaves"],
        totalTakenPaidLeaves: json["total_taken_paid_leaves"],
        allowedPaidLeaves: json["allowed_paid_leaves"],
        holidays: json["holidays"],
        workfromhomeDays: json["workfromhome_days"],
        projectCode: json["project_code"],
        location: json["location"],
        department: json["department"],
        remarks: json["remarks"],
        approved: json["approved"],
        approvedBy: json["approved_by"],
        payslipFileName: json["payslip_file_name"],
        status: json["status"],
        isActive: json["is_active"],
        allowances: json["allowances"] == null ? [] : List<Allowance>.from(json["allowances"]!.map((x) => Allowance.fromJson(x))),
        deductions: json["deductions"] == null ? [] : List<Deduction>.from(json["deductions"]!.map((x) => Deduction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "user_id": userId,
        "employee_id": employeeId,
        "year": year,
        "month": month,
        "payperiod_start_date": "${payperiodStartDate!.year.toString().padLeft(4, '0')}-${payperiodStartDate!.month.toString().padLeft(2, '0')}-${payperiodStartDate!.day.toString().padLeft(2, '0')}",
        "payperiod_end_date": "${payperiodEndDate!.year.toString().padLeft(4, '0')}-${payperiodEndDate!.month.toString().padLeft(2, '0')}-${payperiodEndDate!.day.toString().padLeft(2, '0')}",
        "paydate": "${paydate!.year.toString().padLeft(4, '0')}-${paydate!.month.toString().padLeft(2, '0')}-${paydate!.day.toString().padLeft(2, '0')}",
        "payment_method": paymentMethod,
        "total_amount": totalAmount,
        "overtime_hours": overtimeHours,
        "regular_hours": regularHours,
        "current_month_leaves": currentMonthLeaves,
        "lop_leave_days": lopLeaveDays,
        "paid_leaves": paidLeaves,
        "total_taken_paid_leaves": totalTakenPaidLeaves,
        "allowed_paid_leaves": allowedPaidLeaves,
        "holidays": holidays,
        "workfromhome_days": workfromhomeDays,
        "project_code": projectCode,
        "location": location,
        "department": department,
        "remarks": remarks,
        "approved": approved,
        "approved_by": approvedBy,
        "payslip_file_name": payslipFileName,
        "status": status,
        "is_active": isActive,
        "allowances": allowances == null ? [] : List<dynamic>.from(allowances!.map((x) => x.toJson())),
        "deductions": deductions == null ? [] : List<dynamic>.from(deductions!.map((x) => x.toJson())),
    };
}

class Allowance {
    String id;
    String allowanceName;
    int amount;

    Allowance({
        required this.id,
        required this.allowanceName,
        required this.amount,
    });

    factory Allowance.fromJson(Map<String, dynamic> json) => Allowance(
        id: json["id"],
        allowanceName: json["allowance_name"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "allowance_name": allowanceName,
        "amount": amount,
    };
}

class Deduction {
    String id;
    String deductionName;
    int amount;

    Deduction({
        required this.id,
        required this.deductionName,
        required this.amount,
    });

    factory Deduction.fromJson(Map<String, dynamic> json) => Deduction(
        id: json["id"],
        deductionName: json["deduction_name"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "deduction_name": deductionName,
        "amount": amount,
    };
}
