import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/company_payroll_allowance_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/company_models/company_models.dart';

class AddCompanyAllowanceDetails extends StatelessWidget {
  AddCompanyAllowanceDetails({super.key});

  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(CompanyPayrollAllowanceController());
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return PortalMasterLayout(
        body: ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: UIComponenetsAppBarNoButton(
                title: 'Add Company Allowance',
                subtitle: Text(''),
                icon: Icon(Icons.rocket),
              ),
            ),
            // Stack(
            //   alignment: Alignment.bottomCenter,
            //   children: [
            //     Container(
            //       height: 150,
            //       color: AppColors.defaultColor.withOpacity(0.6),
            //     ),
            //     Align(
            //       // heightFactor: 0.01,
            //       child: Container(
            //         height: 100,
            //         alignment: Alignment.centerLeft,
            //         padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            //         margin: EdgeInsets.all(kDefaultPadding),
            //         decoration: BoxDecoration(
            //             color: AppColors.bgGreyColor,
            //             borderRadius: BorderRadius.circular(12)),
            //         child: Row(
            //           children: [
            //             Container(
            //               height: 70,
            //               width: 70,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   image: DecorationImage(
            //                       image: AssetImage('assets/profile3.jpg'),
            //                       fit: BoxFit.cover)),
            //             ),
            //             buildSizedboxW(kDefaultPadding),
            //             const Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Add Company Allowance',
            //                     style: TextStyle(
            //                         fontSize: 16.0,
            //                         fontWeight: FontWeight.bold)),
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // buildSizedBoxH(kDefaultPadding * 3),
            screenSize.width >= kScreenWidthLg
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding + kTextPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(flex: 4, child: addCompanyallowance()),
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
                        addCompanyallowance(),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    ));
  }

  Widget addCompanyallowance() {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          // Text('Add Company Allowance',
          //     style: GoogleFonts.montserrat(
          //         fontSize: kDefaultPadding + kTextPadding,
          //         fontWeight: FontWeight.bold)),
          // buildSizedBoxH(kDefaultPadding * 2),
          FormBuilder(
            //  key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Obx(() {
                        // Check if there's only one company (the logged-in user's company)
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
                              labelStyle:
                                  TextStyle(color: AppColors.blackColor),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.greycolor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.defaultColor,
                                      width: 1.5)),
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
                              screenController.onCompanySelected(
                                  value!.id, value.companyCode);
                            },
                          );
                        } else {
                          // Single company display for company admin
                          final company = employeeController.companydetails[0];
                          // screenController.onCompanySelected(company.id,company.companyCode);
                          return FormBuilderTextField(
                            name: 'Company Name',
                            initialValue: company.companyName,
                            decoration: InputDecoration(
                              labelText: 'Company Name',
                              labelStyle:
                                  TextStyle(color: AppColors.blackColor),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.greycolor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.defaultColor,
                                      width: 1.5)),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            readOnly: true,
                          );
                        }
                      }),
                    ),
                  ],
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                Obx(() {
                  // Check if a company is selected
                  if (screenController.isLoading.value) {
                    return Center(
                        child: AnimatedCircularProgressIndicator(
                      size: 60.0,
                      strokeWidth: 5.0,
                      valueColor: AppColors.defaultColor,
                    ));
                  } else if (!screenController.isCompanySelected.value) {
                    return Center(
                        child: Text(
                            "Please select a company to view allowances."));
                  } else if (screenController.companyAllowances.isEmpty) {
                    return Center(
                        child: Text(
                            "No allowances available for the selected company."));
                  } else {
                    // Display the list of allowances as checkboxes
                    return GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: screenController.companyAllowances
                          .map((allowance) => CheckboxListTile(
                                activeColor: AppColors.defaultColor,
                                title: Text(allowance.allowance),
                                value: allowance.isSelected,
                                onChanged: (bool? value) {
                                  screenController
                                      .toggleAllowance(allowance.allowanceId);
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ))
                          .toList(),
                    );
                  }
                }),
                buildSizedBoxH(kDefaultPadding * 3),
                // Row(
                //   children: [
                //     Flexible(
                //       child:
                //     ),
                //     buildSizedboxW(kDefaultPadding),
                //   ],
                // ),
                buildSizedBoxH(kDefaultPadding * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultAddButton(
                        buttonname: 'Add Company Allowance',
                        onClick: () async {
                          await screenController.addCompanyPayrollAllowance();
                          Get.back();
                        }),
                  ],
                ),
                buildSizedBoxH(kDefaultPadding * 5),
                // Divider(
                //   indent: kDefaultPadding * 2,
                //   endIndent: kDefaultPadding * 2,
                // ),
                // buildSizedBoxH(kDefaultPadding * 3),
                // buildSizedBoxH(kDefaultPadding * 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
