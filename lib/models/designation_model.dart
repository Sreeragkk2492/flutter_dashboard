// To parse this JSON data, do
//
//     final designation = designationFromJson(jsonString);

import 'dart:convert';

List<Designation> designationFromJson(String str) => List<Designation>.from(json.decode(str).map((x) => Designation.fromJson(x)));

String designationToJson(List<Designation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Designation {
    String id;
    String designation;

    Designation({
        required this.id,
        required this.designation,
    });

    factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        designation: json["designation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "designation": designation,
    };
}
