import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/card_header.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:get/get.dart';
import 'package:data_table_2/data_table_2.dart';

class ListAll extends StatefulWidget {
  ListAll({super.key});

  @override
  State<ListAll> createState() => _ListAllState();
}

class _ListAllState extends State<ListAll> {
  final screenController = Get.put(CompanyController());

  final ScrollController _dataTableHorizontalScrollController =
      ScrollController();

  final ScrollController _verticalScrollController = ScrollController();
  @override
  void dispose() {
    _dataTableHorizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
                controller: _verticalScrollController,
                scrollDirection: Axis.vertical,
                children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Obx(
              () => UIComponenetsAppBar(
                title:
                    'Total Companies : ${screenController.companydetails.length}',
                subtitle: '',
                icon: const Icon(Icons.rocket),
                buttonTitle: 'Add Company',
                onClick: () {
                  Get.toNamed(Routes.ADDCOMPANY);
                },
              ),
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
                              thumbVisibility: true,
                              trackVisibility: true,
                              // interactive: true,
                              controller: _dataTableHorizontalScrollController,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller:
                                    _dataTableHorizontalScrollController,
                                child: SizedBox(
                                  width: dataTableWidth,
                                  child: Obx(
                                    () => DataTable(
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
                                                screenController.companydetails
                                                    .sort((a, b) =>
                                                        a.companyName.compareTo(
                                                            b.companyName));
                                              } else {
                                                screenController.companydetails
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
                                                const Text('Cmp Name'),
                                                // IconButton(
                                                //     onPressed: () {},
                                                //     icon: const Icon(Icons
                                                //         .arrow_drop_down))
                                              ],
                                            )),
                                        // DataColumn(
                                        //     label: Row(
                                        //   children: [
                                        //     const Text('Comp_Id'),
                                        //     IconButton(
                                        //         onPressed: () {},
                                        //         icon: const Icon(Icons
                                        //             .arrow_drop_down_sharp))
                                        //   ],
                                        // )),
                                        DataColumn(
                                            label: Row(
                                          children: [
                                            const Text('Cmp Code'),
                                            // IconButton(
                                            //     onPressed: () {},
                                            //     icon: const Icon(Icons
                                            //         .arrow_drop_down_sharp))
                                          ],
                                        )),
                                        DataColumn(
                                          label: Row(
                                            children: [
                                              const Text('Db Name'),
                                              // IconButton(
                                              //     onPressed: () {},
                                              //     icon: const Icon(Icons
                                              //         .arrow_drop_down_sharp))
                                            ],
                                          ),
                                        ),
                                        DataColumn(
                                          label: Row(
                                            children: [
                                              const Text('Status'),
                                              // IconButton(
                                              //     onPressed: () {},
                                              //     icon: const Icon(Icons
                                              //         .arrow_drop_down_sharp))
                                            ],
                                          ),
                                        ),
                                        // DataColumn(
                                        //   label: Row(
                                        //     children: [
                                        //       const Text('Mob_No'),
                                        //       IconButton(
                                        //           onPressed: () {},
                                        //           icon: const Icon(Icons
                                        //               .arrow_drop_down_sharp))
                                        //     ],
                                        //   ),
                                        // ),
                                        const DataColumn(
                                          label: Text(''),
                                        ),
                                      ],
                                      rows: List<DataRow>.generate(
                                          screenController
                                              .companydetails.length, (index) {
                                        return DataRow(
                                          cells: [
                                            DataCell(

                                                // showEditIcon: true,
                                                _buildNameCell(screenController
                                                    .companydetails[index]
                                                    .companyName)),
                                            // DataCell(GestureDetector(
                                            //   onTap: () {
                                            //     print('tapped');
                                            //     DialogWidgets
                                            //         .showDetailsDialog(
                                            //             context,
                                            //             DialogType.info);
                                            //   },
                                            //   child: Text(screenController
                                            //       .companydetails[index].id),
                                            // )),
                                            DataCell(Text(screenController
                                                .companydetails[index]
                                                .companyCode)),
                                            DataCell(Text(screenController
                                                .companydetails[index]
                                                .databaseName)),
                                            DataCell(Text(screenController
                                                .companydetails[index].isActive
                                                .toString())),

                                            // DataCell(Text('')),
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
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ])));
  }

  Widget _buildNameCell(String name) {
    String truncatedname =
        name.length > 20 ? '${name.substring(0, 20)}...' : name;
    return Tooltip(
      message: name,
      child: Text(
        truncatedname,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
