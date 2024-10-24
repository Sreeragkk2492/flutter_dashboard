import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/company_dropdown_item.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/designation_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/employee_category_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controller/employee_controller.dart';

class EmployeeFormWidget extends StatelessWidget {
  EmployeeFormWidget({super.key});
  final screenController = Get.put(EmployeeController());
  final employeeCategoryController = Get.put(EmployeeCategoryController());
  final designationController = Get.put(DesignationController());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // Call fetchRepotingId here for company admin
    if (!screenController.isSuperAdmin.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        screenController.fetchRepotingId('');
      });
    }
    return FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    cursorColor: AppColors.defaultColor,
                    controller: screenController.firstNameController,
                    name: 'First Name',
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      hintText: 'First Name',
                      // helperText: '* To test registration fail: admin',
                      border: const OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
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
                    cursorColor: AppColors.defaultColor,
                    controller: screenController.lastNameController,
                    name: 'Last Name',
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      hintText: 'Last Name',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                      border: const OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
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
                  child: Obx(() {
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
                          screenController.setSelectedCompany(
                              value!.id, value.companyCode);
                          screenController.onCompanySelected(value.id);
                        },
                      );
                    } else {
                      // Single company display for company admin
                      final company = screenController.companydetails[0];
                      screenController.setSelectedCompany(
                          company.id, company.companyCode);
                      return FormBuilderTextField(
                        name: 'Company Name',
                        initialValue: company.companyName,
                        decoration: InputDecoration(
                          labelText: 'Company Name',
                          labelStyle: TextStyle(color: AppColors.blackColor),
                          border: OutlineInputBorder(),
                           enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.defaultColor, width: 1.5)),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        readOnly: true,
                        // onSaved: (newValue) {
                        //   // This ensures the company ID and code are saved even for pre-filled company
                        //   screenController.setSelectedCompany(
                        //       company.id, company.companyCode);
                        // },
                      );
                    }
                  }),
                ),
                buildSizedboxW(kDefaultPadding),
              ],
            ),
            buildSizedBoxH(kDefaultPadding * 3),
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    cursorColor: AppColors.defaultColor,
                    controller: screenController.usernameController,
                    name: 'Username',
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Username',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
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
                    controller: screenController.passwordController,
                    name: 'Password',
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
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
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    cursorColor: AppColors.defaultColor,
                    controller: screenController.employeeIdController,
                    name: 'Employee ID',
                    decoration: const InputDecoration(
                      labelText: 'Employee ID',
                      hintText: 'Employee ID',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
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
                    controller: screenController.biometricIdController,
                    name: 'Biometric ID',
                    decoration: const InputDecoration(
                      labelText: 'Biometric ID',
                      hintText: 'Biometric ID',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
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
            Row(
              children: [
                Flexible(
                  child: Obx(
                    () => FormBuilderDropdown(
                      // controller: widget.statusController,
                      name: 'Reporting to ',
                      decoration: const InputDecoration(
                        labelText: 'Reporting to ',
                        hintText: 'Reporting to ',
                        labelStyle: TextStyle(color: AppColors.blackColor),
                        border: OutlineInputBorder(),
                         enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.defaultColor, width: 1.5)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      // enableSuggestions: false,
                      // keyboardType: TextInputType.name,
                      validator: FormBuilderValidators.required(),
                      items: screenController.reportingtoid
                          .map((reportingtoid) => DropdownMenuItem(
                                value: reportingtoid.id,
                                child: Text(reportingtoid.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        screenController.setSelectedReportingId(value!);
                      },
                      // onSaved: (value) => (_formData.firstname = value ?? ''),
                    ),
                  ),
                ),
                buildSizedboxW(kDefaultPadding),
                Flexible(
                  child: Obx(
                    () => FormBuilderDropdown(
                      // controller: widget.companyNameController,
                      name: 'Employee Category',
                      decoration: const InputDecoration(
                        labelText: 'Employee Category',
                        hintText: 'Employee Category',
                        labelStyle: TextStyle(color: AppColors.blackColor),
                        border: OutlineInputBorder(),
                         enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.defaultColor, width: 1.5)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      // enableSuggestions: false,
                      // keyboardType: TextInputType.name,
                      validator: FormBuilderValidators.required(),
                      items: employeeCategoryController.empcategories
                          .map((empcategory) => DropdownMenuItem(
                                value: empcategory.id,
                                child: Text(empcategory.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        screenController.setSelectedEmployeeCategory(value!);
                      },
                      // onSaved: (value) => (_formData.firstname = value ?? ''),
                    ),
                  ),
                ),
              ],
            ),
            buildSizedBoxH(kDefaultPadding * 3),
            Row(
              children: [
                Flexible(
                  child: Obx(
                    () => FormBuilderDropdown(
                      // controller: widget.statusController,
                      name: 'Designation',
                      decoration: const InputDecoration(
                        labelText: 'Designation',
                        hintText: 'Designation',
                        labelStyle: TextStyle(color: AppColors.blackColor),
                        border: OutlineInputBorder(),
                         enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.defaultColor, width: 1.5)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      // enableSuggestions: false,
                      // keyboardType: TextInputType.name,
                      validator: FormBuilderValidators.required(),
                      items: designationController.designations
                          .map((designations) => DropdownMenuItem(
                                value: designations.id,
                                child: Text(designations.designation),
                              ))
                          .toList(),
                      onChanged: (value) {
                        screenController.setSelectedDesignation(value!);
                      },
                      // onSaved: (value) => (_formData.firstname = value ?? ''),
                    ),
                  ),
                ),
                buildSizedboxW(kDefaultPadding),
                Flexible(
                  child: Obx(
                    () => FormBuilderDropdown(
                      // controller: widget.statusController,
                      name: 'Usertype',
                      decoration: const InputDecoration(
                        labelText: 'Usertype',
                        hintText: 'Usertype',
                        labelStyle: TextStyle(color: AppColors.blackColor),
                        border: OutlineInputBorder(),
                         enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.defaultColor, width: 1.5)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      // enableSuggestions: false,
                      // keyboardType: TextInputType.name,
                      validator: FormBuilderValidators.required(),
                      items: screenController.usertype
                          .map((usertype) => DropdownMenuItem(
                                value: usertype.id,
                                child: Text(usertype.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        screenController.setSelectedUserTypeId(value!);
                      },
                      // onSaved: (value) => (_formData.firstname = value ?? ''),
                    ),
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
            Text('Detail Information',
                style: GoogleFonts.montserrat(
                    fontSize: kDefaultPadding + kTextPadding,
                    fontWeight: FontWeight.bold)),
            buildSizedBoxH(kDefaultPadding * 2),
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    cursorColor: AppColors.defaultColor,
                    controller: screenController.fatherNameController,
                    name: 'Father Name',
                    decoration: const InputDecoration(
                      labelText: 'Father Name',
                      hintText: 'Father Name',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
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
                    controller: screenController.motherNameController,
                    name: 'Mother Name',
                    decoration: const InputDecoration(
                      labelText: 'Mother Name',
                      hintText: 'Mother Name',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
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
                    controller: screenController.addressController,
                    name: 'Address',
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      hintText: 'Address',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
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
              ],
            ),
            buildSizedboxW(kDefaultPadding),
            buildSizedBoxH(kDefaultPadding * 2),
            Row(
              children: [
                Flexible(
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
                      inputType: InputType.date,
                      format: DateFormat('yyyy-MM-dd'),
                      controller: screenController.dobController,
                      name: 'Date Of Birth',
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month),
                        labelText: 'Date Of Birth',
                        hintText: 'Date Of Birth',
                        labelStyle: TextStyle(color: AppColors.blackColor),
                       border: OutlineInputBorder(
                         
                       ), 
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      // enableSuggestions: false,
                      keyboardType: TextInputType.name,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        (value) {
                          if (value != null && value.isAfter(DateTime.now())) {
                            return 'Date of birth cannot be in the future';
                          }
                          return null;
                        },
                      ]),
                      lastDate: DateTime.now(),

                      // onSaved: (value) => (_formData.firstname = value ?? ''),
                    ),
                  ),
                ),
                buildSizedboxW(kDefaultPadding),
                Flexible(
                  child: FormBuilderTextField(
                      cursorColor: AppColors.defaultColor,
                    controller: screenController.phoneNumberController,
                    name: 'Phone Number',
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Phone number',
                     labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    keyboardType: TextInputType.phone,
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
            Row(
              children: [
                Flexible(
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
                    inputType: InputType.date,
                    format: DateFormat('yyyy-MM-dd'),
                    controller: screenController.joiningDateController,
                    name: 'Joining Date',
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: 'Joining Date',
                      hintText: 'Joining Date',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // enableSuggestions: false,
                    keyboardType: TextInputType.text,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      (value) {
                        if (value != null && value.isAfter(DateTime.now())) {
                          return 'Date of birth cannot be in the future';
                        }
                        return null;
                      },
                    ]),
                    lastDate: DateTime.now(),
                    // onSaved: (value) => (_formData.city = value ?? '')
                  ),
                ),
                ), 
                buildSizedboxW(kDefaultPadding),
                Flexible(
                  child: FormBuilderDropdown(
                    name: 'Status',
                    decoration: InputDecoration(
                      labelText: 'Status',
                      // hintText: 'test@gmail.com',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.greycolor)),
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
                    onChanged: (value) =>
                        screenController.selectedStatus = value,
                    // onSaved: (value) => (_formData.email = value ?? ''),
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
                    buttonname: 'Add Employee',
                    onClick: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        final formData = _formKey.currentState!.value;
                        screenController.addUser(formData);
                        // Get.back();
                      }
                    }),
              ],
            ),
          ],
        ));
  }
}
