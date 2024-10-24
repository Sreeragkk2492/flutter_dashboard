import 'package:flutter/material.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/payroll/controller/payroll_settings_controller.dart';
import 'package:get/get.dart';



//to clear the page when navigated

class ResetEmployeePayslipDetails extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != Routes.AddEmployeePayslipGeneration) {
      Get.put(PayrollSettingsController()).resetSelection();
    }
    return null;
  }
}
