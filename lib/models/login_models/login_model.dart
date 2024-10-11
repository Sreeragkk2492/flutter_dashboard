// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    String token;
    String companyId;

    Login({
        required this.token,
        required this.companyId,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        token: json["token"],
        companyId: json["company_id"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "company_id": companyId,
    };
}
