import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/user_model.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/employee_payroll_settings_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/invoice_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/payroll_settings_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEmployeePayslip extends StatelessWidget {
  final int selectedIndex;
  AddEmployeePayslip({Key? key})
      : selectedIndex = Get.arguments['index'],
        super(key: key);
  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(PayrollSettingsController());
  final invoiceController = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    
    Size screenSize = MediaQuery.of(context).size;
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 150,
                  color: AppColors.defaultColor.withOpacity(0.6),
                ),
                Align(
                  // heightFactor: 0.01,
                  child: Container(
                    height: 100,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    margin: EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                        color: AppColors.bgGreyColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: AssetImage('assets/profile3.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        buildSizedboxW(kDefaultPadding),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Verify Employee Payslip',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            buildSizedBoxH(kDefaultPadding * 3),
            screenSize.width >= kScreenWidthLg
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding + kTextPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(flex: 4, child: addPayrollForm()),
                        buildSizedboxW(kDefaultPadding),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding + kTextPadding),
                    child: Column(
                      children: [
                        addPayrollForm(),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    )));
  }

  Widget addPayrollForm() {
    // Use the selected payslip data
    final payslip = screenController.payslip[selectedIndex];
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.bgGreyColor,
            spreadRadius: 5,
            blurRadius: 7,
          )
        ],
      ),
      child: Card(
        color: AppColors.whiteColor,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify Employee Payslip',
                style: GoogleFonts.montserrat(
                  fontSize: kDefaultPadding + kTextPadding,
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildSizedBoxH(kDefaultPadding * 2),
              FormBuilder(
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   children: [ 
                    //     Expanded(
                    //       child: Padding(
                    //         padding: EdgeInsets.all(kDefaultPadding),
                    //         child: Obx(() {
                    //           // Check if there's only one company (the logged-in user's company)
                    //           if (employeeController.companydetails.isEmpty) {
                    //             // Show loading indicator while fetching company details
                    //             return Center(
                    //                 child: CircularProgressIndicator());
                    //           }

                    //           if (employeeController.isSuperAdmin.value) {
                    //             // Dropdown for superadmin
                    //             return FormBuilderDropdown<Company>(
                    //               name: 'Company Name',
                    //               decoration: InputDecoration(
                    //                 labelText: 'Company Name',
                    //                 hintText: 'Select Company',
                    //                 border: OutlineInputBorder(),
                    //                 floatingLabelBehavior:
                    //                     FloatingLabelBehavior.always,
                    //               ),
                    //               validator: FormBuilderValidators.required(),
                    //               items: employeeController.companydetails
                    //                   .map((company) => DropdownMenuItem(
                    //                         value: company,
                    //                         child: Text(company.companyName),
                    //                       ))
                    //                   .toList(),
                    //               onChanged: (value) {
                    //                 screenController
                    //                     .onCompanySelected(value!.id);
                    //               },
                    //             );
                    //           } else {
                    //             // Single company display for company admin
                    //             final company =
                    //                 employeeController.companydetails[0];
                    //             // employeeController.setSelectedCompany(
                    //             //     company.id, company.companyCode);
                    //             return FormBuilderTextField(
                    //               name: 'Company Name',
                    //               initialValue: company.companyName,
                    //               decoration: InputDecoration(
                    //                 labelText: 'Company Name',
                    //                 border: OutlineInputBorder(),
                    //                 floatingLabelBehavior:
                    //                     FloatingLabelBehavior.always,
                    //               ),
                    //               readOnly: true,
                    //             );
                    //           }
                    //         }),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Padding(
                    //         padding: EdgeInsets.all(kDefaultPadding),
                    //         child: Obx(() => FormBuilderDropdown<UserModel>(
                    //               name: 'Employee',
                    //               decoration: const InputDecoration(
                    //                 labelText: 'Employee',
                    //                 hintText: 'Employee',
                    //                 border: OutlineInputBorder(),
                    //                 floatingLabelBehavior:
                    //                     FloatingLabelBehavior.always,
                    //               ),
                    //               validator: FormBuilderValidators.required(),
                    //               items: screenController.filteredUsers
                    //                   .map((user) => DropdownMenuItem(
                    //                         value: user,
                    //                         child: Text(user.name),
                    //                       ))
                    //                   .toList(),
                    //               onChanged: (value) {
                    //                 screenController.onUserSelected(
                    //                     value!.userTypeId,
                    //                     value.companyId,
                    //                     value.id);
                    //               },
                    //             )),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // // buildSizedBoxH(kDefaultPadding * 3),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: EdgeInsets.all(kDefaultPadding),
                    //         child: FormBuilderDropdown<String>(
                    //           name: 'Select Year',
                    //           decoration: const InputDecoration(
                    //             labelText: 'Select Year',
                    //             hintText: 'Select Year',
                    //             border: OutlineInputBorder(),
                    //             floatingLabelBehavior:
                    //                 FloatingLabelBehavior.always,
                    //           ),
                    //           validator: FormBuilderValidators.required(),
                    //           items: List.generate(10,
                    //                   (index) => DateTime.now().year - index)
                    //               .map((year) => DropdownMenuItem(
                    //                   value: year.toString(),
                    //                   child: Text(year.toString())))
                    //               .toList(),
                    //           onChanged: (value) {
                    //             screenController.onYearSelected(value!);
                    //             invoiceController.selectedYear.value = value;
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: Padding(
                    //         padding: EdgeInsets.all(kDefaultPadding),
                    //         child: FormBuilderDropdown<String>(
                    //           name: 'Select Month',
                    //           decoration: const InputDecoration(
                    //             labelText: 'Select Month',
                    //             hintText: 'Select Month',
                    //             border: OutlineInputBorder(),
                    //             floatingLabelBehavior:
                    //                 FloatingLabelBehavior.always,
                    //           ),
                    //           validator: FormBuilderValidators.required(),
                    //           items: List.generate(12, (index) => index + 1)
                    //               .map((month) => DropdownMenuItem(
                    //                     value: month.toString(),
                    //                     child: Text(DateTime(2022, month)
                    //                         .toString()
                    //                         .split(' ')[0]
                    //                         .split('-')[1]),
                    //                   ))
                    //               .toList(),
                    //           onChanged: (value) {
                    //             screenController.onMonthSelected(value!);
                    //             invoiceController.selectedMonth.value = value;
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    buildSizedBoxH(kDefaultPadding * 2),
                     Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payslip',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            buildSizedBoxH(kDefaultPadding),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      buildPayslipField(
                                          editable: false,
                                          'Year',
                                          TextInputType.number,
                                          payslip.year.toString()
                                          ),
                                      buildPayslipField(
                                          editable: false,
                                          'Month',
                                          TextInputType.number,
                                          payslip.month.toString()),
                                      buildPayslipField(
                                          'Pay Period Start',
                                          TextInputType.datetime,
                                          payslip.payperiodStartDate.toString()),
                                      buildPayslipField(
                                          'Pay Period End',
                                          TextInputType.datetime,
                                          payslip.payperiodEndDate.toString()),
                                      buildPayslipField(
                                          'Pay Date',
                                          TextInputType.datetime,
                                          payslip.paydate.toString()),
                                      buildPayslipField(
                                          'Payment Method',
                                          TextInputType.text,
                                          payslip.paymentMethod),
                                      buildPayslipField(
                                          'Status',
                                          TextInputType.text,
                                          payslip.status),
                                    ],
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: Column(
                                    children: [
                                      buildPayslipField(
                                          editable: false,
                                          'Total Amount',
                                          TextInputType.number,
                                         payslip.totalAmount.toString()),
                                      buildPayslipField(
                                          'Overtime Hours',
                                          TextInputType.number,
                                          payslip.overtimeHours.toString()),
                                      buildPayslipField(
                                          editable: false,
                                          'Regular Hours',
                                          TextInputType.number,
                                          payslip.regularHours.toString()),
                                      buildPayslipField(
                                          'Leave Days',
                                          TextInputType.number,
                                          payslip.leavedays.toString()),
                                      buildPayslipField(
                                          'Holidays',
                                          TextInputType.number,
                                          payslip.holidays.toString()),
                                      buildPayslipField(
                                          'Work From Home Days',
                                          TextInputType.number,
                                          payslip.workfromhomeDays.toString()),
                                      buildPayslipField(
                                          'Payslip File Name',
                                          TextInputType.text,
                                          payslip.payslipFileName),
                                    ],
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: Column(
                                    children: [
                                      buildPayslipField(
                                          'Project Code',
                                          TextInputType.text,
                                         payslip.projectCode),
                                      buildPayslipField(
                                          'Location',
                                          TextInputType.text,
                                          payslip.location),
                                      buildPayslipField(
                                          'Department',
                                          TextInputType.text,
                                          payslip.department),
                                      buildPayslipField(
                                          'Remarks',
                                          TextInputType.text,
                                         payslip.remarks),
                                      buildPayslipField(
                                          'Approved',
                                          TextInputType.text,
                                          payslip.approved.toString()),
                                      buildPayslipField(
                                          'Approved By',
                                          TextInputType.text,
                                          payslip.approvedBy),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            buildSizedboxW(kDefaultPadding * 2),
                            Divider(),
                            buildSizedboxW(kDefaultPadding * 2),
                            Text(
                              'Allowances',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            buildSizedBoxH(kDefaultPadding),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: payslip.allowances
                                        .getRange(
                                            0,
                                            (payslip
                                                        .allowances.length /
                                                    2)
                                                .ceil())
                                        .map((allowance) =>
                                            buildAllowanceDeductionField(
                                                allowance.allowanceName,
                                                allowance.amount.toString()))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: Column(
                                    children: payslip .allowances
                                        .getRange(
                                            (payslip
                                                        .allowances.length /
                                                    2)
                                                .ceil(),
                                            payslip.allowances.length)
                                        .map((allowance) =>
                                            buildAllowanceDeductionField(
                                                allowance.allowanceName,
                                               allowance.amount.toString()))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                            buildSizedboxW(kDefaultPadding * 2),
                            Divider(),
                            buildSizedboxW(kDefaultPadding * 2),
                            Text(
                              'Deductions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            buildSizedBoxH(kDefaultPadding),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: payslip.deductions
                                        .getRange(
                                            0,
                                            (payslip
                                                        .deductions.length /
                                                    2)
                                                .ceil())
                                        .map((deduction) =>
                                            buildAllowanceDeductionField(
                                                deduction.deductionName,
                                                deduction.amount.toString()))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: Column(
                                    children: payslip.deductions
                                        .getRange(
                                            (payslip
                                                        .deductions.length /
                                                    2)
                                                .ceil(),
                                            payslip.deductions.length)
                                        .map((deduction) =>
                                            buildAllowanceDeductionField(
                                                deduction.deductionName,
                                                deduction.amount.toString()))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      
                   
                    buildSizedBoxH(kDefaultPadding * 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultAddButton(
                          buttonname: 'Generate',
                          onClick: () async {
                            await screenController.addPayslipDetails(payslip.userId);
                            invoiceController.setSelectedValues(
                                invoiceController.selectedCompanyId.value,
                                invoiceController.selectedUserId.value,
                                invoiceController.selectedYear.value,
                                invoiceController.selectedMonth.value);
                            await invoiceController.fetchPayslipDetails();
                            if (!invoiceController.noDataFound.value &&
                                !screenController.isGenerated.value) {
                              Get.toNamed(Routes.InvoicePage);
                            }
                          },
                        ),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget buildPayslipField(String label, TextInputType keyboardType,
    String initialValue,
    {bool editable = true}) {
  return Padding(
    padding: EdgeInsets.only(bottom: kDefaultPadding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        if (editable)
          FormBuilderTextField(
            name: label.toLowerCase().replaceAll(' ', '_'),
            initialValue: initialValue,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
            keyboardType: keyboardType,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          )
        else
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              initialValue,
              style: TextStyle(fontSize: 14),
            ),
          ),
      ],
    ),
  );
}

  Widget buildAllowanceDeductionField(
      String label, String amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              amount,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
