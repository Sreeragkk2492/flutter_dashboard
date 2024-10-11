import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String id;
  String userName;
  String name;
  dynamic employeeFirstName;
  dynamic employeeLastName;
  String? fatherName;
  String? motherName;
  String? address;
  int? phoneNumber;
  DateTime? dob;
  DateTime? joiningDate;
  String? employeeId;
  String companyId;
  String userTypeId;
  dynamic designationId;
  String? empCategoryId;
  String? biometricId;
  String? reportingToId;

  UserModel({
    required this.id,
    required this.userName,
    required this.name,
    this.employeeFirstName,
    this.employeeLastName,
    this.fatherName,
    this.motherName,
    this.address,
    this.phoneNumber,
    this.dob,
    this.joiningDate,
    this.employeeId,
    required this.companyId,
    required this.userTypeId,
    this.designationId,
    this.empCategoryId,
    this.biometricId,
    this.reportingToId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"].toString(),
    userName: json["user_name"] ?? '',
    name: json["name"] ?? '',
    employeeFirstName: json["employee_first_name"],
    employeeLastName: json["employee_last_name"],
    fatherName: json["father_name"],
    motherName: json["mother_name"],
    address: json["address"],
    phoneNumber: json["phone_number"] != null ? int.tryParse(json["phone_number"].toString()) : null,
    dob: json["dob"] != null ? DateTime.tryParse(json["dob"]) : null,
    joiningDate: json["joining_date"] != null ? DateTime.tryParse(json["joining_date"]) : null,
    employeeId: json["employee_id"],
    companyId: json["company_id"].toString(),
    userTypeId: json["user_type_id"].toString(),
    designationId: json["designation_id"],
    empCategoryId: json["emp_category_id"],
    biometricId: json["biometric_id"],
    reportingToId: json["reporting_to_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "name": name,
    "employee_first_name": employeeFirstName,
    "employee_last_name": employeeLastName,
    "father_name": fatherName,
    "mother_name": motherName,
    "address": address,
    "phone_number": phoneNumber,
    "dob": dob?.toIso8601String(),
    "joining_date": joiningDate?.toIso8601String(),
    "employee_id": employeeId,
    "company_id": companyId,
    "user_type_id": userTypeId,
    "designation_id": designationId,
    "emp_category_id": empCategoryId,
    "biometric_id": biometricId,
    "reporting_to_id": reportingToId,
  };
}