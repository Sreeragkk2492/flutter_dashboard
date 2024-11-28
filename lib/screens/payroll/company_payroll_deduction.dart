import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/company_payroll_deduction_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../models/company_models/company_models.dart';

class CompanyDeductionDetails extends StatelessWidget {
  CompanyDeductionDetails({super.key});
  final screenController = Get.put(CompanyPayrollDeductionController());
  final _dataTableHorizontalScrollController = ScrollController();
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
            title: 'Company Payroll Deduction ',
            subtitle: '',
            icon: Icon(Icons.rocket),
            buttonTitle: 'Add Company Deduction Details',
            onClick: () {
              Get.toNamed(Routes.AddCompanyDeductionDetails);
            },
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Obx(() {
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
          }),
        ),
        buildSizedBoxH(kDefaultPadding),
        Obx(() {
          if (!screenController.isCompanySelected.value) {
            return Center(
                child: Text("Please select a company to view deduction."));
          } else if (screenController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final selectedDeduction = screenController.companyDeduction
                .where((deduction) => deduction.isSelected)
                .toList();

            if (selectedDeduction.isEmpty) {
              return Center(
                  child: Text("No selected deduction for this company."));
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
                          // CardHeader(
                          //   title: 'Company Details',
                          //   showDivider: false,
                          // ),
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
                                              Text('Sl No'),

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
                                                  selectedDeduction.sort(
                                                      (a, b) => a.deduction
                                                          .compareTo(
                                                              b.deduction));
                                                } else {
                                                  selectedDeduction.sort(
                                                      (a, b) => b.deduction
                                                          .compareTo(
                                                              a.deduction));
                                                }
                                                screenController
                                                        .isSortasc.value =
                                                    !screenController
                                                        .isSortasc.value;
                                              },
                                              label: Row(
                                                children: [
                                                  Text('Payroll Deduction '),
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
                                        rows: List.generate(
                                            selectedDeduction.length, (index) {
                                          var companypayrolldeduction =
                                              selectedDeduction[index];
                                          return DataRow.byIndex(
                                            index: index,
                                            cells: [
                                              DataCell(Text('${index + 1}')),
                                              // DataCell(Text(screenController
                                              //     .companypayrolldeduction
                                              //     .value
                                              //     .companyId)),
                                              DataCell(_buildDeductionCell(
                                                  companypayrolldeduction
                                                      .deduction)),
                                              DataCell(Text(screenController
                                                  .companypayrolldeduction
                                                  .value
                                                  .isActive
                                                  .toString())),
                                              // DataCell(TextButton(
                                              //     onPressed: () {
                                              //       // showEditDialog(
                                              //       //     context,
                                              //       //     DialogType.info,
                                              //       //     index,
                                              //       //     department);
                                              //     },
                                              //     child: const Text(
                                              //       'Edit',
                                              //       style: TextStyle(
                                              //           color: AppColors
                                              //               .blackColor,
                                              //           fontWeight:
                                              //               FontWeight.bold),
                                              //     )))
                                              // DataCell(Text(
                                              //     '${Random().nextInt(100)}')),
                                              // DataCell(Text(
                                              //     '${Random().nextInt(10000)}')),
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
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
        }),
      ],
    )));
  }

  Widget _buildDeductionCell(String name) {
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
