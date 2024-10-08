import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_workingshift_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/company_dropdown_item.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddWorkingShifts extends StatelessWidget {
  AddWorkingShifts({super.key});
  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(CompanyWorkingshiftController());
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 150,
                  color: AppColors.defaultColor.withOpacity(0.6),
                ),
                Align(
                  // heightFactor: 0.01,
                  child: Container(
                    height: 100,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    margin: EdgeInsets.all(kDefaultPadding),
                    decoration: BoxDecoration(
                        color: AppColors.bgGreyColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: AssetImage('assets/profile3.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        buildSizedboxW(kDefaultPadding),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Working Shifts',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            buildSizedBoxH(kDefaultPadding * 3),
            screenSize.width >= kScreenWidthLg
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding + kTextPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(flex: 4, child: addworkingshifts()),
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
                        addworkingshifts(),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    )));
  }

  Widget addworkingshifts() {
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
                Text('Add Working Shifts',
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
                            child: Obx(
                              () =>  FormBuilderDropdown<Company>(
              name: 'Company',
              decoration: const InputDecoration(
                labelText: 'Company',
                hintText: 'Select Company',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: FormBuilderValidators.required(),
              items: employeeController.companydetails
                  .map((company) => DropdownMenuItem(
                        value: Company(
                            id: company.id,
                            companyName: company.companyName,
                            companyCode: company.companyCode,
                            databaseName: company.databaseName,
                            companyTypeId: company.companyTypeId,
                            remarks: company.remarks,
                            status: company.status,
                            isActive: company.isActive,
                            companytype: company.companytype),
                        child: Text(company.companyName),
                      ))
                  .toList(),
              onChanged: (value) {
                screenController.onCompanySelected(
                    value!.id, value.companyCode);
              },
            ),
                            ),
                          ),
                          buildSizedboxW(kDefaultPadding),
                          Flexible(
                            child: FormBuilderTextField(
                              controller: screenController.shiftNameController,
                              name: 'Shift Name',
                              decoration: InputDecoration(
                                labelText: 'Shift Name',
                                // hintText: 'test.user',
                                // helperText: '* To test registration fail: admin',
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                            child: FormBuilderDateTimePicker(
                              controller: screenController.startTimeController,
                              inputType: InputType.time,
                              format: DateFormat("HH:mm"),
                              name: 'Shift Start Time',
                              // controller: screenController.designationController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.access_time),
                                labelText: 'Shift Start Time',
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
                          buildSizedboxW(kDefaultPadding),
                          Flexible(
                            child: FormBuilderDateTimePicker(
                              controller: screenController.endTimeController,
                              inputType: InputType.time,
                              format: DateFormat("HH:mm"),
                              name: 'Shift End Time',
                              // controller: screenController.statusController,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.access_time),
                                labelText: 'Shift End Time',
                                // hintText: 'test@gmail.com',
                                border: const OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: FormBuilderValidators.required(),
                              // onSaved: (value) => (_formData.email = value ?? ''),
                            ),
                          ),
                        ],
                      ),
                      buildSizedBoxH(kDefaultPadding * 3),
                      // Row(
                      //   children: [
                      //     Flexible(
                      //       child: FormBuilderTextField(
                      //         name: 'Remarks',
                      //         controller: screenController.remarksController,
                      //         decoration: const InputDecoration(
                      //           labelText: 'Remarks',
                      //           hintText: 'Test',
                      //           border: OutlineInputBorder(),
                      //           floatingLabelBehavior: FloatingLabelBehavior.always,
                      //         ),
                      //         enableSuggestions: false,
                      //         keyboardType: TextInputType.name,
                      //         validator: FormBuilderValidators.required(),
                      //         // onSaved: (value) => (_formData.firstname = value ?? ''),
                      //       ),
                      //     ),
                      //     buildSizedboxW(kDefaultPadding),
                      //   ],
                      // ),
                      buildSizedBoxH(kDefaultPadding * 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultAddButton(
                              buttonname: 'Add Working Shift',
                              onClick: () async{
                                await screenController.addWorkingShifts();
                               // Get.back();
                              }),
                        ],
                      ),
                      buildSizedBoxH(kDefaultPadding * 3),
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
          )),
    );
  }
}
