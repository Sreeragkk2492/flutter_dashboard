// To parse this JSON data, do
//
//     final userType = userTypeFromJson(jsonString);

import 'dart:convert';

List<UserType> userTypeFromJson(String str) => List<UserType>.from(json.decode(str).map((x) => UserType.fromJson(x)));

String userTypeToJson(List<UserType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserType {
    String id;
    String name;

    UserType({
        required this.id,
        required this.name,
    });

    factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
