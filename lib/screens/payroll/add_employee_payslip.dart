import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/core/widgets/line_chart_dashboard.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/invoice_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/payroll_settings_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class AddEmployeePayslip extends StatefulWidget {
  final int Index;
  // final int index;
  AddEmployeePayslip({Key? key})
      : Index = Get.arguments?['index'] ?? 0,
        super(key: key);

  @override
  State<AddEmployeePayslip> createState() => _AddEmployeePayslipState();
}

class _AddEmployeePayslipState extends State<AddEmployeePayslip> {
  @override
  void initState() {
    super.initState();
  
    // Reset the currentPayslipDetails when component mounts
    screenController.currentPayslipDetails.value = null;
  }

 

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: UIComponenetsAppBarNoButton(
                title: 'Verify Employee Payslip',
                subtitle: Text(''),
                icon: Icon(Icons.rocket),
              ),
            ),
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
    //  final updatedpayslip = screenController.currentPayslipDetails.value;
    final payslip = screenController.payslip[widget.Index]; 
    // Set the initial value for exceeded leave days
    // screenController.exceedLeaveDaysController.text =
    //     (updatedpayslip?.paidLeaves ?? payslip.paidLeaves).toString();
    // // screenController.exceedLeaveDaysController.text=payslip.exceededLeaveDays.toString();
    // // Similarly for total amount

    // final exceededAmountController = TextEditingController(
    //     text: (updatedpayslip?.paidLeaves ?? payslip.paidLeaves).toString());
    // Only use updatedpayslip values if it's for the current employee
    final updatedpayslip =
        screenController.currentPayslipDetails.value?.userId == payslip.userId
            ? screenController.currentPayslipDetails.value
            : null;

    // Reset controllers with original payslip values if no valid update exists
    screenController.exceedLeaveDaysController.text =
        (updatedpayslip?.paidLeaves ?? payslip.paidLeaves).toString();

    final totalAmountController = TextEditingController(
        text: (updatedpayslip?.totalAmount ?? payslip.totalAmount).toString());

    // screenController.totalAmountController.text =
    //     (updatedpayslip?.totalAmount ?? payslip.totalAmount).toString();

    screenController.lopLeavesController.text =
        (updatedpayslip?.lopLeaveDays ?? payslip.lopLeaveDays).toString();

    screenController.takenLeavesController.text =
        (updatedpayslip?.totalTakenPaidLeaves ?? payslip.totalTakenPaidLeaves)
            .toString();

    screenController.allowedpaidLeavesController.text =
        (updatedpayslip?.allowedPaidLeaves ?? payslip.allowedPaidLeaves)
            .toString();
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilder(
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  payslip.year.toString(),
                                  screenController.yearController),
                              buildPayslipField(
                                  editable: false,
                                  'Month',
                                  TextInputType.number,
                                  payslip.month.toString(),
                                  screenController.monthController),
                              buildPayslipField(
                                  'Pay Period Start',
                                  TextInputType.datetime,
                                  payslip.payperiodStartDate.toString(),
                                  screenController.payPeriodStartController),
                              buildPayslipField(
                                  'Pay Period End',
                                  TextInputType.datetime,
                                  payslip.payperiodEndDate.toString(),
                                  screenController.payPeriodEndController),
                              buildPayslipField(
                                  'Pay Date',
                                  TextInputType.datetime,
                                  payslip.paydate.toString(),
                                  screenController.payDateController),
                              buildPayslipField(
                                  'Payment Method',
                                  TextInputType.text,
                                  payslip.paymentMethod,
                                  screenController.paymentMethodController),
                              buildPayslipField(
                                  editable: false,
                                  'Lop Leave Days',
                                  TextInputType.text,
                                  (updatedpayslip?.lopLeaveDays ??
                                          payslip.lopLeaveDays)
                                      .toString(),
                                  screenController.lopLeavesController),
                              buildPayslipField(
                                  editable: false,
                                  'Allowed Paid Leaves',
                                  TextInputType.text,
                                  (updatedpayslip?.allowedPaidLeaves ??
                                          payslip.allowedPaidLeaves)
                                      .toString(),
                                  screenController.allowedpaidLeavesController),
                            ],
                          ),
                        ),
                        SizedBox(width: kDefaultPadding),
                        Expanded(
                          child: Column(
                            children: [
                              buildPayslipField(

                                  // editable: false,
                                  'Total Amount',
                                  TextInputType.number,
                                  totalAmountController.text,
                                  totalAmountController),
                              buildPayslipField(
                                  'Overtime Hours',
                                  TextInputType.number,
                                  payslip.overtimeHours.toString(),
                                  screenController.overtimeHoursController),
                              buildPayslipField(
                                  editable: false,
                                  'Regular Hours',
                                  TextInputType.number,
                                  payslip.regularHours.toString(),
                                  screenController.regularHoursController),
                              buildPayslipField(
                                  editable: false,
                                  'Current Month Leave',
                                  TextInputType.number,
                                  payslip.currentMonthLeaves.toString(),
                                  screenController
                                      .currentMonthLeavesController),
                              buildPayslipField(
                                  // editable: false,
                                  'Paid Leaves',
                                  TextInputType.number,
                                  (updatedpayslip?.paidLeaves ??
                                          payslip.paidLeaves)
                                      .toString(),
                                  screenController.exceedLeaveDaysController),
                              buildPayslipField(
                                  'Holidays',
                                  TextInputType.number,
                                  payslip.holidays.toString(),
                                  screenController.holidaysController),
                              buildPayslipField(
                                  'Work From Home Days',
                                  TextInputType.number,
                                  payslip.workfromhomeDays.toString(),
                                  screenController.workFromHomeDaysController),
                              buildPayslipField(
                                  editable: false,
                                  'Remaining paid leaves',
                                  TextInputType.number,
                                  ((updatedpayslip?.allowedPaidLeaves ??
                                              payslip.allowedPaidLeaves) -
                                          (updatedpayslip
                                                  ?.totalTakenPaidLeaves ??
                                              payslip.totalTakenPaidLeaves))
                                      .toString(),
                                  screenController.workFromHomeDaysController),
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
                                  payslip.projectCode,
                                  screenController.projectCodeController),
                              buildPayslipField(
                                  'Location',
                                  TextInputType.text,
                                  payslip.location,
                                  screenController.locationController),
                              buildPayslipField(
                                  'Department',
                                  TextInputType.text,
                                  payslip.department,
                                  screenController.departmentController),
                              buildPayslipField(
                                  'Remarks',
                                  TextInputType.text,
                                  payslip.remarks,
                                  screenController.remarksController),
                              buildPayslipField(
                                  'Approved',
                                  TextInputType.text,
                                  payslip.approved.toString(),
                                  screenController.approvedController),
                              buildPayslipField(
                                  'Approved By',
                                  TextInputType.text,
                                  payslip.approvedBy,
                                  screenController.approvedByController),
                              buildPayslipField(
                                  editable: false,
                                  'Total taken paid leaves',
                                  TextInputType.text,
                                  (updatedpayslip?.totalTakenPaidLeaves ??
                                          payslip.totalTakenPaidLeaves)
                                      .toString(),
                                  screenController.takenLeavesController),
                              // buildPayslipField('Payslip File Name',
                              //     TextInputType.text, payslip.payslipFileName),
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
                                    0, (payslip.allowances.length / 2).ceil())
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
                            children: payslip.allowances
                                .getRange(
                                    (payslip.allowances.length / 2).ceil(),
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
                            children: [
                              ...((updatedpayslip?.deductions ??
                                      payslip.deductions)
                                  .getRange(
                                    0,
                                    ((updatedpayslip?.deductions ??
                                                    payslip.deductions)
                                                .length /
                                            2)
                                        .ceil(),
                                  )
                                  .map((deduction) =>
                                      buildAllowanceDeductionField(
                                          (deduction as dynamic)
                                                  .deductionName
                                                  ?.toString() ??
                                              '',
                                          (deduction as dynamic)
                                                  .amount
                                                  ?.toString() ??
                                              '0'))
                                  .toList()),
                            ],
                          ),
                        ),
                        SizedBox(width: kDefaultPadding),
                        Expanded(
                          child: Column(
                            children: [
                              ...((updatedpayslip?.deductions ??
                                      payslip.deductions)
                                  .getRange(
                                    ((updatedpayslip?.deductions ??
                                                    payslip.deductions)
                                                .length /
                                            2)
                                        .ceil(),
                                    (updatedpayslip?.deductions ??
                                            payslip.deductions)
                                        .length,
                                  )
                                  .map((deduction) =>
                                      buildAllowanceDeductionField(
                                          (deduction as dynamic)
                                                  .deductionName
                                                  ?.toString() ??
                                              '',
                                          (deduction as dynamic)
                                                  .amount
                                                  ?.toString() ??
                                              '0'))
                                  .toList()),
                            ],
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
                      buttonname: 'Update',
                      onClick: () async {
                        // await screenController.updatePayslipDetails(
                        //     payslip
                        //         .userId, // Parse the current value from the text field
                        //     int.tryParse(screenController
                        //             .exceedLeaveDaysController.text) ??
                        //         payslip.paidLeaves);
                        // //  final updatedpayslip=screenController.currentPayslipDetails.value;
                        // //       screenController.totalAmountController.text= updatedpayslip!.totalAmount.toString();
                        // //       screenController.exceedLeaveDaysController.text=updatedpayslip!.exceededLeaveDays.toString();
                        // // Get the updated payslip
                        // final updatedpayslip =
                        //     screenController.currentPayslipDetails.value;

                        // // Update the controllers with the latest values
                        // if (updatedpayslip != null) {
                        //   screenController.exceedLeaveDaysController.text =
                        //       updatedpayslip.paidLeaves.toString();
                        //   screenController.totalAmountController.text =
                        //       updatedpayslip.totalAmount.toString();
                        //   screenController.lopLeavesController.text =
                        //       updatedpayslip.lopLeaveDays.toString();
                        //   screenController.takenLeavesController.text =
                        //       updatedpayslip.totalTakenPaidLeaves.toString();
                        //   screenController.allowedpaidLeavesController.text =
                        //       updatedpayslip.allowedPaidLeaves.toString();
                        // }
                        // setState(() {});
                        // if (screenController.isPayslipGenerated.value) {
                        //   invoiceController.setSelectedValues(
                        //       payslip.companyId,
                        //       payslip.userId,
                        //       payslip.year.toString(),
                        //       payslip.month.toString());
                        //   // Get.toNamed(
                        //   //     Routes.InvoicePage);
                        // }
                        await screenController.updatePayslipDetails(
                            payslip.userId,
                            int.tryParse(screenController
                                    .exceedLeaveDaysController.text) ??
                                payslip.paidLeaves);

                        // Only update the UI if this is still the same employee's payslip
                        if (mounted &&
                            screenController
                                    .currentPayslipDetails.value?.userId ==
                                payslip.userId) {
                          final updatedpayslip =
                              screenController.currentPayslipDetails.value;
                          if (updatedpayslip != null) {
                            screenController.exceedLeaveDaysController.text =
                                updatedpayslip.paidLeaves.toString();
                            screenController.totalAmountController.text =
                                updatedpayslip.totalAmount.toString();
                            screenController.lopLeavesController.text =
                                updatedpayslip.lopLeaveDays.toString();
                            screenController.takenLeavesController.text =
                                updatedpayslip.totalTakenPaidLeaves.toString();
                            screenController.allowedpaidLeavesController.text =
                                updatedpayslip.allowedPaidLeaves.toString();
                          }
                          setState(() {});
                        }

                        if (screenController.isPayslipGenerated.value) {
                          invoiceController.setSelectedValues(
                              payslip.companyId,
                              payslip.userId,
                              payslip.year.toString(),
                              payslip.month.toString());
                        }
                        screenController.fetchPayslipDetails();
                        Get.back();   
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                        onPressed: () async {
                          await screenController
                              .addPayslipDetails(payslip.userId);

                          if (screenController.isPayslipGenerated.value) {
                            invoiceController.setSelectedValues(
                                payslip.companyId,
                                payslip.userId,
                                payslip.year.toString(),
                                payslip.month.toString());
                            // Get.toNamed(
                            //     Routes.InvoicePage);
                          }
                        },
                        child: const Text(
                          'Generate',
                          style: TextStyle(
                              color: AppColors.defaultColor,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                buildSizedBoxH(kDefaultPadding * 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPayslipField(String label, TextInputType keyboardType,
      String? initialValue, TextEditingController? controller,
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
              //  initialValue: initialValue,
              controller: controller,
              // onChanged: (value) {
              //   // Ensure the controller's text is updated when the field changes
              //   controller!.text = value ?? '';
              // },
              cursorColor: AppColors.defaultColor,
              name: label.toLowerCase().replaceAll(' ', '_'),
              // initialValue: initialValue,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: AppColors.blackColor),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.greycolor)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.defaultColor, width: 1.5)),
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
                initialValue!,
                style: TextStyle(fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildAllowanceDeductionField(String label, String amount) {
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
