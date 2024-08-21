// To parse this JSON data, do
//
//     final industry = industryFromJson(jsonString);

import 'dart:convert';

List<Industry> industryFromJson(String str) => List<Industry>.from(json.decode(str).map((x) => Industry.fromJson(x)));

String industryToJson(List<Industry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Industry {
    String id;
    String name;
    String remarks;
    String status;
    bool isActive;

    Industry({
        required this.id,
        required this.name,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        id: json["id"],
        name: json["name"],
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}
