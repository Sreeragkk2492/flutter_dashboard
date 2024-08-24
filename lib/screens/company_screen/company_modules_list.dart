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
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_module_controller.dart';
import 'package:get/get.dart';

class ComapnyModules extends StatelessWidget {
  ComapnyModules({super.key});

  final screensController = Get.put(CompanyModuleController());

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
            title: ' Company Modules List',
            subtitle: '',
            icon: const Icon(Icons.rocket),
            buttonTitle: 'Add Company Modules',
            onClick: () {
              Get.toNamed(Routes.ADDCOMPANYMODULELIST);
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
              decoration: BoxDecoration(
                  // color: AppColors.whiteColor,
                  //borderRadius: BorderRadius.circular(10),
                  boxShadow: [
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
                      const CardHeader(
                        title: 'Company Modules Details',
                        showDivider: false,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double dataTableWidth =
                                max(kScreenWidthXxl, constraints.maxWidth);
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
                                      border: const TableBorder(
                                          verticalInside:
                                              BorderSide(width: 0.2),
                                          top: BorderSide(width: 0.5),
                                          right: BorderSide(width: 0.5),
                                          left: BorderSide(width: 0.5),
                                          bottom: BorderSide(width: 0.5)),
                                      dividerThickness: 2,
                                      sortColumnIndex: 0,
                                      sortAscending: true,
                                      showCheckboxColumn: true,
                                      showBottomBorder: true,
                                      columns: [
                                        DataColumn(
                                            // numeric: true,
                                            label: Row(
                                          children: [
                                            const Text('Company Name'),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.arrow_drop_down))
                                          ],
                                        )),
                                        DataColumn(
                                            label: Row(
                                          children: [
                                            const Text('Company Module Name'),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons
                                                    .arrow_drop_down_sharp))
                                          ],
                                        )),
                                        DataColumn(
                                            label: Row(
                                          children: [
                                            const Text('Status'),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons
                                                    .arrow_drop_down_sharp))
                                          ],
                                        )),
                                        const DataColumn(
                                          label: Text(''),
                                        ),
                                      ],
                                      rows: List<DataRow>.generate(
                                          screensController
                                              .companymodules.length, (index) {
                                        var modules = screensController
                                            .companymodules[index];
                                        return DataRow(
                                          cells: [
                                            DataCell(

                                                // showEditIcon: true,
                                                Text(modules
                                                    .company.companyName)),
                                            DataCell(GestureDetector(
                                              onTap: () {
                                                print('tapped');
                                                DialogWidgets.showDetailsDialog(
                                                    context, DialogType.info);
                                              },
                                              child: Text(
                                                  modules.modules.moduleName),
                                            )),
                                            DataCell(Text(modules.status)),
                                           
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
              ),
            )),
      ],
    ));
  }
}
