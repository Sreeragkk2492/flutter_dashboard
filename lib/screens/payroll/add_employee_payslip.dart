import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/user_model.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/employee_payroll_settings_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/payroll_settings_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEmployeePayslip extends StatelessWidget {
  AddEmployeePayslip({super.key});

  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(PayrollSettingsController());

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
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: Obx(() => FormBuilderDropdown<Company>(
                                  name: 'Company Name',
                                  decoration: const InputDecoration(
                                    labelText: 'Company Name',
                                    hintText: 'Company Name',
                                    border: OutlineInputBorder(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                  validator: FormBuilderValidators.required(),
                                  items: employeeController.companydetails
                                      .map((company) => DropdownMenuItem(
                                            value: company,
                                            child: Text(company.companyName),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    screenController
                                        .onCompanySelected(value!.id);
                                  },
                                )),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: Obx(() => FormBuilderDropdown<UserModel>(
                                  name: 'Employee',
                                  decoration: const InputDecoration(
                                    labelText: 'Employee',
                                    hintText: 'Employee',
                                    border: OutlineInputBorder(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                  validator: FormBuilderValidators.required(),
                                  items: screenController.filteredUsers
                                      .map((user) => DropdownMenuItem(
                                            value: user,
                                            child: Text(user.name),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    screenController.onUserSelected(
                                        value!.userTypeId,
                                        value.companyId,
                                        value.id);
                                  },
                                )),
                          ),
                        ),
                      ],
                    ),
                    // buildSizedBoxH(kDefaultPadding * 3),
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
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              validator: FormBuilderValidators.required(),
                              items: List.generate(10,
                                      (index) => DateTime.now().year - index)
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
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                    buildSizedBoxH(kDefaultPadding * 2),
                    Obx(() {
                      if (!screenController.isCompanySelected.value ||
                          !screenController.isUserSelected.value ||
                          !screenController.isYearSelected.value ||
                          !screenController.isMonthSelected.value) {
                        return Center(
                            child: Text(
                                "Please select all the dropdowns to view."));
                      } else if (screenController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (screenController.noDataFound.value) {
                        return Center(child: Text("No Data Found!"));
                      } else {
                        return Column(
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
                                          'Year',
                                          TextInputType.number,
                                          screenController.yearController),
                                      buildPayslipField(
                                          'Month',
                                          TextInputType.number,
                                          screenController.monthController),
                                      buildPayslipField(
                                          'Pay Period Start',
                                          TextInputType.datetime,
                                          screenController
                                              .payPeriodStartController),
                                      buildPayslipField(
                                          'Pay Period End',
                                          TextInputType.datetime,
                                          screenController
                                              .payPeriodEndController),
                                      buildPayslipField(
                                          'Pay Date',
                                          TextInputType.datetime,
                                          screenController.payDateController),
                                      buildPayslipField(
                                          'Payment Method',
                                          TextInputType.text,
                                          screenController
                                              .paymentMethodController),
                                      buildPayslipField(
                                          'Status',
                                          TextInputType.text,
                                          screenController.statusController),
                                    ],
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: Column(
                                    children: [
                                      buildPayslipField(
                                          'Total Amount',
                                          TextInputType.number,
                                          screenController
                                              .totalAmountController),
                                      buildPayslipField(
                                          'Overtime Hours',
                                          TextInputType.number,
                                          screenController
                                              .overtimeHoursController),
                                      buildPayslipField(
                                          'Regular Hours',
                                          TextInputType.number,
                                          screenController
                                              .regularHoursController),
                                      buildPayslipField(
                                          'Leave Days',
                                          TextInputType.number,
                                          screenController.leaveDaysController),
                                      buildPayslipField(
                                          'Holidays',
                                          TextInputType.number,
                                          screenController.holidaysController),
                                      buildPayslipField(
                                          'Work From Home Days',
                                          TextInputType.number,
                                          screenController
                                              .workFromHomeDaysController),
                                      buildPayslipField(
                                          'Payslip File Name',
                                          TextInputType.text,
                                          screenController
                                              .payslipFileNameController),
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
                                          screenController
                                              .projectCodeController),
                                      buildPayslipField(
                                          'Location',
                                          TextInputType.text,
                                          screenController.locationController),
                                      buildPayslipField(
                                          'Department',
                                          TextInputType.text,
                                          screenController
                                              .departmentController),
                                      buildPayslipField(
                                          'Remarks',
                                          TextInputType.text,
                                          screenController.remarksController),
                                      buildPayslipField(
                                          'Approved',
                                          TextInputType.text,
                                          screenController.approvedController),
                                      buildPayslipField(
                                          'Approved By',
                                          TextInputType.text,
                                          screenController
                                              .approvedByController),
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
                                    children: screenController.allowances
                                        .getRange(
                                            0,
                                            (screenController
                                                        .allowances.length /
                                                    2)
                                                .ceil())
                                        .map((allowance) =>
                                            buildAllowanceDeductionField(
                                                allowance.allowanceName,
                                                screenController
                                                        .allowanceControllers[
                                                    allowance.id]!))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: Column(
                                    children: screenController.allowances
                                        .getRange(
                                            (screenController
                                                        .allowances.length /
                                                    2)
                                                .ceil(),
                                            screenController.allowances.length)
                                        .map((allowance) =>
                                            buildAllowanceDeductionField(
                                                allowance.allowanceName,
                                                screenController
                                                        .allowanceControllers[
                                                    allowance.id]!))
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
                                    children: screenController.deductions
                                        .getRange(
                                            0,
                                            (screenController
                                                        .deductions.length /
                                                    2)
                                                .ceil())
                                        .map((deduction) =>
                                            buildAllowanceDeductionField(
                                                deduction.deductionName,
                                                screenController
                                                        .deductionControllers[
                                                    deduction.id]!))
                                        .toList(),
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: Column(
                                    children: screenController.deductions
                                        .getRange(
                                            (screenController
                                                        .deductions.length /
                                                    2)
                                                .ceil(),
                                            screenController.deductions.length)
                                        .map((deduction) =>
                                            buildAllowanceDeductionField(
                                                deduction.deductionName,
                                                screenController
                                                        .deductionControllers[
                                                    deduction.id]!))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    }),
                    buildSizedBoxH(kDefaultPadding * 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultAddButton(
                          buttonname: 'Generate',
                          onClick: () async {
                             await screenController.addPayslipDetails();
                            Get.back();
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
      TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            // style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          FormBuilderTextField(
            name: label.toLowerCase().replaceAll(' ', '_'),
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
            keyboardType: keyboardType,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget buildAllowanceDeductionField(
      String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            // style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          FormBuilderTextField(
            name: label.toLowerCase().replaceAll(' ', '_'),
            controller: controller,
            decoration: InputDecoration(
            // labelText: 'Amount',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ]),
          ),
        ],
      ),
    );
  }
}