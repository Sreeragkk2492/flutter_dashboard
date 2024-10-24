import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_menu_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class ConditionalCompanyWidget extends StatelessWidget {
  final EmployeeController employeeController = Get.put(EmployeeController());
  final EmployeeMenuController screenController = Get.put(EmployeeMenuController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (employeeController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      
      if (employeeController.companydetails.isEmpty) {
        return Center(child: Text("No companies available"));
      }

      if (employeeController.isSuperAdmin.value) {
        return FormBuilderDropdown<Company>(
          name: 'Company Name',
          decoration: InputDecoration(
            labelText: 'Company Name',
            hintText: 'Select Company',
            labelStyle:
                    TextStyle(color: AppColors.blackColor),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.greycolor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.defaultColor,
                        width: 1.5)),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: FormBuilderValidators.required(),
          items: employeeController.companydetails
              .map((company) => DropdownMenuItem(
                    value: company,
                    child: Text(company.companyName),
                  ))
              .toList(),
          onChanged: (value) {
            screenController.onCompanySelected(value!.id);
          },
        );
      } else {
        final company = employeeController.companydetails.firstOrNull;  ///if doesnt work use companydetails[0];
        return FormBuilderTextField(
          name: 'Company Name',
          initialValue: company!.companyName,///remove the null check
          decoration: InputDecoration(
            labelText: 'Company Name',
             labelStyle:
                    TextStyle(color: AppColors.blackColor),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.greycolor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.defaultColor,
                        width: 1.5)),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          readOnly: true,
        );
      }
    });
  }
}