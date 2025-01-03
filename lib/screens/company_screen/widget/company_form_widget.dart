import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/models/settings/industry_model.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/industry_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyFormWidget extends StatelessWidget {
  CompanyFormWidget({
    super.key,
  });
  final screenController = Get.put(CompanyController());
  final industryController = Get.put(IndustryController());
  final _formKey = GlobalKey<FormState>();

  bool isVATSelected = false;

  bool isGSTSelected = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      // key:_formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Obx(
                  () => FormBuilderDropdown(
                    // controller: widget.statusController,
                    name: 'Category/Industry',
                    decoration: const InputDecoration(
                      labelText: 'Category/Industry',
                     // hintText: 'Category/Industry',
                       labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // enableSuggestions: false,
                    // keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),
                    items: industryController.industries
                        .map((industry) => DropdownMenuItem(
                              value: industry.id,
                              child: Text(industry.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                       screenController.setSelectedCompanyTypeID(value!);
                    },
                    // onSaved: (value) => (_formData.firstname = value ?? ''),
                  ),
                ),
              ),
              buildSizedboxW(kDefaultPadding),
              Flexible(
                child: FormBuilderTextField(
                  cursorColor: AppColors.defaultColor,
                  controller: screenController.companyCodeController,
                  name: 'Company Code',
                  decoration: InputDecoration(
                    labelText: 'Company Code',
                   // hintText: 'test@gmail.com',
                     labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
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
                  cursorColor: AppColors.defaultColor, 
                  controller: screenController.companyNameController,
                  name: 'Company Name',
                  decoration: const InputDecoration(
                    labelText: 'Company Name',
                   // hintText: 'Test',
                     labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  enableSuggestions: false,
                  keyboardType: TextInputType.name,
                  validator: FormBuilderValidators.required(),
                  // onSaved: (value) => (_formData.firstname = value ?? ''),
                ),
              ),
              buildSizedboxW(kDefaultPadding),
              // Flexible(
              //   child:Obx(()=>
              //        FormBuilderDropdown(
              //         // controller: widget.statusController,
              //         name: 'Category/Industry',
              //         decoration: const InputDecoration(
              //           labelText: 'Category/Industry',
              //           hintText: 'Category/Industry',
              //           border: OutlineInputBorder(),
              //           floatingLabelBehavior: FloatingLabelBehavior.always,
              //         ),
              //         // enableSuggestions: false,
              //         // keyboardType: TextInputType.name,
              //         validator: FormBuilderValidators.required(),
              //         items: industryController.industries
              //             .map((industry) => DropdownMenuItem(
              //                   value: industry.id,
              //                   child: Text(industry.name),
              //                 ))
              //             .toList(),
              //         onChanged: (value) {
              //         //  screenController.setSelectedDesignation(value!);
              //         },
              //         // onSaved: (value) => (_formData.firstname = value ?? ''),
              //       ),
              //     ),
              // ),
            ],
          ),
          buildSizedBoxH(kDefaultPadding * 3),
          Row(
            children: [
              Flexible(
                child: FormBuilderDropdown(
                  name: 'Status',
                  decoration: InputDecoration(
                    labelText: 'Status',
                    // hintText: 'test@gmail.com',
                     labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
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
                  onChanged: (value) => screenController.selectedStatus = value,
                  // onSaved: (value) => (_formData.email = value ?? ''),
                ),
              ),
              buildSizedboxW(kDefaultPadding),
              Flexible(
                child: FormBuilderTextField(
                  cursorColor: AppColors.defaultColor, 
                  controller: screenController.groupNameController,
                  name: 'Group Name',
                  decoration: const InputDecoration(
                    labelText: 'Group Name',
                   // hintText: 'User',
                    labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
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
          Text('Detailed Information',
              style: GoogleFonts.montserrat(
                  fontSize: kDefaultPadding + kTextPadding,
                  fontWeight: FontWeight.bold)),
          buildSizedBoxH(kDefaultPadding * 2),
          Row(
            children: [
              Flexible(
                child: FormBuilderTextField(
                  cursorColor: AppColors.defaultColor,
                  controller: screenController.legalNameController,
                  name: 'Legal Name',
                  decoration: const InputDecoration(
                    labelText: 'Legal Name',
                   // hintText: 'Legal Name',
                    labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
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
                  cursorColor: AppColors.defaultColor,
                  controller: screenController.founderorOwnerController,
                  name: 'Founder/Owner',
                  decoration: const InputDecoration(
                    labelText: 'Founder/Owner',
                   // hintText: 'Founder/Owner',
                     labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  keyboardType: TextInputType.name,
                  validator: FormBuilderValidators.required(),
                  //  onSaved: (value) => (_formData.lastname = value ?? ''),
                ),
              ),
            ],
          ),
          buildSizedBoxH(kDefaultPadding * 2),
          Row(
            children: [
              Flexible(
                child: FormBuilderTextField(
                  cursorColor: AppColors.defaultColor,
                  controller: screenController.emailController,
                  name: 'Email',
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    // hintText: 'Email',
                     labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  enableSuggestions: false,
                  keyboardType: TextInputType.name,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                  // onSaved: (value) => (_formData.firstname = value ?? ''),
                ),
              ),
              buildSizedboxW(kDefaultPadding),
              Flexible(
                child: FormBuilderTextField(
                  cursorColor: AppColors.defaultColor,
                  controller: screenController.panController,
                  name: 'Pan',
                  decoration: const InputDecoration(
                    labelText: 'Pan',
                    // hintText: 'Pan',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  keyboardType: TextInputType.name,
                  validator: FormBuilderValidators.required(),
                  //  onSaved: (value) => (_formData.lastname = value ?? ''),
                ),
              ),
            ],
          ),
          buildSizedBoxH(kDefaultPadding * 2),
          Row(
            children: [
              Flexible(
                child: FormBuilderTextField(
                  cursorColor: AppColors.defaultColor,
                  controller: screenController.whatsappController,
                  name: 'Whatsapp',
                  decoration: const InputDecoration(
                    labelText: 'Whatsapp',
                    // hintText: 'Whatsapp',
                     labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  enableSuggestions: false,
                  keyboardType: TextInputType.name,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.maxLength(10),
                    FormBuilderValidators.minLength(10),
                    (value) {
                      if (value != null && value.length != 10) {
                        return 'Phone number must be exactly 10 digits';
                      }
                      return null;
                    },
                  ]),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  // onSaved: (value) => (_formData.firstname = value ?? ''),
                ),
              ),
              buildSizedboxW(kDefaultPadding),
              Flexible(
                child: FormBuilderTextField(
                  cursorColor: AppColors.defaultColor,
                  controller: screenController.phonenumberController,
                  name: 'Phone Number',
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    // hintText: 'Phone Number',
                    labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  keyboardType: TextInputType.name,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.maxLength(10),
                    FormBuilderValidators.minLength(10),
                    (value) {
                      if (value != null && value.length != 10) {
                        return 'Phone number must be exactly 10 digits';
                      }
                      return null;
                    },
                  ]),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  //  onSaved: (value) => (_formData.lastname = value ?? ''),
                ),
              ),
            ],
          ),
          buildSizedBoxH(kDefaultPadding * 2),
          FormBuilderTextField(
            cursorColor: AppColors.defaultColor, 
            controller: screenController.addressController,
            name: 'Address',
            decoration: const InputDecoration(
              labelText: 'Address',
              // hintText: 'A-xyz test near test',
               labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            enableSuggestions: false,
            validator: FormBuilderValidators.required(),
            // onSaved: (value) => (_formData.address = value ?? ''),
          ),
          buildSizedBoxH(kDefaultPadding * 2),
          FormBuilderTextField(
            cursorColor: AppColors.defaultColor,
            controller: screenController.landmarkController,
            name: 'Landmark',
            decoration: const InputDecoration(
              labelText: 'Landmark',
              // hintText: 'Landmark',
               labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
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
                child: FormBuilderDropdown(
                  items: [
                    DropdownMenuItem(
                      child: Text('kannur'),
                      value: 'kannur',
                    ),
                    DropdownMenuItem(
                      child: Text('Ernakulam'),
                      value: 'Ernakulam',
                    ),
                  ],
                  // controller: widget.cityController,
                  name: 'City',
                  decoration: const InputDecoration(
                    labelText: 'City',
                    // hintText: 'Surat',
                     labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  // enableSuggestions: false,
                  // keyboardType: TextInputType.text,
                  validator: FormBuilderValidators.required(),
                  // onSaved: (value) => (_formData.city = value ?? '')
                ),
              ),
              buildSizedboxW(kDefaultPadding),
              Flexible(
                child: FormBuilderDropdown(
                  items: [
                    DropdownMenuItem(
                      child: Text('kerala'),
                      value: 'kerala',
                    ),
                    DropdownMenuItem(
                      child: Text('karnataka'),
                      value: 'karnataka',
                    ),
                    DropdownMenuItem(
                      child: Text('Delhi'),
                      value: 'Delhi',
                    )
                  ],
                  // controller: widget.stateController,
                  name: 'State',
                  decoration: const InputDecoration(
                    labelText: 'State',
                    // hintText: 'State',
                     labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  //keyboardType: TextInputType.text,
                  validator: FormBuilderValidators.required(),
                  // onSaved: (value) => (_formData.country = value ?? ''),
                ),
              ),
              buildSizedboxW(kDefaultPadding),
            ],
          ),
          buildSizedBoxH(kDefaultPadding * 3),
          Row(
            children: [
              Flexible(
                child: FormBuilderDropdown(
                  items: [
                    DropdownMenuItem(
                      child: Text('India'),
                      value: 'India',
                    ),
                    DropdownMenuItem(
                      child: Text('Usa'),
                      value: 'Usa',
                    ),
                    DropdownMenuItem(
                      child: Text('Uk'),
                      value: 'Uk',
                    )
                  ],
                  // controller: widget.countryController,
                  name: 'Country',
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    // hintText: 'Country',
                     labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  // keyboardType: TextInputType.text,
                  validator: FormBuilderValidators.required(),
                  // onSaved: (value) => (_formData.country = value ?? ''),
                ),
              ),
            ],
          ),
          buildSizedBoxH(kDefaultPadding * 3),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'VAT/GST Applicable',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              buildSizedboxW(kDefaultPadding),
              Expanded(
                flex: 1,
                child: Obx(
                  () => FormBuilderCheckbox(
                    name: 'VAT',
                    initialValue: screenController.isVATSelected.value,
                    title: const Text('VAT'),
                    onChanged: screenController.toggleVAT,
                  ),
                ),
              ),
              buildSizedboxW(kDefaultPadding),
              Expanded(
                flex: 1,
                child: FormBuilderCheckbox(
                  name: 'GST',
                  initialValue: screenController.isGSTSelected.value,
                  title: const Text('GST'),
                  onChanged: screenController.toggleGST,
                ),
              ),
            ],
          ),
          if (isVATSelected)
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    controller: screenController.vatnumberController,
                    name: 'VAT Number',
                    decoration: const InputDecoration(
                      labelText: 'VAT Number',
                      hintText: 'VAT Number',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    enableSuggestions: false,
                    keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),
                  ),
                ),
                buildSizedboxW(kDefaultPadding),
                Flexible(
                  child: FormBuilderTextField(
                    controller: screenController.vatrateController,
                    name: 'VAT Rate',
                    decoration: const InputDecoration(
                      labelText: 'VAT Rate',
                      hintText: 'VAT Rate',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),
                  ),
                ),
              ],
            ),
          buildSizedBoxH(kDefaultPadding * 2),
          if (isGSTSelected)
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    controller: screenController.gstnumberController,
                    name: 'GST Number',
                    decoration: const InputDecoration(
                      labelText: 'GST Number',
                      hintText: 'GST Number',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    enableSuggestions: false,
                    keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),
                  ),
                ),
                buildSizedboxW(kDefaultPadding),
                Flexible(
                  child: FormBuilderTextField(
                    controller: screenController.gstcompoundingController,
                    name: 'GST Compounding',
                    decoration: const InputDecoration(
                      labelText: 'GST Compounding',
                      hintText: 'GST Compounding',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),
                  ),
                ),
              ],
            ),
          buildSizedboxW(kDefaultPadding * 3),
        ],
      ),
    );
  }
}
