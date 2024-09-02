import 'package:flutter/material.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_menu_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_menu_controller.dart';
import 'package:get/get.dart';


//to clear the page when navigated

class ResetCompanyMenu extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != Routes.CompanyMenuList) {
      Get.put(CompanyMenuController()).resetSelectionState();
    }
    return null;
  }
}