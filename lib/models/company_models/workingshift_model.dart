// To parse this JSON data, do
//
//     final workingShiftModel = workingShiftModelFromJson(jsonString);

import 'dart:convert';

List<WorkingShiftModel> workingShiftModelFromJson(String str) => List<WorkingShiftModel>.from(json.decode(str).map((x) => WorkingShiftModel.fromJson(x)));

String workingShiftModelToJson(List<WorkingShiftModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkingShiftModel {
    String id;
    String companyId;
    String shiftName;
    String startTime;
    String endTime;
    String description;

    WorkingShiftModel({
        required this.id,
        required this.companyId,
        required this.shiftName,
        required this.startTime,
        required this.endTime,
        required this.description,
    });

    factory WorkingShiftModel.fromJson(Map<String, dynamic> json) => WorkingShiftModel(
        id: json["id"],
        companyId: json["company_id"],
        shiftName: json["shift_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "shift_name": shiftName,
        "start_time": startTime,
        "end_time": endTime,
        "description": description,
    };
}
