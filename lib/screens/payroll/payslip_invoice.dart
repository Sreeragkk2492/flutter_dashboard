import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/payroll/controller/generator_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/invoice_controller.dart';
import 'package:flutter_dashboard/screens/payroll/widget/sheet.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PayslipInvoice extends StatelessWidget {
  PayslipInvoice({super.key});

  final screenController = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        // Navigate to the desired page when back gesture is triggered
        Get.offAllNamed(
            Routes.DASHBOARD); // Replace with your dashboard or home route
      },
      child: PortalMasterLayout(
          body: EntranceFader(
              child: ListView(
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
                          Text('Employee Payslip Generator',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
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
                      Flexible(flex: 4, child: addPayrollForm(context)),
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
                      addPayrollForm(context),
                      buildSizedBoxH(kDefaultPadding),
                    ],
                  ),
                ),
        ],
      ))),
    );
  }

  Widget addPayrollForm(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
                'Employee Payslip Generator',
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
                    buildSizedBoxH(kDefaultPadding * 3),
                    Obx(() {
                      if (screenController.isLoading.value) {
                        return const Center(
                          child:  AnimatedCircularProgressIndicator(
              size: 60.0,
              strokeWidth: 5.0,
              valueColor: AppColors.defaultColor,
            ),
                        );
                      } else if (screenController.noDataFound.value) {
                        return const Center(
                            child: Text(
                                "No data found for the selected criteria."));
                      } else {
                        return A4PayslipSheet(
                            content: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Zylker',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              buildSizedBoxH(kDefaultPadding * 1),
                              Text(
                                  '123 Elm Street Springfield, IL 62704 United States'),
                              Divider(),
                              screenSize.width >= kScreenWidthLg
                                  ? buildEmployeeDetails(
                                      'Payslip for the month of ${screenController.payslipDetails.value.month},${screenController.payslipDetails.value.year}',
                                      context)
                                  : buildEmployeeDetailsMobile(
                                      'Payslip for the month of ${screenController.payslipDetails.value.month},${screenController.payslipDetails.value.year}',
                                      context),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        screenSize.width >= kScreenWidthLg
                                            ? buildPayrollSection(
                                                'Allowance',
                                              )
                                            : buildPayrollSectionMobile(
                                                'Allowance'),
                                      ],
                                    ),
                                  ),
                                  buildSizedboxW(kDefaultPadding * 2),
                                  VerticalDivider(
                                    width: 20,
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        screenSize.width >= kScreenWidthLg
                                            ? buildPayrollDeductionSection(
                                                'Deduction')
                                            : buildPayrollDeductionSectionMobile(
                                                'Deduction')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              buildSizedBoxH(kDefaultPadding * 3),
                              Expanded(
                                  child: buildreimbersment('Reimbursement')),
                            ],
                          ),
                        ));
                      }
                    }),

                    buildSizedBoxH(kDefaultPadding * 3),
                    // Obx(() {
                    //   if (screenController.isCompanySelected.value &&
                    //       screenController.isUserSelected.value) {
                    //     return Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         DefaultAddButton(
                    //           buttonname: 'Generate',
                    //           onClick: () async {
                    //             // await screenController.addPayroll();
                    //             Get.back();
                    //           },
                    //         ),
                    //       ],
                    //     );
                    //   } else {
                    //     return SizedBox.shrink();
                    //   }
                    // }),
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

  Widget buildEmployeeDetails(String title, BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Row(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildSizedBoxH(kDefaultPadding * 2),
              Text(
                'Employee Pay Summary',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              buildSizedBoxH(kDefaultPadding * 1),
              Padding(
                padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                       // style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Employee Id: ",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text:
                                "${screenController.payslipDetails.value.employeeId}",
                          ),
                        ],
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1),
                   RichText(
                      text: TextSpan(
                       // style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: " Exceeded Leave Days: ",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          
                          TextSpan(
                            text:
                                "${screenController.payslipDetails.value.paidLeaves}",
                          ),
                        ],
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1),
                     RichText(
                      text: TextSpan(
                       // style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Overtime Hour: ",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          
                          TextSpan(
                            text:
                                "${screenController.payslipDetails.value.overtimeHours}",
                          ),
                        ],
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1),
                     RichText(
                      text: TextSpan(
                       // style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: "Regular Hours: ",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          
                          TextSpan(
                            text:
                                "${screenController.payslipDetails.value.regularHours}",
                          ),
                        ],
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1),
                  ],
                ),
              ),
              buildSizedBoxH(kDefaultPadding * 3),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  width: 310,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Employee Net Pay'),
                      buildSizedBoxH(kDefaultPadding * 1),
                      Text(
                        '₹1,06,800.00',
                        style: TextStyle(
                            fontSize: 25,
                            color: AppColors.hoverColor,
                            fontWeight: FontWeight.bold),
                      ),
                      buildSizedBoxH(kDefaultPadding * 1),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('paid date :28'),
                            VerticalDivider(),
                            Text('LOP days:3')
                          ],
                        ),
                      ),
                    ],
                  ))),
        )
      ],
    );
  }

  Widget buildEmployeeDetailsMobile(String title, BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool isMobile = screenSize.width < kScreenWidthLg;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        Text(
          'Employee Pay Summary',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        ...screenController.allowances.map((item) => Padding(
              padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(item.allowanceName),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(item.amount.toString()),
                  ),
                ],
              ),
            )),
        buildSizedBoxH(kDefaultPadding * 3),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Employee Net Pay'),
              buildSizedBoxH(kDefaultPadding),
              Text(
                '₹1,06,800.00',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 25,
                  color: AppColors.hoverColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildSizedBoxH(kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text('paid date: 28', textAlign: TextAlign.center),
                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Text('LOP days: 3', textAlign: TextAlign.center),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPayrollSection(
    String title,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        buildSizedBoxH(kDefaultPadding),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 2,
              child:
                  Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 1,
              child: Text('YTD', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        buildSizedBoxH(kDefaultPadding / 2),
        ...screenController.payslipDetails.value.allowances!.map((item) => Padding(
              padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(item.allowanceName),
                  ),
                  buildSizedBoxH(kDefaultPadding * 2),
                  Expanded(flex: 2, child: Text(item.amount.toString())),
                  buildSizedBoxH(kDefaultPadding * 2),
                  Expanded(
                    flex: 1,
                    child: Text('0.00'), // Placeholder for YTD value
                  ),
                ],
              ),
            )),
        buildSizedBoxH(kDefaultPadding * 3),
        Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  'Total Allowance',
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
            Expanded(flex: 1, child: Text(screenController.totalAllowances.toString())),
          ],
        )
      ],
    );
  }

  Widget buildPayrollSectionMobile(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 16.0),
        //   child: Text(
        //     title,
        //     style: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        Row(
          children: [
            Expanded(
              flex: 22,
              child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 16,
              child:
                  Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 10,
              child: Text('YTD', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        buildSizedBoxH(kDefaultPadding / 2),
        ...screenController.payslipDetails.value.allowances!.map((item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 22,
                    child: Text(item.allowanceName),
                  ),
                  Expanded(
                    flex: 16,
                    child: Text(item.amount.toString()),
                  ),
                  Expanded(
                    flex: 10,
                    child: Text('0.00'), // Placeholder for YTD value
                  ),
                ],
              ),
            )),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                'Total Allowance',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                screenController.totalAllowances.toString(), // Replace with actual total
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildPayrollDeductionSection(
    String title,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        buildSizedBoxH(kDefaultPadding),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 2,
              child:
                  Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 1,
              child: Text('YTD', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        buildSizedBoxH(kDefaultPadding / 2),
        ...screenController.payslipDetails.value.deductions! .map((item) => Padding(
              padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(item.deductionName),
                  ),
                  buildSizedBoxH(kDefaultPadding * 2),
                  Expanded(flex: 2, child: Text(item.amount.toString())),
                  buildSizedBoxH(kDefaultPadding * 2),
                  Expanded(
                    flex: 1,
                    child: Text('0.00'), // Placeholder for YTD value
                  ),
                ],
              ),
            )),
        buildSizedBoxH(kDefaultPadding * 3),
        Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  'Total Deduction',
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
            Expanded(flex: 1, child: Text(screenController.totalDeductions.toString())),
          ],
        )
      ],
    );
  }

  Widget buildPayrollDeductionSectionMobile(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 16.0),
        //   child: Text(
        //     title,
        //     style: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        Row(
          children: [
            Expanded(
              flex: 22,
              child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 16,
              child:
                  Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 10,
              child: Text('YTD', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        buildSizedBoxH(kDefaultPadding / 2),
        ...screenController.payslipDetails.value.deductions! .map((item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 22,
                    child: Text(item.deductionName),
                  ),
                  Expanded(
                    flex: 16,
                    child: Text(item.amount.toString()),
                  ),
                  Expanded(
                    flex: 10,
                    child: Text('0.00'), // Placeholder for YTD value
                  ),
                ],
              ),
            )),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                'Total Deduction',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                screenController.totalDeductions.toString(), // Replace with actual total
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildreimbersment(
    String title,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        buildSizedBoxH(kDefaultPadding),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child:
                  Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text('YTD', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        buildSizedBoxH(kDefaultPadding / 2),
        // ...screenController.allowances.map((item) => Padding(
        //       padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
        //       child: Row(
        //         children: [
        //           Expanded(
        //             flex: 2,
        //             child: Text('Fuel Reimbursement'),
        //           ),
        //           buildSizedBoxH(kDefaultPadding * 2),
        //           Expanded(flex: 1, child: Text('200')),
        //           buildSizedBoxH(kDefaultPadding * 2),
        //           Expanded(
        //             flex: 1,
        //             child: Text('0.00'), // Placeholder for YTD value
        //           ),
        //         ],
        //       ),
        //     )),
        buildSizedBoxH(kDefaultPadding * 3),
      ],
    );
  }
}
