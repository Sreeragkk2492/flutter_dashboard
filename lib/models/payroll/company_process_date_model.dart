// To parse this JSON data, do
//
//     final companyProcessingDate = companyProcessingDateFromJson(jsonString);

import 'dart:convert';

List<CompanyProcessingDate> companyProcessingDateFromJson(String str) => List<CompanyProcessingDate>.from(json.decode(str).map((x) => CompanyProcessingDate.fromJson(x)));

String companyProcessingDateToJson(List<CompanyProcessingDate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyProcessingDate {
    String id;
    String companyId;
    String companyName;
    DateTime processingDay;
    String status;
    bool isActive;

    CompanyProcessingDate({
        required this.id,
        required this.companyId,
        required this.companyName,
        required this.processingDay,
        required this.status,
        required this.isActive,
    });

    factory CompanyProcessingDate.fromJson(Map<String, dynamic> json) => CompanyProcessingDate(
        id: json["id"],
        companyId: json["company_id"],
        companyName: json["company_name"],
        processingDay: DateTime.parse(json["processing_day"]),
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "company_name": companyName,
        "processing_day": "${processingDay.year.toString().padLeft(4, '0')}-${processingDay.month.toString().padLeft(2, '0')}-${processingDay.day.toString().padLeft(2, '0')}",
        "status": status,
        "is_active": isActive,
    };
}
