// To parse this JSON data, do
//
//     final prApplicationModule = prApplicationModuleFromJson(jsonString);

import 'dart:convert';

List<PrApplicationModule> prApplicationModuleFromJson(String str) => List<PrApplicationModule>.from(json.decode(str).map((x) => PrApplicationModule.fromJson(x)));

String prApplicationModuleToJson(List<PrApplicationModule> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrApplicationModule {
    String id;
    String moduleName;
    String status;
    bool isActive;

    PrApplicationModule({
        required this.id,
        required this.moduleName,
        required this.status,
        required this.isActive,
    });

    factory PrApplicationModule.fromJson(Map<String, dynamic> json) => PrApplicationModule(
        id: json["id"],
        moduleName: json["module_name"],
        status: json["status"],
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "module_name": moduleName,
        "status": status,
        "is_active": isActive,
    };
}
