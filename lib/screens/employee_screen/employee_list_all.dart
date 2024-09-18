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
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/employeetable.dart';
import 'package:get/get.dart';

class EmployeeListAll extends StatelessWidget {
  EmployeeListAll({super.key});
  final screenController = Get.put(EmployeeController());
  final _dataTableHorizontalScrollController = ScrollController();

 
  
  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Obx(
            () => UIComponenetsAppBar(
              title: 'Total Employee : ${screenController.users.length}',
              subtitle: '',
              icon: const Icon(Icons.rocket),
              buttonTitle: 'Add Employee',
              onClick: () {
                Get.toNamed(Routes.AddEmployee);
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
                    // const CardHeader(
                    //   title: 'Employee Details',
                    //   showDivider: false,
                    // ),
                    SizedBox(
                      width: double.infinity,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double dataTableWidth =
                              max(kScreenWidthXxl, constraints.maxWidth);
              
                          return Scrollbar(
                            controller: _dataTableHorizontalScrollController,
                            thumbVisibility: true,
                            trackVisibility: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller:
                                  _dataTableHorizontalScrollController,
                              child: SizedBox(
                                width: dataTableWidth,
                                child:  Obx(()=>
                                 DataTable(
                                  headingTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                                  headingRowHeight: 50,
                                    headingRowColor: WidgetStateProperty.all(AppColors.bgGreyColor),
                                     dividerThickness: 2,
                                      sortColumnIndex: 0,
                                      sortAscending: true,
                                      showCheckboxColumn: false,
                                      showBottomBorder: true,
                                      columns: [
                                        DataColumn(
                                          onSort: (columnIndex, _) {
                                            if(screenController.isSortasc.value){
                                              screenController.users.sort((a, b) => a.name.compareTo(b.name));
                                            }else{
                                               screenController.users.sort((a, b) => b.name.compareTo(a.name));
                                            }
                                            screenController.isSortasc.value=!screenController.isSortasc.value;
                                          },
                                            // numeric: true,
                                            label: Row(
                                          children: [
                                            const Text('Employee Name'),
                                           
                                          ],
                                        )),
                                        DataColumn(
                                            label: Row(
                                          children: [
                                            const Text('Employee Id'),
                                           
                                          ],
                                        )),
                                          DataColumn(
                                            label: Row(
                                          children: [
                                            const Text('Date of Birth'),
                                            
                                          ],
                                        )),
                                        DataColumn(
                                            label: Row(
                                          children: [
                                            const Text('Address'),
                                           
                                          ],
                                        )),
                                        DataColumn(
                                          label: Row(
                                            children: [
                                              const Text('Mob Number'),
                                             
                                            ],
                                          ),
                                        ),
                                        const DataColumn(
                                          label: Text(''),
                                        ),
                                      ],
                                      rows: List.generate(
                                          screenController.users.length,
                                          (index) {
                                        var user =
                                            screenController.users[index];
                                        return DataRow.byIndex(
                                          index: index,
                                          cells: [
                                            DataCell(GestureDetector(
                                                onTap: () {
                                                  DialogWidgets
                                                      .showEmpDetailsDialog(
                                                          context,
                                                          DialogType.info);
                                                },
                                                child: Text(user.name))),
                                            DataCell(Text(user.employeeId.toString())),
                                             DataCell(Text(user.dob.toString())),
                                           DataCell(_buildAddressCell(user.address.toString())),
                                            DataCell(Text(
                                                user.phoneNumber.toString())),
                                            DataCell(TextButton(
                                                onPressed: () {
                                                  DialogWidgets
                                                      .showEmpEditDialog(
                                                          context,
                                                          DialogType.info,
                                                          user);
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
                                     // source: EmployeeDataSource(screenController.users, context),
                                    
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
      ],
    )));
  }

    Widget _buildAddressCell(String address) {
       // Truncate the address to show only the first half
  String truncatedAddress = address.length > 20
      ? '${address.substring(0, 20)}...'
      : address;
    return Tooltip(
      message: address,
      child: Text(
        truncatedAddress,
        overflow: TextOverflow.ellipsis,
       // maxLines: 1,
      ),
    );
  }
}
