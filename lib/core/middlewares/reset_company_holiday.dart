import 'package:flutter/material.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_holiday_list_controller.dart';
import 'package:get/get.dart';


//to clear the page when navigated
class ResetCompanyHoliday extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route != Routes.COMPANYHOLIDAY) {
      Get.put(CompanyHolidayListController()).resetSelectionState();
    }
    return null;
  }
}