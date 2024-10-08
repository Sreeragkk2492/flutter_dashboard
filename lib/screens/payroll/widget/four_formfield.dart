import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/company_dropdown_item.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FourFormfield extends StatelessWidget {
  String heading;
  String fieldone;
  String fieldtwo;
  String fieldthree;
  String fieldfour;
  String labelone;
  String labeltwo;
  String labelthree;
  String labelfour;
  String defaultAddButton;
  FourFormfield(
      {super.key,
      required this.defaultAddButton,
      required this.heading,
      required this.fieldone,
      required this.fieldtwo,
      required this.fieldthree,
      required this.fieldfour,
      required this.labelone,
      required this.labeltwo,
      required this.labelthree,
      required this.labelfour});
  final screenController = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: AppColors.bgGreyColor, spreadRadius: 5, blurRadius: 7)
      ]),
      child: Card(
        color: AppColors.whiteColor,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(heading,
                  style: GoogleFonts.montserrat(
                      fontSize: kDefaultPadding + kTextPadding,
                      fontWeight: FontWeight.bold)),
              buildSizedBoxH(kDefaultPadding * 2),
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
                            if (screenController.companydetails.isEmpty) {
                    // Show loading indicator while fetching company details
                    return Center(child: CircularProgressIndicator());
                  }

                  if (screenController.isSuperAdmin.value) {
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
                      items: screenController.companydetails
                          .map((company) => DropdownMenuItem(
                                value: company,
                                child: Text(company.companyName),
                              ))
                          .toList(),
                      onChanged: (value) {
                        screenController.setSelectedCompany(value!.id, value.companyCode);
                      },
                    );
                  } else {
                    // Single company display for company admin
                    final company = screenController.companydetails[0];
                    // screenController.setSelectedCompany(
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
                        buildSizedboxW(kDefaultPadding),
                        Flexible(
                          child: FormBuilderDateTimePicker(
                            inputType: InputType.date,
                            format: DateFormat('yyyy-MM-dd'),
                            name: fieldtwo,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.calendar_month),
                              labelText: labeltwo,
                              // hintText: 'test.user',
                              // helperText: '* To test registration fail: admin',
                              border: const OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            // enableSuggestions: false,
                            validator: FormBuilderValidators.required(),
                            // onSaved: (value) => (_formData.username = value ?? ''),
                          ),
                        ),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 3),
                    Row(
                      children: [
                        Flexible(
                          child: FormBuilderDropdown(
                            name: fieldthree,
                            decoration: InputDecoration(
                              labelText: labelthree,
                              // hintText: 'test@gmail.com',
                              border: const OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                            // onSaved: (value) => (_formData.email = value ?? ''),
                          ),
                        ),
                        buildSizedboxW(kDefaultPadding),
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
                            buttonname: 'Add Processing Date',
                            onClick: () {
                              //  await screenController.addDepartment();
                              //  Get.back();
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
        ),
      ),
    );
  }
}
