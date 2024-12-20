import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/company_models/holiday_textcontrollerModel.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_holiday_list_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddCompanyHoliday extends StatelessWidget {
  AddCompanyHoliday({super.key});

  final screenController = Get.put(CompanyHolidayListController());
  final employeecontroller = Get.put(EmployeeController());
  final _formKey = GlobalKey<FormState>();

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
                title: 'Add Company Holiday',
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
            //                 Text('Add Company Holiday',
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
            //   buildSizedBoxH(kDefaultPadding * 3),
            screenSize.width >= kScreenWidthLg
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding + kTextPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(flex: 4, child: addCompanyLeaveType(context)),
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
                        addCompanyLeaveType(context),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    )));
  }

  Widget addCompanyLeaveType(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          // Text('Add Company Holiday',
          //     style: GoogleFonts.montserrat(
          //         fontSize: kDefaultPadding + kTextPadding,
          //         fontWeight: FontWeight.bold)),
          // buildSizedBoxH(kDefaultPadding * 2),
          FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Obx(() {
                        // Check if there's only one company (the logged-in user's company)
                        if (employeecontroller.companydetails.isEmpty) {
                          // Show loading indicator while fetching company details
                          return Center(child: CircularProgressIndicator());
                        }

                        if (employeecontroller.isSuperAdmin.value) {
                          // Dropdown for superadmin
                          return FormBuilderDropdown<Company>(
                            name: 'Company Name',
                            decoration: InputDecoration(
                              labelText: 'Company Name',
                              hintText: 'Select Company',
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            validator: FormBuilderValidators.required(),
                            items: employeecontroller.companydetails
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
                          final company = employeecontroller.companydetails[0];
                          // Automatically select the company for the admin
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            screenController.onCompanySelected(
                                company.id, company.companyCode);
                          });
                          return FormBuilderTextField(
                            name: 'Company Name',
                            initialValue: company.companyName,
                            decoration: InputDecoration(
                              labelStyle:
                                  TextStyle(color: AppColors.blackColor),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.defaultColor,
                                      width: 1.5)),
                              labelText: 'Company Name',
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.greycolor)),
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

                Obx(() => Column(
                      children: [
                        ...screenController.leaveTypeEntries
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          HolidayTypeEntry leaveEntry = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(bottom: kDefaultPadding),
                            child: Row(
                              children: [
                                Expanded(
                                  child: FormBuilderTextField(
                                    cursorColor: AppColors.defaultColor,
                                    name: 'Holiday Name',
                                    controller: leaveEntry.typeController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.defaultColor,
                                              width: 1.5)),
                                      labelText: 'Holiday Name',
                                      labelStyle: TextStyle(
                                          color: AppColors.blackColor),
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.greycolor)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    validator: FormBuilderValidators.required(),
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding),
                                Expanded(
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: AppColors.defaultColor,
                                        onPrimary: Colors.white,
                                      ),
                                      inputDecorationTheme:
                                          InputDecorationTheme(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
                                      ),
                                    ),
                                    child: FormBuilderDateTimePicker(
                                      name: 'Leave Date $index',
                                      controller: leaveEntry.dateController,
                                      inputType: InputType.date,
                                      format: DateFormat('yyyy-MM-dd'),
                                      decoration: InputDecoration(
                                        labelText: 'Date',
                                        labelStyle: TextStyle(
                                            color: AppColors.blackColor),
                                        border: OutlineInputBorder(),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                      style: TextStyle(
                                          color: AppColors.blackColor),
                                      validator:
                                          FormBuilderValidators.required(),
                                    ),
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding),
                                if (index ==
                                    screenController.leaveTypeEntries.length -
                                        1)
                                  ElevatedButton(
                                    onPressed: () {
                                      screenController.addLeaveType();
                                    },
                                    child: Text('Add New'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.defaultColor,
                                      foregroundColor: AppColors.whiteColor,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    )),

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
                        buttonname: 'Add Company Holiday',
                        onClick: () async {
                          await screenController.addCompanyHoliday();
                          //Get.back();
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
