import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/card_header.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_leavetype_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class CompanyLeaveType extends StatelessWidget {
  CompanyLeaveType({super.key});
  final screenController = Get.put(CompanyLeavetypeController());
  final employeecontroller = Get.put(EmployeeController());
  final ScrollController _dataTableHorizontalScrollController =
      ScrollController();

  @override
  Widget build(BuildContext context) {
   
    return PortalMasterLayout(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: ' Company Leave types',
            subtitle: '',
            icon: const Icon(Icons.rocket),
            buttonTitle: 'Add Leave Type',
            onClick: () {
              Get.toNamed(Routes.AddCompanyLeavetype);
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
              onChanged: (value) async {
                if (value != null) {
                  await screenController.onCompanySelected(value.id);
                }
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
          }
          if (screenController.hasFetchedLeaveTypes.value &&
              screenController.leaveTypes.isEmpty) {
            return Center(
              child: Text("No leaves available for this company."),
            );
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
                        //   title: 'Company Leave Types',
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
                                            onSort: (columnIndex, _) {
                                              if (screenController
                                                  .isSortasc.value) {
                                                screenController.leaveTypes
                                                    .sort((a, b) => a.type
                                                        .compareTo(b.type));
                                              } else {
                                                screenController.leaveTypes
                                                    .sort((a, b) => b.type
                                                        .compareTo(a.type));
                                              }
                                              screenController.isSortasc.value =
                                                  !screenController
                                                      .isSortasc.value;
                                            },
                                            label: Row(
                                              children: [
                                                const Text(
                                                    'Company Leave Name'),
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
                                        const DataColumn(
                                          label: Text(''),
                                        ),
                                      ],
                                      rows: List<DataRow>.generate(
                                          screenController.leaveTypes.length,
                                          (index) {
                                        var leave =
                                            screenController.leaveTypes[index];
                                        return DataRow(
                                          cells: [
                                            DataCell(GestureDetector(
                                              onTap: () {
                                                print('tapped');
                                                DialogWidgets.showDetailsDialog(
                                                    context, DialogType.info);
                                              },
                                              child: Text(leave.type),
                                            )),
                                            DataCell(Text(
                                                leave.isActive.toString())),
                                            DataCell(TextButton(
                                                onPressed: () {
                                                  // DialogWidgets
                                                  //     .showEditDialog(
                                                  //         context,
                                                  //         DialogType.info,
                                                  //        screenController,
                                                  //         index);
                                                },
                                                child: const Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )))
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
      ],
    ));
  }
}
