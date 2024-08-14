// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

List<Company> companyFromJson(String str) => List<Company>.from(json.decode(str).map((x) => Company.fromJson(x)));

String companyToJson(List<Company> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Company {
    String id;
    String companyName;
    String companyCode;
    String databaseName;
    Companytype companytype;

    Company({
        required this.id,
        required this.companyName,
        required this.companyCode,
        required this.databaseName,
        required this.companytype,
    });

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        companyName: json["company_name"],
        companyCode: json["company_code"],
        databaseName: json["database_name"],
        companytype: Companytype.fromJson(json["companytype"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "company_code": companyCode,
        "database_name": databaseName,
        "companytype": companytype.toJson(),
    };
}

class Companytype {
    String id;
    String name;

    Companytype({
        required this.id,
        required this.name,
    });

    factory Companytype.fromJson(Map<String, dynamic> json) => Companytype(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
