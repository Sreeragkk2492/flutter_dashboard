// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    UserDetail userDetail;
    CompDetails compDetails;
    Approvals approvals;
    AttendanceDetails attendanceDetails;
    List<dynamic> showMenus;

    LoginModel({
        required this.userDetail,
        required this.compDetails,
        required this.approvals,
        required this.attendanceDetails,
        required this.showMenus,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        userDetail: UserDetail.fromJson(json["user_detail"]),
        compDetails: CompDetails.fromJson(json["comp_details"]),
        approvals: Approvals.fromJson(json["approvals"]),
        attendanceDetails: AttendanceDetails.fromJson(json["attendance_details"]),
        showMenus: List<dynamic>.from(json["show_menus"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user_detail": userDetail.toJson(),
        "comp_details": compDetails.toJson(),
        "approvals": approvals.toJson(),
        "attendance_details": attendanceDetails.toJson(),
        "show_menus": List<dynamic>.from(showMenus.map((x) => x)),
    };
}

class Approvals {
    int attendanceRequests;
    int leaveRequests;
    int total;

    Approvals({
        required this.attendanceRequests,
        required this.leaveRequests,
        required this.total,
    });

    factory Approvals.fromJson(Map<String, dynamic> json) => Approvals(
        attendanceRequests: json["attendance_requests"],
        leaveRequests: json["leave_requests"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "attendance_requests": attendanceRequests,
        "leave_requests": leaveRequests,
        "total": total,
    };
}

class AttendanceDetails {
    int totalWorkingDays;
    int present;
    int missingPunch;
    int leave;
    String todaySpendtime;
    List<dynamic> todaysEntries;

    AttendanceDetails({
        required this.totalWorkingDays,
        required this.present,
        required this.missingPunch,
        required this.leave,
        required this.todaySpendtime,
        required this.todaysEntries,
    });

    factory AttendanceDetails.fromJson(Map<String, dynamic> json) => AttendanceDetails(
        totalWorkingDays: json["total_working_days"],
        present: json["present"],
        missingPunch: json["missing_punch"],
        leave: json["leave"],
        todaySpendtime: json["today_spendtime"],
        todaysEntries: List<dynamic>.from(json["todays_entries"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "total_working_days": totalWorkingDays,
        "present": present,
        "missing_punch": missingPunch,
        "leave": leave,
        "today_spendtime": todaySpendtime,
        "todays_entries": List<dynamic>.from(todaysEntries.map((x) => x)),
    };
}

class CompDetails {
    String id;
    String name;
    String cmpTypeId;
    String cmpTypeName;

    CompDetails({
        required this.id,
        required this.name,
        required this.cmpTypeId,
        required this.cmpTypeName,
    });

    factory CompDetails.fromJson(Map<String, dynamic> json) => CompDetails(
        id: json["id"],
        name: json["name"],
        cmpTypeId: json["cmp_type_id"],
        cmpTypeName: json["cmp_type_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cmp_type_id": cmpTypeId,
        "cmp_type_name": cmpTypeName,
    };
}

class UserDetail {
    String token;
    String id;
    String name;
    String typeId;
    String typeName;

    UserDetail({
        required this.token,
        required this.id,
        required this.name,
        required this.typeId,
        required this.typeName,
    });

    factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        token: json["token"],
        id: json["id"],
        name: json["name"],
        typeId: json["type_id"],
        typeName: json["type_name"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
        "name": name,
        "type_id": typeId,
        "type_name": typeName,
    };
}
