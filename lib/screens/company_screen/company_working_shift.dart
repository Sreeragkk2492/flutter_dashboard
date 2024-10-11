import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/card_header.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_workingshift_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class CompanyWorkingShift extends StatelessWidget {
  CompanyWorkingShift({super.key});
  final employeecontroller = Get.put(EmployeeController());
  final screenController = Get.put(CompanyWorkingshiftController());
  final ScrollController _dataTableHorizontalScrollController =
      ScrollController();

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: ' Company Working Shifts',
            subtitle: '',
            icon: const Icon(Icons.rocket),
            buttonTitle: 'Add Working Shifts',
            onClick: () {
              Get.toNamed(Routes.AddWorkingShifts);
            },
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Obx(
            () => FormBuilderDropdown<Company>(
              name: 'Company',
              decoration: const InputDecoration(
                labelText: 'Company',
                hintText: 'Select Company',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
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
            ),
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        Obx(() {
          if (!screenController.isCompanySelected.value) {
            return Center(
                child: Text("Please select a company to view leaves."));
          } else if (screenController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (screenController.hasFetchedWorkingshift.value &&
              screenController.workingShifts.isEmpty) {
            return Center(
              child: Text("No working shift available for this company."),
            );
          }else {
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
                          //   title: 'Company Working Shifts',
                          //   showDivider: false,
                          // ),
                          SizedBox(
                            width: double.infinity,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final double dataTableWidth = max(
                                    kScreenWidthMd, constraints.maxWidth);
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
                                        headingRowColor:
                                            WidgetStateProperty.all(
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
                                              label: Row(
                                            children: [
                                              const Text(
                                                  'Company Shift Name'),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons
                                                      .arrow_drop_down_sharp))
                                            ],
                                          )),
                                          DataColumn(
                                              label: Row(
                                            children: [
                                              const Text('Start Time'),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons
                                                      .arrow_drop_down_sharp))
                                            ],
                                          )),
                                          DataColumn(
                                              label: Row(
                                            children: [
                                              const Text('Start Time'),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(Icons
                                                      .arrow_drop_down_sharp))
                                            ],
                                          )),
                                          // const DataColumn(
                                          //   label: Text(''),
                                          // ),
                                        ],
                                        rows: List<DataRow>.generate(
                                            screenController.workingShifts
                                                .length, (index) {
                                          var workingShifts = screenController
                                              .workingShifts[index];
                                          return DataRow(
                                            cells: [
                                              DataCell(GestureDetector(
                                                onTap: () {
                                                  print('tapped');
                                                  DialogWidgets
                                                      .showDetailsDialog(
                                                          context,
                                                          DialogType.info);
                                                },
                                                child: Text(
                                                    workingShifts.shiftName),
                                              )),
                                              DataCell(Text(
                                                  workingShifts.startTime)),
                                              DataCell(Text(
                                                  workingShifts.endTime)),
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
          }
        }),
      ],
    )));
  }
}
