// To parse this JSON data, do
//
//     final companyProcessingDate = companyProcessingDateFromJson(jsonString);

import 'dart:convert';

List<CompanyProcessingDate> companyProcessingDateFromJson(String str) => List<CompanyProcessingDate>.from(json.decode(str).map((x) => CompanyProcessingDate.fromJson(x)));

String companyProcessingDateToJson(List<CompanyProcessingDate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyProcessingDate {
    String id;
    String companyId;
    String processingDay;
    String status;
    bool isActive;

    CompanyProcessingDate({
        required this.id,
        required this.companyId,
        required this.processingDay,
        required this.status,
        required this.isActive,
    });

    factory CompanyProcessingDate.fromJson(Map<String, dynamic> json) => CompanyProcessingDate(
        id: json["id"],
        companyId: json["company_id"],
        processingDay: json["processing_day"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "processing_day": processingDay,
        "status": status,
        "is_active": isActive,
    };
}
