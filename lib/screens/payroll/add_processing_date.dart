import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/company_pro_date_controller.dart';
import 'package:flutter_dashboard/screens/payroll/widget/four_formfield.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddProcessingDate extends StatelessWidget {
  AddProcessingDate({super.key});

  final screenController = Get.put(CompanyProccesingDateController());
  final employeeController = Get.put(EmployeeController());

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
                title: 'Add Processing Day',
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
            //                 Text('Add Processing Day',
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
                        Flexible(flex: 4, child: addprocessingdate(context)),
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
                        addprocessingdate(context),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    )));
  }

  Widget addprocessingdate(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          // Text('Add Processing Day',
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
                Obx(()=>
                   Row(
                    children: [
                      if (employeeController
                          .isSuperAdmin.value) // Only show if superadmin
                        Expanded(
                          flex: 1,
                          child: Obx(() {
                            if (employeeController.companydetails.isEmpty) {
                              return Center(child: CircularProgressIndicator());
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
                          }),
                        ),
                      buildSizedboxW(kDefaultPadding),
                      Expanded(
                        flex: 1,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: AppColors.defaultColor,
                              onPrimary: Colors.white,
                            ),
                            inputDecorationTheme: InputDecorationTheme(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.greycolor)),
                            ),
                          ),
                          child: FormBuilderDateTimePicker(
                            controller: screenController.processingdayController,
                            inputType: InputType.date,
                            format: DateFormat('yyyy-MM-dd'),
                            name: 'Date',
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_month),
                              labelText: 'Date',
                              // hintText: 'test.user',
                              // helperText: '* To test registration fail: admin',
                              labelStyle: TextStyle(color: AppColors.blackColor),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.greycolor)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.defaultColor, width: 1.5)),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                            // enableSuggestions: false,
                            validator: FormBuilderValidators.required(),
                            // onSaved: (value) => (_formData.username = value ?? ''),
                          ),
                        ),
                      ),
                      // Add spacer to push content to the left when company field is hidden
                      if (!employeeController.isSuperAdmin.value)
                        Expanded(flex: 1, child: SizedBox()),
                    ],
                  ),
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FormBuilderDropdown(
                        name: 'status',
                        decoration: InputDecoration(
                          labelText: 'status',
                          // hintText: 'test@gmail.com',
                          labelStyle: TextStyle(color: AppColors.blackColor),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.greycolor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.defaultColor, width: 1.5)),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        // keyboardType: TextInputType.emailAddress,
                        validator: FormBuilderValidators.required(),
                        items: [
                          DropdownMenuItem(
                            child: Text('Active'),
                            value: 'Active',
                          ),
                          DropdownMenuItem(
                            child: Text('InActive'),
                            value: 'InActive',
                          ),
                        ],
                        initialValue: screenController.selectedStatus,
                        onChanged: (value) {
                          screenController.selectedStatus = value;
                        },
                        // onSaved: (value) => (_formData.email = value ?? ''),
                      ),
                    ),
                    buildSizedboxW(kDefaultPadding),
                    Expanded(
                      flex: 1,
                      child: SizedBox())
                    // Flexible(
                    //   child: FormBuilderTextField(
                    //     name: fieldfour,
                    //     decoration: InputDecoration(
                    //       labelText: labelfour,
                    //        hintText: 'please add any remarks',
                    //       border: const OutlineInputBorder(),
                    //       floatingLabelBehavior: FloatingLabelBehavior.always,
                    //     ),
                    //     keyboardType: TextInputType.emailAddress,
                    //     validator: FormBuilderValidators.required(),
                    //     // onSaved: (value) => (_formData.email = value ?? ''),
                    //   ),
                    // ),
                  ],
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultAddButton(
                        buttonname: 'Add Processing Day',
                        onClick: () async {
                          await screenController.addProcessingDate();
                          // Get.back();
                        }),
                  ],
                ),
                // Divider(
                //   indent: kDefaultPadding * 2,
                //   endIndent: kDefaultPadding * 2,
                // ),
                buildSizedBoxH(kDefaultPadding * 3),
                // buildSizedBoxH(kDefaultPadding * 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
