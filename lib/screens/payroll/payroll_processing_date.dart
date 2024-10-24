import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/payroll/controller/company_pro_date_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/dimens.dart';

class CompanyPayrollDate extends StatelessWidget {
  CompanyPayrollDate({super.key});
  final _dataTableHorizontalScrollController = ScrollController();
  final screenController = Get.put(CompanyProccesingDateController());
  final DateFormat dateFormat =
      DateFormat('d'); // Updated to show only date
  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: 'Payroll Processing Day ',
            subtitle: '',
            icon: Icon(Icons.rocket),
            buttonTitle: 'Add Processing Day',
            onClick: () {
              Get.toNamed(Routes.AddProcessingDate);
            },
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        Padding(
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
                            controller: _dataTableHorizontalScrollController,
                            thumbVisibility: true,
                            trackVisibility: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: _dataTableHorizontalScrollController,
                              child: SizedBox(
                                width: dataTableWidth,
                                child: Obx(() {
                                  if (screenController
                                      .companypayrollprocessingdate.isEmpty) {
                                    return Center(
                                      child: Text(
                                          "No payroll_processing_day found"),
                                    );
                                  } else {
                                    return DataTable(
                                      headingTextStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      headingRowHeight: 50,
                                      headingRowColor: WidgetStateProperty.all(
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
                                        DataColumn(
                                            onSort: (columnIndex, _) {
                                              if (screenController
                                                  .isSortasc.value) {
                                                screenController
                                                    .companypayrollprocessingdate
                                                    .sort((a, b) =>
                                                        a.companyName.compareTo(
                                                            b.companyName));
                                              } else {
                                                screenController
                                                    .companypayrollprocessingdate
                                                    .sort((a, b) =>
                                                        b.companyName.compareTo(
                                                            a.companyName));
                                              }
                                              screenController.isSortasc.value =
                                                  !screenController
                                                      .isSortasc.value;
                                            },
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
                                            Text('Processing Day'),
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
                                          screenController
                                              .companypayrollprocessingdate
                                              .length, (index) {
                                        var processingdate = screenController
                                                .companypayrollprocessingdate[
                                            index];
                                        return DataRow.byIndex(
                                          index: index,
                                          cells: [
                                            DataCell(Text('${index + 1}')),
                                            DataCell(Text(
                                                processingdate.companyName)),
                                            DataCell(Text(dateFormat.format(
                                                processingdate.processingDay))),
                                            DataCell(Text(processingdate
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
                                            //           color:
                                            //               AppColors.blackColor,
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
                                    );
                                  }
                                }),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    )));
  }
}
