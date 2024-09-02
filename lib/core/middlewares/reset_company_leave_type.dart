import 'package:flutter/material.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_leavetype_controller.dart';
import 'package:get/get.dart';



//to clear the page when navigated
class ResetCompanyLeaveType extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != Routes.COMPANYLEAVETYPE) {
      Get.put(CompanyLeavetypeController()).resetSelectionState();
    }
    return null;
  }
}
