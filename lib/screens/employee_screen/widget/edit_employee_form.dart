import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/designation_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/employee_category_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class EditEmployeeForm extends StatelessWidget {
  EditEmployeeForm({super.key});
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
                     controller:screenController.lastNameController,
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
                  child: FormBuilderDropdown<String>(
                    // controller: widget.companyNameController,
                    name: 'Company Name',
                    decoration: const InputDecoration(
                      labelText: 'Company Name',
                      hintText: 'Company Name',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // enableSuggestions: false,
                    // keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),

                    items: screenController.companydetails
                        .map((company) => DropdownMenuItem(
                              value: company.id,
                              child: Text(company.companyName),
                            ))
                        .toList(),
                    onChanged: (value) {
                      screenController.setSelectedCompany(value!);
                    },
                    // onSaved: (value) => (_formData.firstname = value ?? ''),
                  ),
                ),
                buildSizedboxW(kDefaultPadding),
              ],
            ),
            buildSizedBoxH(kDefaultPadding * 3),
            Row(
              children: [
                Flexible(
                  child: FormBuilderTextField(
                    // controller: screenController.usernameController,
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
                    // controller: screenController.passwordController,
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
                    //  controller: screenController.employeeIdController ,
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
                    //controller: screenController.biometricIdController,
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
                    // controller: screenController.reportingIdController,
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
                  child: FormBuilderDropdown(
                    // controller: widget.groupNameController,
                    name: 'Employee Category',
                    decoration: const InputDecoration(
                      labelText: 'Employee Category',
                      hintText: 'Employee Category',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
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
                    //  onSaved: (value) => (_formData.lastname = value ?? ''),
                  ),
                ),
              ],
            ),
            buildSizedBoxH(kDefaultPadding * 3),
            Row(
              children: [
                Flexible(
                  child: FormBuilderDropdown(
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
                buildSizedboxW(kDefaultPadding),
                Flexible(
                  child: FormBuilderDropdown(
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
                  child: FormBuilderTextField(
                      controller: screenController.dobController,
                    name: 'Date Of Birth',
                    decoration: const InputDecoration(
                      labelText: 'Date Of Birth',
                      hintText: 'Date Of Birth',
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
                     controller:screenController.phoneNumberController,
                    name: 'Phone Number',
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Phone number',
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
                    // controller: screenController.joiningDateController,
                    name: 'Joining Date',
                    decoration: const InputDecoration(
                      labelText: 'Joining Date',
                      hintText: 'Joining Date',
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
          ],
        ));
  }
}
