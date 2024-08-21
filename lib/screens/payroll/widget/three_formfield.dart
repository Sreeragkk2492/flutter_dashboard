import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/allowance_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class ThreeFormfield extends StatelessWidget {
  String heading;
  String fieldone;
  String fieldtwo;
  String fieldthree;
  String labelone;
  String labeltwo;
  String labelthree;
  String defaultAddButton;
   ThreeFormfield(
      {super.key,
      required this.defaultAddButton,
      required this.heading,
      required this.fieldone,
      required this.fieldtwo,
      required this.fieldthree,
      required this.labelone,
      required this.labeltwo,
      required this.labelthree});

       final _formKey = GlobalKey<FormState>();

       final screenController=Get.put(AllowanceController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: AppColors.bgGreyColor,
                    spreadRadius: 5,
                    blurRadius: 7)
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
            // buildSizedBoxH(kDefaultPadding),
            // Text(
            //   'USER INFORMATION',
            //   style: themeData.textTheme.labelLarge,
            // ),
            buildSizedBoxH(kDefaultPadding * 2),
            FormBuilder(
                key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: FormBuilderTextField(
                          name: fieldone,
                          decoration: InputDecoration(
                            labelText: labelone,
                            // hintText: 'test.user',
                            // helperText: '* To test registration fail: admin',
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          enableSuggestions: false,
                          validator: FormBuilderValidators.required(),
                          // onSaved: (value) => (_formData.username = value ?? ''),
                        ),
                      ),
                      buildSizedboxW(kDefaultPadding),
                      Flexible(
                        child:  FormBuilderDropdown(
                            name: fieldtwo,
                            decoration: InputDecoration(
                              labelText: labeltwo,
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
                    ],
                  ),
                  buildSizedBoxH(kDefaultPadding * 3),
                  Row(
                    children: [
                      Flexible(
                        child: FormBuilderTextField(
                          name: fieldthree,
                          decoration:  InputDecoration(
                            labelText: labelthree,
                            hintText: 'please add your remarks', 
                            border: OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          enableSuggestions: false,
                          keyboardType: TextInputType.name,
                          validator: FormBuilderValidators.required(),
                          // onSaved: (value) => (_formData.firstname = value ?? ''),
                        ),
                      ),
                      buildSizedboxW(kDefaultPadding),
                    ],
                  ),
                  buildSizedBoxH(kDefaultPadding * 3),
                   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultAddButton(
                        buttonname: defaultAddButton,
                        onClick: () {
                        //  await screenController.addDepartment();
                        //  Get.back();
                           
                        }),
                  ],
                ),
                //  buildSizedBoxH(kDefaultPadding * 3),
                //   Divider(
                //     indent: kDefaultPadding * 2,
                //     endIndent: kDefaultPadding * 2,
                //   ),
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
