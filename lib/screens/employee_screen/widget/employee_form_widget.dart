import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    controller: screenController.firstNameController,
                    name: 'First Name',
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'First Name',
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
                    controller: screenController.lastNameController,
                    name: 'Last Name',
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Last Name',
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
                          screenController.setSelectedCompany(
                              value!.id, value.companyCode);
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
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        readOnly: true,
                        onSaved: (newValue) {
                          // This ensures the company ID and code are saved even for pre-filled company
                          screenController.setSelectedCompany(
                              company.id, company.companyCode);
                        },
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
                    controller: screenController.usernameController,
                    name: 'Username',
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Username',
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
                    controller: screenController.passwordController,
                    name: 'Password',
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
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
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    controller: screenController.employeeIdController,
                    name: 'Employee ID',
                    decoration: const InputDecoration(
                      labelText: 'Employee ID',
                      hintText: 'Employee ID',
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
                    controller: screenController.biometricIdController,
                    name: 'Biometric ID',
                    decoration: const InputDecoration(
                      labelText: 'Biometric ID',
                      hintText: 'Biometric ID',
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
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    controller: screenController.reportingIdController,
                    name: 'Reporting To',
                    decoration: const InputDecoration(
                      labelText: 'Reporting To',
                      hintText: 'Reporting To',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    enableSuggestions: false,
                    keyboardType: TextInputType.name,
                    // validator: FormBuilderValidators.required(),
                    // onSaved: (value) => (_formData.firstname = value ?? ''),
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
                        border: OutlineInputBorder(),
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
                        border: OutlineInputBorder(),
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
                        border: OutlineInputBorder(),
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
            Text(
              'Detailed Information',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            buildSizedBoxH(kDefaultPadding * 2),
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    controller: screenController.fatherNameController,
                    name: 'Father Name',
                    decoration: const InputDecoration(
                      labelText: 'Father Name',
                      hintText: 'Father Name',
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
                    controller: screenController.motherNameController,
                    name: 'Mother Name',
                    decoration: const InputDecoration(
                      labelText: 'Mother Name',
                      hintText: 'Mother Name',
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
            buildSizedBoxH(kDefaultPadding * 2),
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    controller: screenController.addressController,
                    name: 'Address',
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      hintText: 'Address',
                      border: OutlineInputBorder(),
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
                  child: FormBuilderDateTimePicker(
                    inputType: InputType.date,
                    format: DateFormat('yyyy-MM-dd'),
                    controller: screenController.dobController,
                    name: 'Date Of Birth',
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: 'Date Of Birth',
                      hintText: 'Date Of Birth',
                      border: OutlineInputBorder(),
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
                buildSizedboxW(kDefaultPadding),
                Flexible(
                  child: FormBuilderTextField(
                    controller: screenController.phoneNumberController,
                    name: 'Phone Number',
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Phone number',
                      border: OutlineInputBorder(),
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
                  child: FormBuilderDateTimePicker(
                    inputType: InputType.date,
                    format: DateFormat('yyyy-MM-dd'),
                    controller: screenController.joiningDateController,
                    name: 'Joining Date',
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: 'Joining Date',
                      hintText: 'Joining Date',
                      border: OutlineInputBorder(),
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
                buildSizedboxW(kDefaultPadding),
                Flexible(
                  child: FormBuilderTextField(
                    // controller: widget.stateController,
                    name: 'Is Active',
                    decoration: const InputDecoration(
                      labelText: 'Is Active',
                      hintText: 'Is Active',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    keyboardType: TextInputType.text,
                    validator: FormBuilderValidators.required(),
                    // onSaved: (value) => (_formData.country = value ?? ''),
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
                        Get.back();
                      }
                    }),
              ],
            ),
          ],
        ));
  }
}
