import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/employee_models/user_model.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/designation_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/employee_category_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditEmployeeForm extends StatelessWidget {
  final UserModel employeeToEdit;
  EditEmployeeForm({super.key, required this.employeeToEdit});
  
  final screenController = Get.put(EmployeeController());
  final employeeCategoryController = Get.put(EmployeeCategoryController());
  final designationController = Get.put(DesignationController());
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // Pre-fill form controllers with existing data
    screenController.firstNameController.text = employeeToEdit.employeeFirstName;
    screenController.lastNameController.text = employeeToEdit.employeeLastName;
    screenController.fatherNameController.text = employeeToEdit.fatherName ?? '';
    screenController.motherNameController.text = employeeToEdit.motherName ?? '';
    screenController.addressController.text = employeeToEdit.address ?? '';
    screenController.phoneNumberController.text = employeeToEdit.phoneNumber?.toString() ?? '';
    
    if (employeeToEdit.dob != null) {
      screenController.dobController.text = DateFormat('yyyy-MM-dd').format(employeeToEdit.dob!);
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
                  controller: screenController.firstNameController,
                  name: 'First Name',
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    hintText: 'First Name',
                    border: const OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  validator: FormBuilderValidators.required(),
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
                  validator: FormBuilderValidators.required(),
                ),
              ),
            ],
          ),
          buildSizedBoxH(kDefaultPadding * 3),
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
                  validator: FormBuilderValidators.required(),
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
                  validator: FormBuilderValidators.required(),
                ),
              ),
            ],
          ),
          buildSizedBoxH(kDefaultPadding * 2),
          FormBuilderTextField(
            controller: screenController.addressController,
            name: 'Address',
            decoration: const InputDecoration(
              labelText: 'Address',
              hintText: 'Address',
              border: OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: FormBuilderValidators.required(),
          ),
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
                ),
              ),
            ],
          ),
          buildSizedBoxH(kDefaultPadding * 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultAddButton(
                buttonname: 'Update',
                onClick: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    screenController.updateEmployee(employeeToEdit.id);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}