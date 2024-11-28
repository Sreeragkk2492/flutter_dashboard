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
import 'package:flutter_dashboard/screens/employee_screen/widget/custom_toggle_button.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/employeetable.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeListAll extends StatefulWidget {
  EmployeeListAll({super.key});

  @override
  State<EmployeeListAll> createState() => _EmployeeListAllState();
}

class _EmployeeListAllState extends State<EmployeeListAll> {
  final screenController = Get.put(EmployeeController());
 bool isActive = false;
  final _dataTableHorizontalScrollController = ScrollController();

  final DateFormat dateFormat =
      DateFormat('yyyy-MM-dd'); 
 // Updated to show only date
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
                screenController.clearFormFields();
                Get.toNamed(Routes.AddEmployee);
              },
            ),
          ),
        ),

        buildSizedBoxH(kDefaultPadding / 2),
          Padding(
            padding:  EdgeInsets.only(
              //  bottom: kDefaultPadding / 2,
               // top: kDefaultPadding,
                left: kDefaultPadding / 1 ,
                right: kDefaultPadding / 2), 
            child: Row(
              children: [
                // Flexible(
                //   child: Obx(()=>
                //       CustomToggleButton(
                //         activeColor:AppColors.defaultColor,
                //         value: screenController.isActive.value,
                //         onChanged: (value) {
                         
                //             screenController.isActive.value = value; 
                       
                //         },
                //       ),
                //   ),
                // ),
                //  buildSizedboxW(kDefaultPadding *3 ), 
               Flexible(
                 child: Obx(
                      () => FormBuilderDropdown(
                        // controller: widget.statusController,
                        name: 'Usertype',
                        decoration: const InputDecoration(
                          labelText: 'Usertype',
                          hintText: 'Usertype',
                          labelStyle: TextStyle(color: AppColors.blackColor),
                          border: OutlineInputBorder(),
                           enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.greycolor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.defaultColor, width: 1.5)),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        // enableSuggestions: false,
                        // keyboardType: TextInputType.name,
                        validator: FormBuilderValidators.required(),
                        items: screenController.usertype
                            .map((usertype) => DropdownMenuItem(
                                  value: usertype.id,
                                  child: Text(usertype.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          screenController.setSelectedUserTypeIdForData(value!); 
                        },
                        // onSaved: (value) => (_formData.firstname = value ?? ''),
                      ),
                    ),
               ),
               buildSizedboxW(kDefaultPadding *3  ),  
                Flexible(
                  child: Obx(()=>
                      CustomToggleButton(
                       // width: 100,
                        // activeText: "Active",
                        // inactiveText: "Inactive",
                        activeColor:AppColors.defaultColor,
                        value: screenController.isActive.value,
                        onChanged: (value) {
                         
                            screenController.isActive.value = value; 
                       
                        },
                      ),
                  ),
                ),
              ],
            ),
          ),
           buildSizedBoxH(kDefaultPadding), 
        Obx((){
          if(!screenController.isUserTypeSelected.value){
             return Center(
                child: Text(
                    "Please select Dropdown"));
          }else{
            return  Padding(
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
                // child: Padding(
                //   padding: EdgeInsets.all(kDefaultPadding),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       // const CardHeader(
                //       //   title: 'Employee Details',
                //       //   showDivider: false,
                //       // ),
                //       SizedBox(
                //         width: double.infinity,
                //         child: LayoutBuilder(
                //           builder: (context, constraints) {
                //             final double dataTableWidth =
                //                 max(kScreenWidthXxl, constraints.maxWidth);
          
                //             return Scrollbar(
                //               controller: _dataTableHorizontalScrollController,
                //               thumbVisibility: true,
                //               trackVisibility: true,
                //               child: SingleChildScrollView(
                //                 scrollDirection: Axis.horizontal,
                //                 controller:
                //                     _dataTableHorizontalScrollController,
                //                 child: SizedBox(
                //                   width: dataTableWidth,
                //                   child:  Obx(()=>
                //                    DataTable(
                //                      columnSpacing: 4 , // Add this line to reduce space between columns
                //                     headingTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                //                     headingRowHeight: 50,
                //                       headingRowColor: WidgetStateProperty.all(AppColors.bgGreyColor),
                //                        dividerThickness: 2,
                //                         sortColumnIndex: 0,
                //                         sortAscending: true,
                //                         showCheckboxColumn: false,
                //                         showBottomBorder: true,
                //                         columns: [
                //                           DataColumn(
                //                             onSort: (columnIndex, _) {
                //                               if(screenController.isSortasc.value){
                //                                 screenController.users.sort((a, b) => a.name.compareTo(b.name));
                //                               }else{
                //                                  screenController.users.sort((a, b) => b.name.compareTo(a.name));
                //                               }
                //                               screenController.isSortasc.value=!screenController.isSortasc.value;
                //                             },
                //                               // numeric: true,
                //                               label: Container(
                //                                 width: 90,
                //                                 child: const Text('Emp Name'))),
                //                           DataColumn(
                //                               label: Container(
                //                                 width: 80,
                //                                 child: const Text('Emp Id'))),
                //                             DataColumn(
                //                               label: const Text('Dob')),
                //                           DataColumn(
                //                               label: const Text('Address')),
                //                           DataColumn(
                //                             label: const Text('Mobile'),
                //                           ),
                //                           const DataColumn(
                //                             label: Text(''),
                //                           ),
                //                         ],
                //                         rows: List.generate(
                //                             screenController.users.length,
                //                             (index) {
                //                           var user =
                //                               screenController.users[index];
                //                           return DataRow.byIndex(
                //                             index: index,
                //                             cells: [
                //                               DataCell(GestureDetector(
                //                                   onTap: () {
                //                                     DialogWidgets
                //                                         .showEmpDetailsDialog(
                //                                             context,
                //                                             DialogType.info);
                //                                   },
                //                                   child: Text(user.name))),
                //                               DataCell(Text(user.employeeId.toString())),
                //                                DataCell(Text(user.dob != null ? dateFormat.format(user.dob!) : 'N/A')),
                //                              DataCell(_buildAddressCell(user.address.toString())),
                //                               DataCell(Text(
                //                                   user.phoneNumber.toString())),
                //                               DataCell(TextButton(
                //                                   onPressed: () {
                //                                     DialogWidgets
                //                                         .showEmpEditDialog(
                //                                             context,
                //                                             DialogType.info,
                //                                             user);
                //                                   },
                //                                   child: const Text(
                //                                     'Edit',
                //                                     style: TextStyle(
                //                                         color:
                //                                             AppColors.blackColor,
                //                                         fontWeight:
                //                                             FontWeight.bold),
                //                                   )))
                //                             ],
                //                           );
                //                         }),
                //                        // source: EmployeeDataSource(screenController.users, context),
          
                //                     ),
          
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                child: Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      SizedBox(
                        width: double.infinity,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double dataTableWidth = constraints.maxWidth;
                            final bool isSmallScreen =
                                dataTableWidth < kScreenWidthMd;
          
                            return isSmallScreen
                                ? _buildScrollableTable(dataTableWidth, context)
                                : _buildFullWidthTable(dataTableWidth, context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ));
          }
        }
          
        ),
      ],
    )));
  }

  Widget _buildScrollableTable(double dataTableWidth, BuildContext context) {
    return Scrollbar(
      controller: _dataTableHorizontalScrollController,
      thumbVisibility: true,
      trackVisibility: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _dataTableHorizontalScrollController,
        child: SizedBox(
          width: max(kScreenWidthXxl, dataTableWidth), 
          child: _buildDataTable(context),
        ),
      ),
    );
  }

  Widget _buildFullWidthTable(double dataTableWidth, BuildContext context) {
    return SizedBox(
      width: dataTableWidth,
      child: _buildDataTable(context),
    );
  }

  Widget _buildDataTable(context) {
    return Obx(() => DataTable( 
          columnSpacing: 4,
          headingTextStyle:
              TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          headingRowHeight: 50,
          headingRowColor: WidgetStateProperty.all(AppColors.bgGreyColor),
          dividerThickness: 2,
          sortColumnIndex: 0,
          sortAscending: screenController.isSortasc.value,
          showCheckboxColumn: false,
          showBottomBorder: true,
          columns: [
            DataColumn(label: Text('Sl No') // Added S.No column
                ),
            DataColumn(
              onSort: (columnIndex, _) {
                screenController.sortUsers();
              },
              label: Container(width: 90, child: const Text('Emp Name')),
            ),
            DataColumn(
                label: Container(width: 80, child: const Text('Emp Id'))),
            DataColumn(label: const Text('Dob')),
            DataColumn(label: const Text('Address')),
            DataColumn(label: const Text('Mobile')),
            const DataColumn(label: Text('')),
          ],
          rows: List.generate(
            screenController.filteredUsers.length,
            (index) {
              final user = screenController.filteredUsers[index];
              return DataRow(
                cells: [
                  DataCell(Text('${index + 1}')), // S.No cell
                  DataCell(GestureDetector(
                    onTap: () => DialogWidgets.showEmpDetailsDialog(
                        context, DialogType.info),
                    child: _buildNameCell(user.name),
                  )),
                  DataCell(Text(user.employeeId.toString())),
                  DataCell(Text(
                      user.dob != null ? dateFormat.format(user.dob!) : 'N/A')),
                  DataCell(_buildAddressCell(user.address.toString())),
                  DataCell(Text(user.phoneNumber.toString())),
                  DataCell(TextButton(
                    onPressed: () {
                      DialogWidgets.showEmpEditDialog(
                          context, DialogType.info, user);
                    },
                    child: const Text('Edit',
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold)),
                  )),
                ],
              );
            },
          ),
        ));
  }

  Widget _buildAddressCell(String address) {
    String truncatedAddress =
        address.length > 20 ? '${address.substring(0, 20)}...' : address;
    return Tooltip(
      message: address,
      child: Text(
        truncatedAddress,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildNameCell(String name) {
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
