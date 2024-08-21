// To parse this JSON data, do
//
//     final deduction = deductionFromJson(jsonString);

import 'dart:convert';

List<Deduction> deductionFromJson(String str) => List<Deduction>.from(json.decode(str).map((x) => Deduction.fromJson(x)));

String deductionToJson(List<Deduction> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Deduction {
    String id;
    String deductionName;
    String remarks;
    String status;
    bool isActive;

    Deduction({
        required this.id,
        required this.deductionName,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory Deduction.fromJson(Map<String, dynamic> json) => Deduction(
        id: json["id"],
        deductionName: json["deduction_name"],
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "deduction_name": deductionName,
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}
