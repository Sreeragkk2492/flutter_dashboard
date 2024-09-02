// To parse this JSON data, do
//
//     final companyHolidayModel = companyHolidayModelFromJson(jsonString);

import 'dart:convert';

List<CompanyHolidayModel> companyHolidayModelFromJson(String str) => List<CompanyHolidayModel>.from(json.decode(str).map((x) => CompanyHolidayModel.fromJson(x)));

String companyHolidayModelToJson(List<CompanyHolidayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyHolidayModel {
    String id;
    DateTime date;
    String description;
    String leaveTypeId;
    bool isActive;

    CompanyHolidayModel({
        required this.id,
        required this.date,
        required this.description,
        required this.leaveTypeId,
        required this.isActive,
    });

    factory CompanyHolidayModel.fromJson(Map<String, dynamic> json) => CompanyHolidayModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        leaveTypeId: json["leave_type_id"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "description": description,
        "leave_type_id": leaveTypeId,
        "is_active": isActive,
    };
}
