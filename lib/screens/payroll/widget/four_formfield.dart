import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

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
  FourFormfield(
      {super.key,
      required this.heading,
      required this.fieldone,
      required this.fieldtwo,
      required this.fieldthree,
      required this.fieldfour,
      required this.labelone,
      required this.labeltwo,
      required this.labelthree,
      required this.labelfour});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(color: AppColors.bgGreyColor),
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
                      child: FormBuilderTextField(
                        name: fieldtwo,
                        decoration: InputDecoration(
                          labelText: labeltwo,
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
                  ],
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                Row(
                  children: [
                    Flexible(
                      child: FormBuilderTextField(
                        name: fieldthree,
                        decoration: InputDecoration(
                          labelText: labelthree,
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
                      child: FormBuilderTextField(
                        name: fieldfour,
                        decoration: InputDecoration(
                          labelText: labelfour,
                          // hintText: 'test@gmail.com',
                          border: const OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: FormBuilderValidators.required(),
                        // onSaved: (value) => (_formData.email = value ?? ''),
                      ),
                    ),
                  ],
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                Divider(
                  indent: kDefaultPadding * 2,
                  endIndent: kDefaultPadding * 2,
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                buildSizedBoxH(kDefaultPadding * 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
