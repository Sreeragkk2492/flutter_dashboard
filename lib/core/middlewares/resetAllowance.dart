import 'package:flutter/material.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/payroll/controller/company_payroll_allowance_controller.dart';
import 'package:get/get.dart';

class ResetAllowanceMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != Routes.CompanyAllowanceDetails) {
      Get.put(CompanyPayrollAllowanceController()).resetSelection();
    }
    return null;
  }
}
