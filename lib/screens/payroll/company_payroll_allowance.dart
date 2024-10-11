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
  final employeeController = Get.put(EmployeeController());
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
          child: Obx(() {
            // Check if there's only one company (the logged-in user's company)
            if (employeeController.companydetails.isEmpty) {
              // Show loading indicator while fetching company details
              return Center(child: CircularProgressIndicator());
            }

            if (employeeController.isSuperAdmin.value) {
              // Dropdown for superadmin
              return FormBuilderDropdown<Company>(
                name: 'Company Name',
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  hintText: 'Select Company',
                  border: OutlineInputBorder(),
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
                  screenController.onCompanySelected(
                      value!.id, value.companyCode);
                },
              );
            } else {
              // Single company display for company admin
              final company = employeeController.companydetails[0];
              // Automatically select the company for the admin
              WidgetsBinding.instance.addPostFrameCallback((_) {
                screenController.onCompanySelected(
                    company.id, company.companyCode);
              });
              return FormBuilderTextField(
                name: 'Company Name',
                initialValue: company.companyName,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                readOnly: true,
              );
            }
          }),
        ),
        buildSizedBoxH(kDefaultPadding),
        Obx(() {
          if (!screenController.hasExplicitlySelectedCompany.value) {
            return Center(
              child: Text("Please select a company to view allowances."),
            );
          } else if (!screenController.isCompanySelected.value) {
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
                    // decoration: BoxDecoration(boxShadow: [
                    //   BoxShadow(
                    //       color: AppColors.bgGreyColor,
                    //       spreadRadius: 5,
                    //       blurRadius: 7)
                    // ]),
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
                                          headingTextStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                          headingRowHeight: 50,
                                          headingRowColor:
                                              WidgetStateProperty.all(
                                                  AppColors.bgGreyColor),
                                          // border: const TableBorder(
                                          //     verticalInside:
                                          //         BorderSide(width: 0.5),
                                          //     top: BorderSide(width: 0.5),
                                          //     right: BorderSide(width: 0.5),
                                          //     left: BorderSide(width: 0.5),
                                          //     bottom: BorderSide(width: 0.5)),
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
                                                Text('No'),

                                                //  IconButton(
                                                //      onPressed: () {},
                                                //      icon: Icon(Icons.arrow_drop_down ))
                                              ],
                                            )),
                                            // DataColumn(
                                            //     // numeric: true,
                                            //     label: Row(
                                            //   children: [
                                            //     Text('Company Name'),

                                            //     //  IconButton(
                                            //     //      onPressed: () {},
                                            //     //      icon: Icon(Icons.arrow_drop_down ))
                                            //   ],
                                            // )),
                                            DataColumn(
                                                onSort: (columnIndex, _) {
                                                  if (screenController
                                                      .isSortasc.value) {
                                                    selectedAllowances.sort(
                                                        (a, b) => a.allowance
                                                            .compareTo(
                                                                b.allowance));
                                                  } else {
                                                    selectedAllowances.sort(
                                                        (a, b) => b.allowance
                                                            .compareTo(
                                                                a.allowance));
                                                  }
                                                  screenController
                                                          .isSortasc.value =
                                                      !screenController
                                                          .isSortasc.value;
                                                },
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
                                            // DataColumn(
                                            //     label: Row(
                                            //   children: [
                                            //     Text(''),
                                            //     //  IconButton(
                                            //     //      onPressed: () {},
                                            //     //      icon: Icon(Icons.arrow_drop_down_sharp))
                                            //   ],
                                            // )),
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
                                                DataCell(Text('${index + 1}')),
                                                // DataCell(Text(screenController
                                                //     .companypayrollallowance
                                                //     .value.companyId
                                                //     )),
                                                DataCell(
                                                    _buildAllowanceCell(allowance.allowance)),
                                                DataCell(Text(screenController
                                                    .companypayrollallowance
                                                    .value
                                                    .isActive
                                                    .toString())),
                                                // DataCell(TextButton(
                                                //     onPressed: () {
                                                //       // Edit functionality
                                                //     },
                                                //     child: const Text(
                                                //       'Edit',
                                                //       style: TextStyle(
                                                //           color: AppColors
                                                //               .blackColor,
                                                //           fontWeight:
                                                //               FontWeight.bold),
                                                //     )))
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
                  ));
            }
          }
        })
      ],
    )));
  }

   Widget _buildAllowanceCell(String name) {
    String truncatedname =
        name.length > 15 ? '${name.substring(0, 15)}...' : name;
    return Tooltip(
      message: name,
      child: Text(
        truncatedname,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
