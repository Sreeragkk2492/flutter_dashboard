import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/card_header.dart';
import 'package:flutter_dashboard/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_holiday_list_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CompanyHolidayList extends StatelessWidget {
   CompanyHolidayList({super.key});

    final screenController = Get.put(CompanyHolidayListController());
  final employeecontroller = Get.put(EmployeeController());
  final ScrollController _dataTableHorizontalScrollController =
      ScrollController();
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(body: ListView(children: [
       Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: ' Company Holiday List',
            subtitle: '',
            icon: const Icon(Icons.rocket),
            buttonTitle: 'Add Company Holiday',
            onClick: () {
              Get.toNamed(Routes.AddCompanyHoliday);
            },
          ),
        ),
         Row(
           children: [
             Expanded(
              flex: 1 ,
               child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child:Obx(() {
                  // Check if there's only one company (the logged-in user's company)
                  if (employeecontroller.companydetails.isEmpty) {
                    // Show loading indicator while fetching company details
                    return Center(child: CircularProgressIndicator());
                  }
               
                  if (employeecontroller.isSuperAdmin.value) {
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
                      items: employeecontroller.companydetails
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
                    final company = employeecontroller.companydetails[0];
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
             ),
             Expanded(
              flex: 1,
              child: SizedBox())
           ],
         ),
        buildSizedBoxH(kDefaultPadding),
        Obx(() {
          if (!screenController.isCompanySelected.value) {
            return Center(
                child: Text("Please select a company to view holiday."));
          } else if (screenController.isLoading.value) {
            return Center(
              child:  AnimatedCircularProgressIndicator(
              size: 60.0,
              strokeWidth: 5.0,
              valueColor: AppColors.defaultColor,
            ),
            );
          }
          if (screenController.holiday.isEmpty) {
            return Center(child: Text("No holiday available for this company."));
          } else {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: kDefaultPadding / 2,
                    top: kDefaultPadding,
                    left: kDefaultPadding / 2,
                    right: kDefaultPadding / 2),
                child: Container(
                  // decoration: BoxDecoration(
                  //     // color: AppColors.whiteColor,
                  //     //borderRadius: BorderRadius.circular(10),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: AppColors.bgGreyColor,
                  //           spreadRadius: 5,
                  //           blurRadius: 7)
                  //     ]),
                  child: Padding(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const CardHeader(
                        //   title: 'Company Holiday',
                        //   showDivider: false,
                        // ),
                        SizedBox(
                          width: double.infinity,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final double dataTableWidth =
                                  max(kScreenWidthMd, constraints.maxWidth);
                              return Scrollbar(
                                thumbVisibility: true,
                                trackVisibility: true,
                                // interactive: true,
                                controller:
                                    _dataTableHorizontalScrollController,
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
                                      headingRowColor: WidgetStateProperty.all(
                                          AppColors.bgGreyColor),
                                      // border: const TableBorder(
                                      //     verticalInside:
                                      //         BorderSide(width: 0.2),
                                      //     top: BorderSide(width: 0.5),
                                      //     right: BorderSide(width: 0.5),
                                      //     left: BorderSide(width: 0.5),
                                      //     bottom: BorderSide(width: 0.5)),
                                      dividerThickness: 2,
                                      sortColumnIndex: 0,
                                      sortAscending: true,
                                      showCheckboxColumn: true,
                                      showBottomBorder: true,
                                      columns: [
                                         DataColumn(
                                                label: Text(
                                                    'Sl No') // Added S.No column
                                                ),
                                        DataColumn(
                                           onSort: (columnIndex, _) {
                                              if (screenController
                                                  .isSortasc.value) {
                                                screenController.holiday
                                                    .sort((a, b) => a.description
                                                        .compareTo(b.description));
                                              } else {
                                                screenController.holiday
                                                    .sort((a, b) => b.description
                                                        .compareTo(a.description));
                                              }
                                              screenController.isSortasc.value =
                                                  !screenController
                                                      .isSortasc.value;
                                            },
                                            label: Row(
                                          children: [
                                            const Text('Company Holiday'),
                                            // IconButton(
                                            //     onPressed: () {},
                                            //     icon: const Icon(Icons
                                            //         .arrow_drop_down_sharp))
                                          ],
                                        )),
                                         DataColumn(
                                            label: Row(
                                          children: [
                                            const Text('Date'),
                                            // IconButton(
                                            //     onPressed: () {},
                                            //     icon: const Icon(Icons
                                            //         .arrow_drop_down_sharp))
                                          ],
                                        )),
                                        DataColumn(
                                            label: Row(
                                          children: [
                                            const Text('Status'),
                                            // IconButton(
                                            //     onPressed: () {},
                                            //     icon: const Icon(Icons
                                            //         .arrow_drop_down_sharp))
                                          ],
                                        )),
                                        // const DataColumn(
                                        //   label: Text(''),
                                        // ),
                                      ],
                                      rows: List<DataRow>.generate(
                                          screenController.holiday.length,
                                          (index) {
                                        var leave = screenController
                                            .holiday[index];
                                        return DataRow(
                                          cells: [
                                             DataCell(Text('${index + 1}')),
                                            DataCell(GestureDetector(
                                              onTap: () {
                                                print('tapped');
                                                DialogWidgets
                                                    .showDetailsDialog(
                                                        context,
                                                        DialogType.info);
                                              },
                                              child: Text(leave.description),
                                            )),
                                            DataCell(Text(
                                                dateFormat.format(leave.date))),
                                                 DataCell(Text(
                                                leave.isActive.toString())),
                                            // DataCell(TextButton(
                                            //     onPressed: () {
                                            //       // DialogWidgets
                                            //       //     .showEditDialog(
                                            //       //         context,
                                            //       //         DialogType.info,
                                            //       //        screenController,
                                            //       //         index);
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
        })
    ],));
  }
}