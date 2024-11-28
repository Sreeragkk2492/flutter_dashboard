// To parse this JSON data, do
//
//     final employeeSelectedHoliday = employeeSelectedHolidayFromJson(jsonString);

import 'dart:convert';

List<EmployeeSelectedHoliday> employeeSelectedHolidayFromJson(String str) => List<EmployeeSelectedHoliday>.from(json.decode(str).map((x) => EmployeeSelectedHoliday.fromJson(x)));

String employeeSelectedHolidayToJson(List<EmployeeSelectedHoliday> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeSelectedHoliday {
    DateTime date;
    String? description;

    EmployeeSelectedHoliday({
       required this.date,
        this.description,
    });

    factory EmployeeSelectedHoliday.fromJson(Map<String, dynamic> json) => EmployeeSelectedHoliday(
        date: DateTime.parse(json["date"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "description": description,
    };
}
