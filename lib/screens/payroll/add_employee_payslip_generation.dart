import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/payroll/employee_payroll_model.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/invoice_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/payroll_settings_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class AddEmployeePayslipGeneration extends StatelessWidget {
  AddEmployeePayslipGeneration({super.key});

  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(PayrollSettingsController());
  final invoiceController = Get.put(InvoiceController());
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
          child: UIComponenetsAppBarNoButton(
            title: 'Verify Employee Payslip',
            subtitle: Text(''),
            icon: Icon(Icons.rocket),
            // buttonTitle: 'Generate',
            // onClick: () async {
            //   await screenController.addPayslipDetails();
            //   invoiceController.setSelectedValues(
            //       invoiceController.selectedCompanyId.value,
            //       invoiceController.selectedUserId.value,
            //       invoiceController.selectedYear.value,
            //       invoiceController.selectedMonth.value);
            //   await invoiceController.fetchPayslipDetails();
            //   if (!invoiceController.noDataFound.value &&
            //       !screenController.isGenerated.value) {
            //     Get.toNamed(Routes.InvoicePage);
            //   }
            // },
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        buildDropdowns(),
        buildSizedBoxH(kDefaultPadding),
        Obx(() {
          if (screenController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!screenController.showDataTable.value) {
            return Center(
                child: Text("Please select all criteria to view payslip data"));
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
                                return MouseRegion(
                                  child: ScrollConfiguration(
                                     behavior: ScrollConfiguration.of(context).copyWith(
                                    dragDevices: {
                                      PointerDeviceKind.mouse,
                                      PointerDeviceKind.touch,
                                      PointerDeviceKind.trackpad, 
                                    },
                                    scrollbars: true,
                                    physics: const BouncingScrollPhysics(),
                                  ), 
                                    child: Scrollbar(
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
                                            columnSpacing: 8,
                                            headingTextStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                            headingRowHeight: 50,
                                            dataTextStyle: TextStyle(fontSize: 14),
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
                                              // DataColumn(
                                              //     // numeric: true,
                                              //     label: Row(
                                              //   children: [
                                              //     Text('No'),
                                    
                                              //     //  IconButton(
                                              //     //      onPressed: () {},
                                              //     //      icon: Icon(Icons.arrow_drop_down ))
                                              //   ],
                                              // )),
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  const Text('Emp Name'),
                                                  // IconButton(
                                                  //     onPressed: () {},
                                                  //     icon: const Icon(Icons
                                                  //         .arrow_drop_down_sharp))
                                                ],
                                              )),
                                              DataColumn(
                                                  label: Row(
                                                children: [
                                                  const Text('Details'),
                                                  // IconButton(
                                                  //     onPressed: () {},
                                                  //     icon: const Icon(Icons
                                                  //         .arrow_drop_down_sharp))
                                                ],
                                              )),
                                              ...screenController.companyPayroll
                                                  .map((payroll) => DataColumn(
                                                      label: _buildAllowanceColumn(
                                                          payroll.allowance ??
                                                              payroll.deduction ??
                                                              ""))),
                                              // ...screenController
                                              //     .companyPayroll
                                              //     .map((deduction) => DataColumn(
                                              //         label: _builddeductioncolum(
                                              //             deduction.deduction.toString()))),
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
                                              const DataColumn(
                                                label: Text(''),
                                              ),
                                            ],
                                            rows: List<DataRow>.generate(
                                                screenController.payslip.length,
                                                (index) {
                                              var payslip =
                                                  screenController.payslip[index];
                                    
                                              return DataRow(
                                                cells: [
                                                  //  DataCell(Text('${index + 1}')),
                                                  DataCell(GestureDetector(
                                                    onTap: () {
                                                      print('tapped');
                                                      DialogWidgets
                                                          .showDetailsDialog(
                                                              context,
                                                              DialogType.info);
                                                    },
                                                    child: Text(payslip.name),
                                                  )),
                                                  DataCell(_buildDetailsCell(
                                                      empId: payslip.employeeId ??
                                                          'null',
                                                      year:
                                                          payslip.year.toString() ??
                                                              'null',
                                                      month: payslip.month
                                                              .toString() ??
                                                          'null',
                                                      address: payslip.address
                                                              .toString() ??
                                                          'null',
                                                      phone: payslip.phoneNumber
                                                              .toString() ??
                                                          'null ')),
                                                  ...screenController.companyPayroll
                                                      .map((payroll) {
                                                    var amount = 0.0;
                                                    if (payroll.allowance != null) {
                                                      var matchingAllowance =
                                                          payslip.allowances
                                                              .firstWhere(
                                                        (a) =>
                                                            a.allowanceName ==
                                                            payroll.allowance,
                                                        orElse: () =>
                                                            AllowanceElement(
                                                                id: '',
                                                                allowanceName: '',
                                                                amount: 0),
                                                      );
                                                      amount = matchingAllowance
                                                          .amount
                                                          .toDouble();
                                                    } else if (payroll.deduction !=
                                                        null) {
                                                      var matchingDeduction =
                                                          payslip.deductions
                                                              .firstWhere(
                                                        (d) =>
                                                            d.deductionName ==
                                                            payroll.deduction,
                                                        orElse: () => Deduction(
                                                            id: '',
                                                            deductionName: '',
                                                            amount: 0),
                                                      );
                                                      amount = matchingDeduction
                                                          .amount
                                                          .toDouble();
                                                    }
                                                    return DataCell(
                                                        Text(amount.toString()));
                                                  }),
                                                  // ...screenController
                                                  //     .companyPayroll
                                                  //     .map((deduction) {
                                                  //   var matchingDeduction = payslip
                                                  //       .deductions
                                                  //       .firstWhere(
                                                  //     (d) =>
                                                  //         d.deductionName ==
                                                  //         deduction.deduction,
                                                  //     orElse: () => Deduction(
                                                  //         id: '',
                                                  //         deductionName: '',
                                                  //         amount: 0),
                                                  //   );
                                                  //   return DataCell(Text(
                                                  //       matchingDeduction.amount
                                                  //           .toString()));
                                                  // }),
                                                  DataCell(Text(
                                                      payslip.isActive.toString())),
                                                  DataCell(TextButton(
                                                      onPressed: () {
                                                        Get.toNamed(
                                                          Routes
                                                              .AddEmployeePayslipDetails,
                                                          arguments: {
                                                            'index': index
                                                          },
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ))),
                                                  DataCell(TextButton(
                                                      onPressed: () async {
                                                        await screenController
                                                            .addPayslipDetails(
                                                                payslip.userId);
                                    
                                                        if (screenController
                                                            .isPayslipGenerated
                                                            .value) {
                                                          invoiceController.setSelectedValues(
                                                              payslip.companyId,
                                                              payslip.userId,
                                                              payslip.year
                                                                  .toString(),
                                                              payslip.month
                                                                  .toString());
                                                          // Get.toNamed(
                                                          //     Routes.InvoicePage);
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Generate',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .defaultColor,
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
        }),
      ],
    )));
  }

  Widget buildDropdowns() {
    return Column(
      children: [
         Row(
          children: [
             Expanded(
                flex: 1,
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
              flex: 1,
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
                  return Center(child: CircularProgressIndicator());
                }
          
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
              }),
            ),
          ),
          if (!employeeController.isSuperAdmin.value)
            Expanded(flex: 1 , child: SizedBox()),  
              // Expanded(
              //   child: Padding(
              //     padding: EdgeInsets.all(kDefaultPadding),
              //     child: Obx(() => FormBuilderDropdown<UserModel>(
              //           name: 'Employee',
              //           decoration: const InputDecoration(
              //             labelText: 'Employee',
              //             hintText: 'Employee',
              //             border: OutlineInputBorder(),
              //             floatingLabelBehavior: FloatingLabelBehavior.always,
              //           ),
              //           validator: FormBuilderValidators.required(),
              //           items: screenController.filteredUsers
              //               .map((user) => DropdownMenuItem(
              //                     value: user,
              //                     child: Text(user.name),
              //                   ))
              //               .toList(),
              //           onChanged: (value) {
              //             screenController.onUserSelected(
              //                 value!.userTypeId, value.companyId, value.id);
              //           },
              //         )),
              //   ),
              // ),
              Expanded(
                flex: 1,
                child: SizedBox())
             
            ],
          ),
        ),
       
      ],
    );
  }

  Widget _buildSubMenuCell(String subMenus) {
    // Truncate the address to show only the first half
    String truncatedSubmenu =
        subMenus.length > 20 ? '${subMenus.substring(0, 20)}...' : subMenus;
    return Tooltip(
      message: subMenus,
      child: Text(
        truncatedSubmenu,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildAllowanceColumn(String title) {
    String truncatedTitle =
        title.length > 6 ? '${title.substring(0, 6)}...' : title;
    return Tooltip(
      message: title,
      child: Text(
        truncatedTitle,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDetailsCell({
    required String empId,
    required String year,
    required String month,
    required String address,
    required String phone,
  }) {
    String monthName =
        DateTime(2022, int.parse(month)).toString().split(' ')[0].split('-')[1];
    String details =
        'ID: $empId\nYear: $year\nMonth: $monthName\nAddress: $address\nPhone: $phone';
    String truncatedDetails =
        details.length > 8 ? '${details.substring(0, 8)}...' : details;
    return Tooltip(
      message: details,
      child: Text(
        truncatedDetails,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _builddeductioncolum(String subMenus) {
    // Truncate the address to show only the first half
    String truncatedSubmenu =
        subMenus.length > 8 ? '${subMenus.substring(0, 8)}...' : subMenus;
    return Tooltip(
      message: subMenus,
      child: Text(
        truncatedSubmenu,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildamount(String subMenus) {
    // Truncate the address to show only the first half
    String truncatedSubmenu =
        subMenus.length > 20 ? '${subMenus.substring(0, 20)}...' : subMenus;
    return Tooltip(
      message: subMenus,
      child: Text(
        truncatedSubmenu,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
