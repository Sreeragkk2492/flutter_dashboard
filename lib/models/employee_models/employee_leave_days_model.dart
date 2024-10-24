import 'dart:convert';

LeaveDays leaveDaysFromJson(String str) => LeaveDays.fromJson(json.decode(str));

String leaveDaysToJson(LeaveDays data) => json.encode(data.toJson());

class LeaveDays {
  List<LeaveReport> leaveReport;
  int totalLeaves;

  LeaveDays({
    required this.leaveReport,
    required this.totalLeaves,
  });

  factory LeaveDays.fromJson(Map<String, dynamic> json) => LeaveDays(
    leaveReport: json["leave_report"] != null 
      ? List<LeaveReport>.from(json["leave_report"].map((x) => LeaveReport.fromJson(x)))
      : [],
    totalLeaves: json["total_leaves"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "leave_report": List<dynamic>.from(leaveReport.map((x) => x.toJson())),
    "total_leaves": totalLeaves,
  };
}

class LeaveReport {
  DateTime leaveDate;
  String reason;
  String typeOfLeave;

  LeaveReport({
    required this.leaveDate,
    required this.reason,
    required this.typeOfLeave,
  });

  factory LeaveReport.fromJson(Map<String, dynamic> json) => LeaveReport(
    leaveDate: DateTime.tryParse(json["leave_date"] ?? "") ?? DateTime.now(),
    reason: json["reason"] ?? "",
    typeOfLeave: json["type_of_leave"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "leave_date": "${leaveDate.year.toString().padLeft(4, '0')}-${leaveDate.month.toString().padLeft(2, '0')}-${leaveDate.day.toString().padLeft(2, '0')}",
    "reason": reason,
    "type_of_leave": typeOfLeave,
  };
}