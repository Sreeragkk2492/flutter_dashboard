import 'dart:convert';

class PayrollModel {
  final String userId;
  final int year;
  final String id;
  final int month;
  final String companyId;
  final PayrollData payrollData;

  PayrollModel({
    required this.userId,
    required this.year,
    required this.id,
    required this.month,
    required this.companyId,
    required this.payrollData,
  });

  factory PayrollModel.fromJson(Map<String, dynamic> json) {
    return PayrollModel(
      userId: json['user_id'],
      year: json['year'],
      id: json['id'],
      month: json['month'],
      companyId: json['company_id'],
      payrollData: PayrollData.fromJson(
        // Converting string to Map using dart:convert
        json['payroll_data'] is String 
          ? Map<String, dynamic>.from(
              jsonDecode(json['payroll_data'].replaceAll("'", '"'))
            )
          : json['payroll_data'],
      ),
    );
  }
}

class PayrollData {
    String? companyId;
    String? userId;
    String? userName;
    String? name;
    int? phoneNumber;
    String? address;
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
    List<dynamic>? allowances;
    List<dynamic>? deductions;

    PayrollData({
        this.companyId,
        this.userId,
        this.userName,
        this.name,
        this.phoneNumber,
        this.address,
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

    factory PayrollData.fromJson(Map<String, dynamic> json) => PayrollData(
        companyId: json["company_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
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
        allowances: json["allowances"] == null ? [] : List<dynamic>.from(json["allowances"]!.map((x) => x)),
        deductions: json["deductions"] == null ? [] : List<dynamic>.from(json["deductions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "user_id": userId,
        "user_name": userName,
        "name": name,
        "phone_number": phoneNumber,
        "address": address,
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
        "allowances": allowances == null ? [] : List<dynamic>.from(allowances!.map((x) => x)),
        "deductions": deductions == null ? [] : List<dynamic>.from(deductions!.map((x) => x)),
    };
}

class Allowance {
  final String id;
  final String allowanceName;
  final double amount;

  Allowance({
    required this.id,
    required this.allowanceName,
    required this.amount,
  });

  factory Allowance.fromJson(Map<String, dynamic> json) {
    return Allowance(
      id: json['id'].toString(),
      allowanceName: json['allowance_name'],
      amount: json['amount']?.toDouble() ?? 0.0,
    );
  }
}

class Deductions {
  final String id;
  final String deductionName;
  final double amount;

  Deductions({
    required this.id,
    required this.deductionName,
    required this.amount,
  });

  factory Deductions.fromJson(Map<String, dynamic> json) {
    return Deductions(
      id: json['id'].toString(),
      deductionName: json['deduction_name'],
      amount: json['amount']?.toDouble() ?? 0.0,
    );
  }
}