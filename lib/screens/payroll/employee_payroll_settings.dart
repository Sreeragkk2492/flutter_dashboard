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
import 'package:flutter_dashboard/screens/payroll/controller/employee_payroll_settings_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/payroll_settings_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
// Import other necessary packages

class EmployeePayrollSettings extends StatelessWidget {
  EmployeePayrollSettings({super.key});
  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(EmployeePayrollSettingsController());
  final userNameController = TextEditingController();

  final ScrollController _dataTableHorizontalScrollController =
      ScrollController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return PortalMasterLayout(
      body: EntranceFader(
          child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: UIComponenetsAppBar(
                title: 'Employee Payroll Settings',
                subtitle: '',
                icon: const Icon(Icons.rocket),
                buttonTitle: 'Add Employee Payroll',
                onClick: () {
                  Get.toNamed(Routes.AddEmployeePayrollSettings);
                },
              ),
            ),
            buildSizedBoxH(kDefaultPadding),
            buildDropdowns(context),
            buildSizedBoxH(kDefaultPadding),
            Obx(() {
              if (screenController.showTabBar.value) {
                return Container(
                  child: const TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: [
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
                return const SizedBox.shrink();
              }
            }),
            Expanded(
              child: TabBarView(
                children: [
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
        Obx(()=>
           Row(
            children: [
              if (employeeController.isSuperAdmin.value) // Only show if superadmin
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Obx(() {
                if (employeeController.companydetails.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
          
                return FormBuilderDropdown<Company>(
                  name: 'Company Name',
                  decoration: const InputDecoration(
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
              }),
            ),
          ),
              Expanded(
                flex: 1,
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
               if (!employeeController.isSuperAdmin.value)
            const Expanded(flex: 1 , child: SizedBox()), 
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAllowanceTable(BuildContext context) {
    return Obx(() {
      if (
          !screenController.isUserSelected.value) {
        return const Center(child: Text("Please select the fields"));
      } else if (screenController.isLoading.value) {
        return const Center(
          child:  AnimatedCircularProgressIndicator(
              size: 60.0,
              strokeWidth: 5.0,
              valueColor: AppColors.defaultColor,
            ),
        );
      } else if (screenController.allowances.isEmpty) {
        return const Center(child: Text("No payroll allowances and deductions found"));
      } else if(screenController.noDataFound.value){
       return const Center(child: Text("No payroll allowances and deductions found"));
      }else {
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
                              controller:
                                  _dataTableHorizontalScrollController,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller:
                                    _dataTableHorizontalScrollController,
                                child: SizedBox(
                                  width: dataTableWidth,
                                  child: DataTable(
                                     headingTextStyle: const TextStyle(
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
                                        const DataColumn(
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
                                          const Text('Allowance Name'),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons
                                                  .arrow_drop_down_sharp))
                                        ],
                                      )),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          const Text('Amount'),
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
                                            child: Text(allowances.allowance),
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
                                          //           color:
                                          //               AppColors.blackColor,
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
    return Obx(() {
      if (
          !screenController.isUserSelected.value) {
        return const Center(child: Text("Please select all the dropdowns to view."));
      } else if (screenController.isLoading.value) {
        return const Center(
          child: AnimatedCircularProgressIndicator(
              size: 60.0,
              strokeWidth: 5.0,
              valueColor: AppColors.defaultColor,
            ),
        );
      } else if (screenController.deductions.isEmpty) {
        return const Center(child: Text("No payroll allowances and deductions found"));
      } else if(screenController.noDataFound.value){
      return const Center(child: Text("No payroll allowances and deductions found"));
      }else {
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
                              controller:
                                  _dataTableHorizontalScrollController,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller:
                                    _dataTableHorizontalScrollController,
                                child: SizedBox(
                                  width: dataTableWidth,
                                  child: DataTable(
                                    headingTextStyle: const TextStyle(
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
                                        const DataColumn(
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
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons
                                                  .arrow_drop_down_sharp))
                                        ],
                                      )),
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          const Text('Amount'),
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
                                            child: Text(deductions.deduction),
                                          )),
                                          DataCell(Text(
                                              deductions.amount.toString())),
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
                                          //           color:
                                          //               AppColors.blackColor,
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
}
