// To parse this JSON data, do
//
//     final allowance = allowanceFromJson(jsonString);

import 'dart:convert';

List<Allowance> allowanceFromJson(String str) => List<Allowance>.from(json.decode(str).map((x) => Allowance.fromJson(x)));

String allowanceToJson(List<Allowance> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Allowance {
    String id;
    String allowanceName;
    String remarks;
    String status;
    bool isActive;

    Allowance({
        required this.id,
        required this.allowanceName,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory Allowance.fromJson(Map<String, dynamic> json) => Allowance(
        id: json["id"],
        allowanceName: json["allowance_name"],
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "allowance_name": allowanceName,
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}
