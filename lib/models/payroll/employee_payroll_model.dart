import 'dart:convert';

EmployeePayroll employeePayrollFromJson(String str) =>
    EmployeePayroll.fromJson(json.decode(str));

String employeePayrollToJson(EmployeePayroll data) =>
    json.encode(data.toJson());

class EmployeePayroll {
  String name;
  String details;
  String approved;
  String total;
  List<CompanyPayroll> companyPayrolls;
  List<PayslipDetail> payslipDetails;

  EmployeePayroll({
    required this.name,
    required this.details,
    required this.approved,
    required this.total,
    required this.companyPayrolls,
    required this.payslipDetails,
  });

  factory EmployeePayroll.fromJson(Map<String, dynamic> json) =>
      EmployeePayroll(
        name: json["Name"],
        details: json["Details"],
        approved: json["approved"],
        total: json["total"],
        companyPayrolls: List<CompanyPayroll>.from(
            json["Company_payrolls"].map((x) => CompanyPayroll.fromJson(x))),
        payslipDetails: List<PayslipDetail>.from(
            json["Payslip_details"].map((x) => PayslipDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Details": details,
        "approved": approved,
        "total": total,
        "Company_payrolls":
            List<dynamic>.from(companyPayrolls.map((x) => x.toJson())),
        "Payslip_details":
            List<dynamic>.from(payslipDetails.map((x) => x.toJson())),
      };
}

class CompanyPayroll {
  String? allowanceId;
  String? allowance;
  String? deductionId;
  String? deduction;

  CompanyPayroll({
    this.allowanceId,
    this.allowance,
    this.deductionId,
    this.deduction,
  });

  factory CompanyPayroll.fromJson(Map<String, dynamic> json) => CompanyPayroll(
        allowanceId: json["allowance_id"],
        allowance: json["allowance"],
        deductionId: json["deduction_id"],
        deduction: json["deduction"],
      );

  Map<String, dynamic> toJson() => {
        "allowance_id": allowanceId,
        "allowance": allowance,
        "deduction_id": deductionId,
        "deduction": deduction,
      };
}

class PayslipDetail {
  String companyId;
  String userId;
  String userName;
  String name;
  int? phoneNumber;
  String? address;
  String employeeId;
  int year;
  int month;
  DateTime payperiodStartDate;
  DateTime payperiodEndDate;
  DateTime paydate;
  String paymentMethod;
  int totalAmount;
  int overtimeHours;
  int regularHours;
  int leavedays;
  int holidays;
  int workfromhomeDays;
  String projectCode;
  String location;
  String department;
  String remarks;
  bool approved;
  String approvedBy;
  String payslipFileName;
  String status;
  bool isActive;
  List<AllowanceElement> allowances;
  List<Deduction> deductions;

  PayslipDetail({
    required this.companyId,
    required this.userId,
    required this.userName,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.employeeId,
    required this.year,
    required this.month,
    required this.payperiodStartDate,
    required this.payperiodEndDate,
    required this.paydate,
    required this.paymentMethod,
    required this.totalAmount,
    required this.overtimeHours,
    required this.regularHours,
    required this.leavedays,
    required this.holidays,
    required this.workfromhomeDays,
    required this.projectCode,
    required this.location,
    required this.department,
    required this.remarks,
    required this.approved,
    required this.approvedBy,
    required this.payslipFileName,
    required this.status,
    required this.isActive,
    required this.allowances,
    required this.deductions,
  });

  factory PayslipDetail.fromJson(Map<String, dynamic> json) => PayslipDetail(
        companyId: json["company_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        employeeId: json["employee_id"],
        year: json["year"],
        month: json["month"],
        payperiodStartDate: DateTime.parse(json["payperiod_start_date"]),
        payperiodEndDate: DateTime.parse(json["payperiod_end_date"]),
        paydate: DateTime.parse(json["paydate"]),
        paymentMethod: json["payment_method"],
        totalAmount: json["total_amount"],
        overtimeHours: json["overtime_hours"],
        regularHours: json["regular_hours"],
        leavedays: json["leavedays"],
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
        allowances: List<AllowanceElement>.from(
            json["allowances"].map((x) => AllowanceElement.fromJson(x))),
        deductions: List<Deduction>.from(
            json["deductions"].map((x) => Deduction.fromJson(x))),
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
        "payperiod_start_date":
            "${payperiodStartDate.year.toString().padLeft(4, '0')}-${payperiodStartDate.month.toString().padLeft(2, '0')}-${payperiodStartDate.day.toString().padLeft(2, '0')}",
        "payperiod_end_date":
            "${payperiodEndDate.year.toString().padLeft(4, '0')}-${payperiodEndDate.month.toString().padLeft(2, '0')}-${payperiodEndDate.day.toString().padLeft(2, '0')}",
        "paydate":
            "${paydate.year.toString().padLeft(4, '0')}-${paydate.month.toString().padLeft(2, '0')}-${paydate.day.toString().padLeft(2, '0')}",
        "payment_method": paymentMethod,
        "total_amount": totalAmount,
        "overtime_hours": overtimeHours,
        "regular_hours": regularHours,
        "leavedays": leavedays,
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
        "allowances": List<dynamic>.from(allowances.map((x) => x.toJson())),
        "deductions": List<dynamic>.from(deductions.map((x) => x.toJson())),
      };
}

class AllowanceElement {
  String id;
  String allowanceName;
  int amount;

  AllowanceElement({
    required this.id,
    required this.allowanceName,
    required this.amount,
  });

  factory AllowanceElement.fromJson(Map<String, dynamic> json) =>
      AllowanceElement(
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
