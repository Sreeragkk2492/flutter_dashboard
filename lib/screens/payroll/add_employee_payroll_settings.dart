import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/custom_suggestion_feild.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/employee_models/user_model.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/employee_payroll_settings_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEmployeePayrollSettings extends StatelessWidget {
  AddEmployeePayrollSettings({super.key});

  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(EmployeePayrollSettingsController());
  final userNameController = TextEditingController();

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
                title: 'Add Employee Payroll',
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
            //                 Text('Add Employee Payroll',
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
        ),
      ],
    )));
  }

  Widget addPayrollForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Add Payroll',
          //   style: GoogleFonts.montserrat(
          //     fontSize: kDefaultPadding + kTextPadding,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // buildSizedBoxH(kDefaultPadding * 2),
          FormBuilder(
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Row(
                    children: [
                      if (employeeController
                          .isSuperAdmin.value) // Only show if superadmin
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(kDefaultPadding),
                            child: Obx(() {
                              if (employeeController.companydetails.isEmpty) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              return FormBuilderDropdown<Company>(
                                name: 'Company Name',
                                decoration: InputDecoration(
                                  labelText: 'Company Name',
                                  hintText: 'Select Company',
                                  labelStyle:
                                      TextStyle(color: AppColors.blackColor),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.greycolor)),
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
                          child: Obx(
                            () => CustomSuggessionTextFormField(
                              controller: userNameController,
                              hintText: 'Select User',
                              labelText: 'User Name',
                              suggestons: screenController.filteredUsers
                                  .map((user) => user.name)
                                  .toList(),
                              validator: FormBuilderValidators.required(),
                              width: MediaQuery.of(context).size.width * 0.4,
                              onSelected: () {
                                final selectedUser = screenController
                                    .filteredUsers
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
                            ),
                          ),
                        ),
                      ),
                      if (!employeeController.isSuperAdmin.value)
                        Expanded(flex: 1, child: SizedBox()),
                    ],
                  ),
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                Obx(() {
                  if (!screenController.isUserSelected.value) {
                    return Center(child: Text("Please select the fields."));
                  } else if (screenController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Allowances',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              buildSizedBoxH(kDefaultPadding),
                              ...screenController.getaddallowances
                                  .map((allowance) {
                                // Create a controller for each allowance

                                //  screenController.allowanceControllers[allowance.id] = controller;
                                screenController
                                    .allowanceControllers[allowance.allowanceId]
                                    ?.text ??= '0';

                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: kDefaultPadding),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(allowance.allowance),
                                      ),
                                      SizedBox(width: kDefaultPadding),
                                      Expanded(
                                        flex: 1,
                                        child: FormBuilderTextField(
                                          cursorColor: AppColors.defaultColor,
                                          //  initialValue: '0',
                                          name: 'amount',
                                          controller: screenController
                                                  .allowanceControllers[
                                              allowance.allowanceId],
                                          decoration: InputDecoration(
                                            labelText: 'Amount',
                                            labelStyle: TextStyle(
                                                color: AppColors.blackColor),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColors.greycolor)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColors.defaultColor,
                                                    width: 1.5)),
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                            FormBuilderValidators.numeric(),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        buildSizedboxW(kDefaultPadding * 2),
                        VerticalDivider(
                          thickness: 1,
                          color: Colors.grey,
                          width: 20,
                        ),
                        buildSizedboxW(kDefaultPadding * 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deductions',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              buildSizedBoxH(kDefaultPadding),
                              ...screenController.getadddeduction
                                  .map((deduction) {
                                screenController
                                    .deductionControllers[deduction.deductionId]
                                    ?.text ??= '0';
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: kDefaultPadding),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(deduction.deduction),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FormBuilderTextField(
                                          cursorColor: AppColors.defaultColor,
                                          // initialValue: '0',
                                          name: 'amount',
                                          controller: screenController
                                                  .deductionControllers[
                                              deduction.deductionId],
                                          decoration: InputDecoration(
                                            labelText: 'Amount',
                                            labelStyle: TextStyle(
                                                color: AppColors.blackColor),
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColors.greycolor)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColors.defaultColor,
                                                    width: 1.5)),
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator:
                                              FormBuilderValidators.compose([
                                            FormBuilderValidators.required(),
                                            FormBuilderValidators.numeric(),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
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
                      buttonname: 'Add Payroll',
                      onClick: () async {
                        await screenController.addPayroll();
                        // Get.back();
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
    );
  }
}
