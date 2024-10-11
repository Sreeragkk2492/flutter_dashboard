import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/department_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/industry_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class AddDepartment extends StatelessWidget {
  AddDepartment({super.key});

  final screenController = Get.find<SettingsController>();
   final industryController = Get.put(IndustryController());
   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
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
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add Department',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        //  // buildSizedboxW(kScreenWidthXl),
                        //     Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     crossAxisAlignment: CrossAxisAlignment.end,
                        //     children: [
                        //      DefaultAddButton(buttonname: 'Add', onClick: (){})

                        //     ],
                        //   ),
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
                        Flexible(
                          flex: 4,
                          child: adddepartment(),
                        ),
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
                        adddepartment(),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    )));
  }

  Widget adddepartment() {
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
              Text('Add any Department',
                  style: GoogleFonts.montserrat(
                      fontSize: kDefaultPadding + kTextPadding,
                      fontWeight: FontWeight.bold)),
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
                          child: Obx(()=>
                     FormBuilderDropdown(
                      // controller: widget.statusController,
                      name: 'Category/Industry',
                      decoration: const InputDecoration(
                        labelText: 'Category/Industry',
                        hintText: 'Category/Industry',
                        border: OutlineInputBorder(),
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
                      initialValue: screenController.selectedCategory,
                            onChanged: (value) =>
                                screenController.selectedCategory = value,
                    ),
                  ),
                        ),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 3),
                    Row(
                      children: [
                        Flexible(
                          child: FormBuilderTextField(
                            name: 'Department Name',
                            controller:
                                screenController.departmentNameController,
                            decoration: InputDecoration(
                              labelText: 'Department Name',
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
                        buildSizedboxW(kDefaultPadding),
                        Flexible(
                          child: FormBuilderDropdown(
                            name: 'Status',
                            decoration: InputDecoration(
                              labelText: 'Status',
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
                             initialValue: screenController.selectedStatus,
                            onChanged: (value) =>
                                screenController.selectedStatus = value,
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
                            name: 'Remarks',
                            controller: screenController.remarksController,
                            decoration: const InputDecoration(
                              labelText: 'Remarks',
                              hintText: 'please add your remarks',
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                            buttonname: 'Add Department',
                            onClick: () async {
                              await screenController.addDepartment();
                             // Get.back();
                            }),
                      ],
                    ),
                    // buildSizedBoxH(kDefaultPadding * 3),
                    // Divider(
                    //   indent: kDefaultPadding * 2,
                    //   endIndent: kDefaultPadding * 2,
                    // ),
                    // buildSizedBoxH(kDefaultPadding * 3),
                    buildSizedBoxH(kDefaultPadding * 3),
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
