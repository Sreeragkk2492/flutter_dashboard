// To parse this JSON data, do
//
//     final attendanceDetails = attendanceDetailsFromJson(jsonString);

import 'dart:convert';

AttendanceDetails attendanceDetailsFromJson(String str) => AttendanceDetails.fromJson(json.decode(str));

String attendanceDetailsToJson(AttendanceDetails data) => json.encode(data.toJson());

class AttendanceDetails {
    List<AttendanceDatum> attendanceData;
    String totalWorkedTime;
    String totalOverShortTime;

    AttendanceDetails({
        required this.attendanceData,
        required this.totalWorkedTime,
        required this.totalOverShortTime,
    });

    factory AttendanceDetails.fromJson(Map<String, dynamic> json) => AttendanceDetails(
        attendanceData: List<AttendanceDatum>.from(json["attendance_data"].map((x) => AttendanceDatum.fromJson(x))),
        totalWorkedTime: json["total_worked_time"],
        totalOverShortTime: json["total_over_short_time"],
    );

    Map<String, dynamic> toJson() => {
        "attendance_data": List<dynamic>.from(attendanceData.map((x) => x.toJson())),
        "total_worked_time": totalWorkedTime,
        "total_over_short_time": totalOverShortTime,
    };
}

class AttendanceDatum {
    DateTime date;
    String? inTime;
    String? outTime;
    String? workedTime;
    String? overShortTime;
    dynamic attendanceDatumOverShortTime;

    AttendanceDatum({
        required this.date,
        required this.inTime,
        required this.outTime,
        required this.workedTime,
        this.overShortTime,
        this.attendanceDatumOverShortTime,
    });

    factory AttendanceDatum.fromJson(Map<String, dynamic> json) => AttendanceDatum(
        date: DateTime.parse(json["date"]),
        inTime: json["in_time"],
        outTime: json["out_time"],
        workedTime: json["worked_time"],
        overShortTime: json["over/short_time"],
        attendanceDatumOverShortTime: json["over_short_time"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "in_time": inTime,
        "out_time": outTime,
        "worked_time": workedTime,
        "over/short_time": overShortTime,
        "over_short_time": attendanceDatumOverShortTime,
    };
}