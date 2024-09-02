import 'package:flutter/material.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_module_controller.dart';
import 'package:get/get.dart';



//to clear the page when navigated
class ResetCompanyModule extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != Routes.COMAPANYMODULE) {
      Get.put(CompanyModuleController()).resetSelection();
    }
    return null;
  }
}