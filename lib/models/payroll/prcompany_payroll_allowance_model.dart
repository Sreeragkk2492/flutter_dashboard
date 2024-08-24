class CompanyPayrollAllowancesModel {
  String companyId;
  List<Allowance> allowance;
  String remarks;
  String status;
  bool isActive;

  CompanyPayrollAllowancesModel({
    required this.companyId,
    required this.allowance,
    required this.remarks,
    required this.status,
    required this.isActive,
  });

  factory CompanyPayrollAllowancesModel.fromJson(Map<String, dynamic> json) {
    return CompanyPayrollAllowancesModel(
      companyId: json['company_id'] ?? '',
      allowance: (json['allowance'] as List<dynamic>?)
          ?.map((e) => Allowance.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      remarks: json['remarks'] ?? '',
      status: json['status'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}

class Allowance {
  String allowanceId;
  String allowance;
  bool isSelected;

  Allowance({
    required this.allowanceId,
    required this.allowance,
    required this.isSelected,
  });

  factory Allowance.fromJson(Map<String, dynamic> json) {
    return Allowance(
      allowanceId: json['allowance_id'] ?? '',
      allowance: json['allowance'] ?? '',
      isSelected: json['is_selected'] ?? false,
    );
  }
}