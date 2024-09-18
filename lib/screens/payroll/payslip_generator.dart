import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/user_model.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/generator_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/invoice_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/payroll_settings_controller.dart';
import 'package:flutter_dashboard/screens/payroll/widget/sheet.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PayslipGenerator extends StatelessWidget {
  PayslipGenerator({super.key});

  final screenController = Get.put(InvoiceController());
  final employeeController = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
       Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBarNoButton(
            title: 'Employee Generated Payslip',
            subtitle: '',
            icon: Icon(Icons.rocket),

          ),
        ),
        buildSizedBoxH(kDefaultPadding  ),
        screenSize.width >= kScreenWidthLg
            ? Padding(
                padding: EdgeInsets.symmetric(
                    //  horizontal: kDefaultPadding,
                    ),
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
    )));
  }

  Widget addPayrollForm(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: AppColors.bgGreyColor,
      //       spreadRadius: 5,
      //       blurRadius: 7,
      //     )
      //   ],
      // ),
      child: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Employee Generated Payslip',
            //   // style: GoogleFonts.montserrat(
            //   //   fontSize: kDefaultPadding + kTextPadding,
            //   //   fontWeight: FontWeight.bold,
            //   // ),
            //   style: TextStyle(
            //       fontSize: kDefaultPadding + kTextPadding,
            //       fontWeight: FontWeight.w700),
            // ),
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
                        border: OutlineInputBorder(),
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
                        border: OutlineInputBorder(),
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
                              // invoiceController.selectedYear.value = value;
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
                              // invoiceController.selectedMonth.value = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildSizedBoxH(kDefaultPadding * 3),
                  Obx(() {
                    if (
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
                      return Center(child: Text("No Generated Data Found!"));
                    } else {
                      buildSizedboxW(kDefaultPadding * 3);
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
              buildSizedBoxH(kDefaultPadding * 2),
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
                            text: "Leave Days: ",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text:
                                "${screenController.payslipDetails.value.leavedays}",
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
        ...screenController.allowances.map((item) => Padding(
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
            Expanded(flex: 1, child: Text('500')),
          ],
        )
      ],
    );
  }

  Widget buildPayrollSectionMobile(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      buildSizedBoxH(kDefaultPadding / 2),
      Row(
        children: [
          Expanded(flex: 3, child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text('YTD', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
      buildSizedBoxH(kDefaultPadding / 2),
      ...screenController.allowances.map((item) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(item.allowanceName, overflow: TextOverflow.ellipsis)),
            Expanded(flex: 2, child: Text(item.amount.toString(), textAlign: TextAlign.right)),
            Expanded(flex: 1, child: Text('0.00', textAlign: TextAlign.right)),
          ],
        ),
      )),
      Divider(),
      Row(
        children: [
          Expanded(flex: 3, child: Text('Total Allowance', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(
            flex: 3,
            child: Text(
              '500', // Replace with actual total
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
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
        ...screenController.deductions.map((item) => Padding(
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
        buildSizedBoxH(kDefaultPadding * 5),
        Row(
          children: [
            Expanded(
                flex: 2,
                child: Text(
                  'Total Deduction',
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
            Expanded(flex: 1, child: Text('500')),
          ],
        )
      ],
    );
  }

 Widget buildPayrollDeductionSectionMobile(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      buildSizedBoxH(kDefaultPadding / 2),
      Row(
        children: [
          Expanded(flex: 3, child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text('YTD', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
      buildSizedBoxH(kDefaultPadding / 2),
      ...screenController.deductions.map((item) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(flex: 3, child: Text(item.deductionName, overflow: TextOverflow.ellipsis)),
            Expanded(flex: 2, child: Text(item.amount.toString(), textAlign: TextAlign.right)),
            Expanded(flex: 1, child: Text('0.00', textAlign: TextAlign.right)),
          ],
        ),
      )),
      Divider(),
      Row(
        children: [
          Expanded(flex: 3, child: Text('Total Deduction', style: TextStyle(fontWeight: FontWeight.w600))),
          Expanded(
            flex: 3,
            child: Text(
              '500', // Replace with actual total
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
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
