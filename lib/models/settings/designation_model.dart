// To parse this JSON data, do
//
//     final designation = designationFromJson(jsonString);

import 'dart:convert';

List<Designation> designationFromJson(String str) => List<Designation>.from(json.decode(str).map((x) => Designation.fromJson(x)));

String designationToJson(List<Designation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Designation {
    String id;
    String designation;
    String remarks;
    String status;
    bool isActive;

    Designation({
        required this.id,
        required this.designation,
        required this.remarks,
        required this.status,
        required this.isActive,
    });

    factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        designation: json["designation"],
        remarks: json["remarks"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "designation": designation,
        "remarks": remarks,
        "status": status,
        "is_active": isActive,
    };
}
