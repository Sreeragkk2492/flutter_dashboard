import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/card_header.dart';
import 'package:flutter_dashboard/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter_dashboard/core/widgets/custom_suggestion_feild.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/employee_models/user_model.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/payroll_settings_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// Import other necessary packages

class PayslipDetails extends StatelessWidget {
  PayslipDetails({super.key});
  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(PayrollSettingsController());
  final userNameController = TextEditingController();

  final ScrollController _dataTableHorizontalScrollController =
      ScrollController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return PortalMasterLayout(
      body: EntranceFader(
          child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: UIComponenetsAppBar(
                title: 'Employee Payslip Details',
                subtitle: '',
                icon: Icon(Icons.rocket),
                buttonTitle: 'Verify Employee Payslip',
                onClick: () {
                  Get.toNamed(Routes.AddEmployeePayslipGeneration);
                },
              ),
            ),
            buildSizedBoxH(kDefaultPadding),
            buildDropdowns(context),
            buildSizedBoxH(kDefaultPadding),
            Obx(() {
              if (screenController.showTabBar.value) {
                return Container(
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: [
                      Text('Payslip',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Text('Allowance',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      Text('Deduction',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500))
                    ],
                    labelColor: AppColors.defaultColor,
                    unselectedLabelColor: AppColors.textgreyColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: AppColors.defaultColor,
                    indicatorWeight: 5,
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
            Expanded(
              child: TabBarView(
                children: [
                  buildPayslipTable(context),
                  buildAllowanceTable(context),
                  buildDeductionTable(context),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildDropdowns(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
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
                        labelStyle: TextStyle(color: AppColors.blackColor),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.greycolor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.defaultColor, width: 1.5)),
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
                        screenController.onCompanySelected(value!.id);
                      },
                    );
                  } else {
                    // Single company display for company admin
                    final company = employeeController.companydetails[0];
                    // employeeController.setSelectedCompany(
                    //     company.id, company.companyCode);
                    return FormBuilderTextField(
                      name: 'Company Name',
                      initialValue: company.companyName,
                      decoration: InputDecoration(
                        labelText: 'Company Name',
                        labelStyle: TextStyle(color: AppColors.blackColor),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.greycolor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.defaultColor, width: 1.5)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      readOnly: true,
                    );
                  }
                }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Obx(() => CustomSuggessionTextFormField(
                controller: userNameController,
                hintText: 'Select User',
                labelText: 'User Name',
                suggestons: screenController.filteredUsers
                    .map((user) => user.name)
                    .toList(),
                validator: FormBuilderValidators.required(),
                width: MediaQuery.of(context).size.width * 0.4,
                onSelected: () {
                  final selectedUser = screenController.filteredUsers
                      .firstWhere((user) => 
                          user.name == userNameController.text);
                  screenController.onUserSelected(
                    selectedUser.userTypeId,
                    selectedUser.companyId,
                    selectedUser.id,
                    //selectedUser,
                  );
                },
               // prefixIcon: const Icon(Icons.person),
              ),),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: FormBuilderDropdown<String>(
                  name: 'Select Year',
                  decoration: const InputDecoration(
                    labelText: 'Select Year',
                    hintText: 'Select Year',
                    labelStyle: TextStyle(color: AppColors.blackColor),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greycolor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: FormBuilderValidators.required(),
                  items:
                      List.generate(10, (index) => DateTime.now().year - index)
                          .map((year) => DropdownMenuItem(
                              value: year.toString(),
                              child: Text(year.toString())))
                          .toList(),
                  onChanged: (value) {
                    screenController.onYearSelected(value!);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: FormBuilderDropdown<String>(
                  name: 'Select Month',
                  decoration: const InputDecoration(
                    labelText: 'Select Month',
                    hintText: 'Select Month',
                    labelStyle: TextStyle(color: AppColors.blackColor),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greycolor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: FormBuilderValidators.required(),
                  items: List.generate(12, (index) => index + 1)
                      .map((month) => DropdownMenuItem(
                            value: month.toString(),
                            child: Text(DateTime(2022, month)
                                .toString()
                                .split(' ')[0]
                                .split('-')[1]),
                          ))
                      .toList(),
                  onChanged: (value) {
                    screenController.onMonthSelected(value!);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildPayslipTable(BuildContext context) {
    return Obx(() {
      if (!screenController.isUserSelected.value ||
          !screenController.isYearSelected.value ||
          !screenController.isMonthSelected.value) {
        return Center(child: Text("Please select all the dropdowns to view."));
      } else if (screenController.isLoading.value) {
        return Center(
          child:  AnimatedCircularProgressIndicator(
              size: 60.0,
              strokeWidth: 5.0,
              valueColor: AppColors.defaultColor,
            ),
        );
      } else {
        return SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),

          child: Padding(
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
                      //   title: 'Payroll Details',
                      //   showDivider: false,
                      // ),
                      SizedBox(
                        // width: double.infinity,
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
                                          // numeric: true,
                                          label: Row(
                                        children: [
                                          Text('Sl No'),

                                          //  IconButton(
                                          //      onPressed: () {},
                                          //      icon: Icon(Icons.arrow_drop_down ))
                                        ],
                                      )),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          const Text('Employee Id'),
                                          // IconButton(
                                          //     onPressed: () {},
                                          //     icon: const Icon(Icons
                                          //         .arrow_drop_down_sharp))
                                        ],
                                      )),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          const Text('Location'),
                                          // IconButton(
                                          //     onPressed: () {},
                                          //     icon: const Icon(Icons
                                          //         .arrow_drop_down_sharp))
                                        ],
                                      )),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          const Text('Holiday'),
                                          // IconButton(
                                          //     onPressed: () {},
                                          //     icon: const Icon(Icons
                                          //         .arrow_drop_down_sharp))
                                        ],
                                      )),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          const Text('Leave Days'),
                                          // IconButton(
                                          //     onPressed: () {},
                                          //     icon: const Icon(Icons
                                          //         .arrow_drop_down_sharp))
                                        ],
                                      )),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          const Text('Month'),
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
                                    rows: List<DataRow>.generate(1, (index) {
                                      var payslip =
                                          screenController.payslipDetails[index];
                                      return DataRow(
                                        cells: [
                                          DataCell(Text('${index + 1}')),
                                          DataCell(GestureDetector(
                                            onTap: () {
                                              print('tapped');
                                              DialogWidgets.showDetailsDialog(
                                                  context, DialogType.info);
                                            },
                                            child: Text(payslip.employeeId),
                                          )),
                                          DataCell(Text(payslip.location)),
                                          DataCell(Text(
                                              payslip.holidays.toString())),
                                          DataCell(Text(
                                              payslip.currentMonthLeaves.toString())),
                                          DataCell(
                                              Text(payslip.month.toString())),
                                          DataCell(Text(
                                              payslip.isActive.toString())),
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
                                          //           color: AppColors.blackColor,
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
              )),
        );
      }
    });
  }

  Widget buildAllowanceTable(BuildContext context) {
    return Obx(() {
      if (!screenController.isUserSelected.value ||
          !screenController.isYearSelected.value ||
          !screenController.isMonthSelected.value) {
        return Center(child: Text("Please select all the dropdowns to view."));
      } else if (screenController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),

          child: Padding(
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
                      //   title: 'Allowance Details',
                      //   showDivider: false,
                      // ),
                      SizedBox(
                        // width: double.infinity,
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
                                  child: DataTable(
                                    headingTextStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    headingRowHeight: 50,
                                    headingRowColor: WidgetStateProperty.all(
                                        AppColors.bgGreyColor),
                                    // border: const TableBorder(
                                    //     verticalInside: BorderSide(width: 0.2),
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
                                          label: Row(
                                        children: [
                                          const Text('Allowance Name'),
                                          // IconButton(
                                          //     onPressed: () {},
                                          //     icon: const Icon(
                                          //         Icons.arrow_drop_down_sharp))
                                        ],
                                      )),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          const Text('Amount'),
                                          // IconButton(
                                          //     onPressed: () {},
                                          //     icon: const Icon(
                                          //         Icons.arrow_drop_down_sharp))
                                        ],
                                      )),
                                      // const DataColumn(
                                      //   label: Text(''),
                                      // ),
                                    ],
                                    rows: List<DataRow>.generate(
                                        screenController.allowances.length,
                                        (index) {
                                      var allowances =
                                          screenController.allowances[index];
                                      return DataRow(
                                        cells: [
                                          DataCell(Text('${index + 1}')),
                                          DataCell(GestureDetector(
                                            onTap: () {
                                              print('tapped');
                                              DialogWidgets.showDetailsDialog(
                                                  context, DialogType.info);
                                            },
                                            child:
                                                Text(allowances.allowanceName),
                                          )),
                                          DataCell(Text(
                                              allowances.amount.toString())),
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
                                          //           color: AppColors.blackColor,
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
              )),
        );
      }
    });
  }

  Widget buildDeductionTable(BuildContext context) {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),

      child: Padding(
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
                  //   title: 'Deduction Details',
                  //   showDivider: false,
                  // ),
                  SizedBox(
                    // width: double.infinity,
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
                            controller: _dataTableHorizontalScrollController,
                            child: SizedBox(
                              width: dataTableWidth,
                              child: DataTable(
                                headingTextStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                headingRowHeight: 50,
                                headingRowColor: WidgetStateProperty.all(
                                    AppColors.bgGreyColor),
                                // border: const TableBorder(
                                //     verticalInside: BorderSide(width: 0.2),
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
                                      label: Row(
                                    children: [
                                      const Text('Deduction Name'),
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: const Icon(
                                      //         Icons.arrow_drop_down_sharp))
                                    ],
                                  )),
                                  DataColumn(
                                      label: Row(
                                    children: [
                                      const Text('Amount'),
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: const Icon(
                                      //         Icons.arrow_drop_down_sharp))
                                    ],
                                  )),
                                  // const DataColumn(
                                  //   label: Text(''),
                                  // ),
                                ],
                                rows: List<DataRow>.generate(
                                    screenController.deductions.length,
                                    (index) {
                                  var deductions =
                                      screenController.deductions[index];
                                  return DataRow(
                                    cells: [
                                      DataCell(Text('${index + 1}')),
                                      DataCell(GestureDetector(
                                        onTap: () {
                                          print('tapped');
                                          DialogWidgets.showDetailsDialog(
                                              context, DialogType.info);
                                        },
                                        child: Text(deductions.deductionName),
                                      )),
                                      DataCell(
                                          Text(deductions.amount.toString())),
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
                                      //           color: AppColors.blackColor,
                                      //           fontWeight: FontWeight.bold),
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
          )),
    );
  }
}
