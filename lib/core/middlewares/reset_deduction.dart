import 'package:flutter/material.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/payroll/controller/company_payroll_deduction_controller.dart';
import 'package:get/get.dart';

class ResetDeductionMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != Routes.CompanyDeductionDetails) {
      Get.put(CompanyPayrollDeductionController()).resetSelection();
    }
    return null;
  }
}
