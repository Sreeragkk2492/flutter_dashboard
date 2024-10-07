// To parse this JSON data, do
//
//     final reportingId = reportingIdFromJson(jsonString);

import 'dart:convert';

List<ReportingId> reportingIdFromJson(String str) => List<ReportingId>.from(json.decode(str).map((x) => ReportingId.fromJson(x)));

String reportingIdToJson(List<ReportingId> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportingId {
    String id;
    String userName;

    ReportingId({
        required this.id,
        required this.userName,
    });

    factory ReportingId.fromJson(Map<String, dynamic> json) => ReportingId(
        id: json["id"],
        userName: json["user_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
    };
}
