import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
     final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
          Text('Edit Profile',
              style: GoogleFonts.montserrat(
                  fontSize: kDefaultPadding + kTextPadding,
                  fontWeight: FontWeight.bold)),
          buildSizedBoxH(kDefaultPadding),
          Text(
            'USER INFORMATION',
            style: themeData.textTheme.labelLarge,
          ),
          buildSizedBoxH(kDefaultPadding * 2),
          FormBuilder(
            //key: _formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: FormBuilderTextField(
                        name: 'username',
                        decoration: const InputDecoration(
                          labelText: 'userrname',
                          hintText: 'test.user',
                          // helperText: '* To test registration fail: admin',
                          border: OutlineInputBorder(),
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
                        name: 'email',
                        decoration: const InputDecoration(
                          labelText: 'email',
                          hintText: 'test@gmail.com',
                          border: OutlineInputBorder(),
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
                Row(
                  children: [
                    Flexible(
                      child: FormBuilderTextField(
                        name: 'First name',
                        decoration: const InputDecoration(
                          labelText: 'First name',
                          hintText: 'test',
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
                    Flexible(
                      child: FormBuilderTextField(
                        name: 'Last name',
                        decoration: const InputDecoration(
                          labelText: 'Last name',
                          hintText: 'user',
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        keyboardType: TextInputType.name,
                        validator: FormBuilderValidators.required(),
                      //  onSaved: (value) => (_formData.lastname = value ?? ''),
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
                Text(
                  'CONTACT INFORMATION',
                  style: themeData.textTheme.labelLarge,
                ),
                buildSizedBoxH(kDefaultPadding * 2),
                FormBuilderTextField(
                  name: 'Address',
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: 'A-xyz test near test',
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  enableSuggestions: false,
                  validator: FormBuilderValidators.required(),
                 // onSaved: (value) => (_formData.address = value ?? ''),
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                Row(
                  children: [
                    Flexible(
                      child: FormBuilderTextField(
                          name: 'City',
                          decoration: const InputDecoration(
                            labelText: 'City',
                            hintText: 'Surat',
                            border: OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          enableSuggestions: false,
                          keyboardType: TextInputType.text,
                          validator: FormBuilderValidators.required(),
                         // onSaved: (value) => (_formData.city = value ?? '')
                          ),
                    ),
                    buildSizedboxW(kDefaultPadding),
                    Flexible(
                      child: FormBuilderTextField(
                        name: 'Country',
                        decoration: const InputDecoration(
                          labelText: 'Country',
                          hintText: 'India',
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        keyboardType: TextInputType.text,
                        validator: FormBuilderValidators.required(),
                       // onSaved: (value) => (_formData.country = value ?? ''),
                      ),
                    ),
                    buildSizedboxW(kDefaultPadding),
                    Flexible(
                      child: FormBuilderTextField(
                        name: 'Postal code',
                        decoration: const InputDecoration(
                          labelText: 'Postal code',
                          hintText: '395010',
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.required(),
                        // onSaved: (value) =>
                        //     (_formData.postalCode = value ?? ''),
                      ),
                    ),
                  ],
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                 Divider(
                    indent: kDefaultPadding * 2,
                    endIndent: kDefaultPadding * 2),
                buildSizedBoxH(kDefaultPadding * 3),
                Text('ABOUT ME', style: themeData.textTheme.labelLarge),
                Text("Built with ❤️ in Flutter",
                    style: themeData.textTheme.labelMedium)
              ],
            ),
          ),
      ],
    );
  }
}