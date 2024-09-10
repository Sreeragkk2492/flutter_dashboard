import 'package:flutter/material.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_leavetype_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/employee_payroll_settings_controller.dart';
import 'package:get/get.dart';



//to clear the page when navigated
class ResetEmployeePayroll extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != Routes.EmployeePayrollSettings) {
      Get.put(EmployeePayrollSettingsController()).resetSelectionState();
    }
    return null;
  }
}
