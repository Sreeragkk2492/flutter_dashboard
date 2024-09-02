import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';

import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/company_payroll_allowance_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../models/company_models/company_models.dart';

class CompanyAllowanceDetails extends StatelessWidget {
  CompanyAllowanceDetails({super.key});
  final _dataTableHorizontalScrollController = ScrollController();
  final screenController = Get.put(CompanyPayrollAllowanceController());
  final employeecontroller = Get.put(EmployeeController());
  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: 'Company Allowance Details',
            subtitle: '',
            icon: Icon(Icons.rocket),
            buttonTitle: 'Add Company Allowance Details',
            onClick: () {
              Get.toNamed(Routes.AddCompanyAllowanceDetails);
            },
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Obx(
            () => FormBuilderDropdown<Company>(
              // controller: widget.companyNameController,
              name: 'Company Name',
              decoration: const InputDecoration(
                labelText: 'Company Name',
                hintText: 'Company Name',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              // enableSuggestions: false,
              // keyboardType: TextInputType.name,
              validator: FormBuilderValidators.required(),
              items: employeecontroller.companydetails
                  .map((company) => DropdownMenuItem(
                        value: Company(
                            id: company.id,
                            companyName: company.companyName,
                            companyCode: company.companyCode,
                            databaseName: company.databaseName,
                            companyTypeId: company.companyTypeId,
                            remarks: company.remarks,
                            status: company.status,
                            isActive: company.isActive,
                            companytype: company.companytype),
                        child: Text(company.companyName),
                      ))
                  .toList(),
              onChanged: (value) {
                screenController.onCompanySelected(
                    value!.id, value.companyCode);
              },
              // onSaved: (value) => (_formData.firstname = value ?? ''),
            ),
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        Obx(() {
          if(!screenController.hasExplicitlySelectedCompany.value){
             return Center(
                  child: Text("Please select a company to view allowances."),
             );
          }
          else if (!screenController.isCompanySelected.value) {
            return Center(
                child: Text("Please select a company to view allowances."));
          } else if (screenController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Filter only selected allowances
            final selectedAllowances = screenController.companyAllowances
                .where((allowance) => allowance.isSelected)
                .toList();

            if (selectedAllowances.isEmpty) {
              return Center(
                  child: Text("No selected allowances for this company."));
            } else {
              return Padding(
                  padding: EdgeInsets.only(
                      bottom: kDefaultPadding / 2,
                      top: kDefaultPadding,
                      left: kDefaultPadding / 2,
                      right: kDefaultPadding / 2),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: AppColors.bgGreyColor,
                          spreadRadius: 5,
                          blurRadius: 7)
                    ]),
                    child: Card(
                      color: AppColors.whiteColor,
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final double dataTableWidth =
                                      max(kScreenWidthMd, constraints.maxWidth);

                                  return Scrollbar(
                                    controller:
                                        _dataTableHorizontalScrollController,
                                    thumbVisibility: true,
                                    trackVisibility: true,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      controller:
                                          _dataTableHorizontalScrollController,
                                      child: SizedBox(
                                          width: dataTableWidth,
                                          child: DataTable(
                                            border: const TableBorder(
                                                verticalInside:
                                                    BorderSide(width: 0.5),
                                                top: BorderSide(width: 0.5),
                                                right: BorderSide(width: 0.5),
                                                left: BorderSide(width: 0.5),
                                                bottom: BorderSide(width: 0.5)),
                                            dividerThickness: 2,
                                            sortColumnIndex: 0,
                                            sortAscending: true,
                                            showCheckboxColumn: false,
                                            showBottomBorder: true,
                                            columns: [
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Row(
                                                children: [
                                                  Text('#'),

                                                  //  IconButton(
                                                  //      onPressed: () {},
                                                  //      icon: Icon(Icons.arrow_drop_down ))
                                                ],
                                              )),
                                              DataColumn(
                                                  // numeric: true,
                                                  label: Row(
                                                children: [
                                                  Text('Company Name'),

                                                  //  IconButton(
                                                  //      onPressed: () {},
                                                  //      icon: Icon(Icons.arrow_drop_down ))
                                                ],
                                              )),
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  Text('Payroll Allowance '),
                                                  //  IconButton(
                                                  //      onPressed: () {},
                                                  //      icon: Icon(Icons.arrow_drop_down_sharp))
                                                ],
                                              )),
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  Text('Status'),
                                                  //  IconButton(
                                                  //      onPressed: () {},
                                                  //      icon: Icon(Icons.arrow_drop_down_sharp))
                                                ],
                                              )),
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  Text(''),
                                                  //  IconButton(
                                                  //      onPressed: () {},
                                                  //      icon: Icon(Icons.arrow_drop_down_sharp))
                                                ],
                                              )),
                                            ],
                                            // ... (keep the existing DataTable properties)
                                            rows: List.generate(
                                                selectedAllowances.length,
                                                (index) {
                                              var allowance =
                                                  selectedAllowances[index];
                                              return DataRow.byIndex(
                                                index: index,
                                                cells: [
                                                  DataCell(
                                                      Text('#${index + 1}')),
                                                  DataCell(Text(screenController
                                                      .companypayrollallowance
                                                      .value
                                                      .companyId)),
                                                  DataCell(Text(
                                                      allowance.allowance)),
                                                  DataCell(Text(screenController
                                                      .companypayrollallowance
                                                      .value
                                                      .status)),
                                                  DataCell(TextButton(
                                                      onPressed: () {
                                                        // Edit functionality
                                                      },
                                                      child: const Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )))
                                                ],
                                              );
                                            }),
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            }
          }
        })
      ],
    )));
  }
}
