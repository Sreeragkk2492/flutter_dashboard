import 'package:flutter/material.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_menu_controller.dart';
import 'package:get/get.dart';

class ResetEmployeeMenuMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != Routes.EmployeeMenu) {
      Get.put(EmployeeMenuController()).resetSelectionState();
    }
    return null;
  }
}
