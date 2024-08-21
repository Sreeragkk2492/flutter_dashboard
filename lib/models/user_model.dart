// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    String userName;
    String name;
    dynamic employeeFirstName;
    dynamic employeeLastName;
    String? fatherName;
    String? motherName;
    String? address;
    int? phoneNumber;
    DateTime dob;
    DateTime joiningDate;
    String employeeId;
    String companyId;
    String userTypeId;
    dynamic designationId;
    String empCategoryId;
    String biometricId;
    String reportingToId;

    User({
        required this.userName,
        required this.name,
        required this.employeeFirstName,
        required this.employeeLastName,
        required this.fatherName,
        required this.motherName,
        required this.address,
        required this.phoneNumber,
        required this.dob,
        required this.joiningDate,
        required this.employeeId,
        required this.companyId,
        required this.userTypeId,
        required this.designationId,
        required this.empCategoryId,
        required this.biometricId,
        required this.reportingToId,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userName: json["user_name"],
        name: json["name"],
        employeeFirstName: json["employee_first_name"],
        employeeLastName: json["employee_last_name"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        dob: DateTime.parse(json["dob"]),
        joiningDate: DateTime.parse(json["joining_date"]),
        employeeId: json["employee_id"],
        companyId: json["company_id"],
        userTypeId: json["user_type_id"],
        designationId: json["designation_id"],
        empCategoryId: json["emp_category_id"],
        biometricId: json["biometric_id"],
        reportingToId: json["reporting_to_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_name": userName,
        "name": name,
        "employee_first_name": employeeFirstName,
        "employee_last_name": employeeLastName,
        "father_name": fatherName,
        "mother_name": motherName,
        "address": address,
        "phone_number": phoneNumber,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "joining_date": "${joiningDate.year.toString().padLeft(4, '0')}-${joiningDate.month.toString().padLeft(2, '0')}-${joiningDate.day.toString().padLeft(2, '0')}",
        "employee_id": employeeId,
        "company_id": companyId,
        "user_type_id": userTypeId,
        "designation_id": designationId,
        "emp_category_id": empCategoryId,
        "biometric_id": biometricId,
        "reporting_to_id": reportingToId,
    };
}
