// To parse this JSON data, do
//
//     final attendenceDetails = attendenceDetailsFromJson(jsonString);

import 'dart:convert';

AttendenceDetails attendenceDetailsFromJson(String str) => AttendenceDetails.fromJson(json.decode(str));

String attendenceDetailsToJson(AttendenceDetails data) => json.encode(data.toJson());

class AttendenceDetails {
    List<AttendanceDatum>? attendanceData;
    String? totalWorkedTime;
    String? totalOverShortTime;

    AttendenceDetails({
        this.attendanceData,
        this.totalWorkedTime,
        this.totalOverShortTime,
    });

    factory AttendenceDetails.fromJson(Map<String, dynamic> json) => AttendenceDetails(
        attendanceData: json["attendance_data"] == null ? [] : List<AttendanceDatum>.from(json["attendance_data"]!.map((x) => AttendanceDatum.fromJson(x))),
        totalWorkedTime: json["total_worked_time"],
        totalOverShortTime: json["total_over_short_time"],
    );

    Map<String, dynamic> toJson() => {
        "attendance_data": attendanceData == null ? [] : List<dynamic>.from(attendanceData!.map((x) => x.toJson())),
        "total_worked_time": totalWorkedTime,
        "total_over_short_time": totalOverShortTime,
    };
}

class AttendanceDatum {
    DateTime date;
    String? day;
    String? remarks;
    dynamic inTime;
    dynamic outTime;
    dynamic workedTime;
    dynamic overShortTime;

    AttendanceDatum({
        required this.date,
        this.day,
        this.remarks,
        this.inTime,
        this.outTime,
        this.workedTime,
        this.overShortTime,
    });

    factory AttendanceDatum.fromJson(Map<String, dynamic> json) => AttendanceDatum(
        date:  DateTime.parse(json["date"]),
        day: json["day"],
        remarks: json["remarks"],
        inTime: json["in_time"],
        outTime: json["out_time"],
        workedTime: json["worked_time"],
        overShortTime: json["over_short_time"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "day": day,
        "remarks": remarks,
        "in_time": inTime,
        "out_time": outTime,
        "worked_time": workedTime,
        "over_short_time": overShortTime,
    };
}
