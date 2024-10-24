import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/employee_category_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEmployementCategory extends StatelessWidget {
  AddEmployementCategory({super.key});
  final screenController = Get.find<EmployeeCategoryController>();
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Column(
          children: [
             Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: UIComponenetsAppBarNoButton(
                title: 'Add Employee Category',       
                subtitle: '',
                icon: Icon(Icons.rocket),
              ),
            ),
            // Stack(
            //   alignment: Alignment.bottomCenter,
            //   children: [
            //     Container(
            //       height: 150,
            //       color: AppColors.defaultColor.withOpacity(0.6),
            //     ),
            //     Align(
            //       // heightFactor: 0.01,
            //       child: Container(
            //         height: 100,
            //         alignment: Alignment.centerLeft,
            //         padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            //         margin: EdgeInsets.all(kDefaultPadding),
            //         decoration: BoxDecoration(
            //             color: AppColors.bgGreyColor,
            //             borderRadius: BorderRadius.circular(12)),
            //         child: Row(
            //           children: [
            //             Container(
            //               height: 70,
            //               width: 70,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   image: DecorationImage(
            //                       image: AssetImage('assets/profile3.jpg'),
            //                       fit: BoxFit.cover)),
            //             ),
            //             buildSizedboxW(kDefaultPadding),
            //             const Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Add Employee Category',
            //                     style: TextStyle(
            //                         fontSize: 16.0,
            //                         fontWeight: FontWeight.bold)),
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // buildSizedBoxH(kDefaultPadding * 3),
            screenSize.width >= kScreenWidthLg
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding + kTextPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(flex: 4, child: addindustry()),
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
                        addindustry(),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    )));
  }

  Widget addindustry() {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          // Text('Add any Employee Category',
          //     style: GoogleFonts.montserrat(
          //         fontSize: kDefaultPadding + kTextPadding,
          //         fontWeight: FontWeight.bold)),
          // // buildSizedBoxH(kDefaultPadding),
          // // Text(
          // //   'USER INFORMATION',
          // //   style: themeData.textTheme.labelLarge,
          // // ),
          // buildSizedBoxH(kDefaultPadding * 2),
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
                        cursorColor: AppColors.defaultColor,
                        name: 'Category Name',
                        controller: screenController.categoryNameController,
                        decoration: InputDecoration(
                          labelText: 'Category Name',
                          // hintText: 'test.user',
                          // helperText: '* To test registration fail: admin',
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
                        cursorColor: AppColors.defaultColor,
                        name: 'Remarks',
                        decoration: const InputDecoration(
                          labelText: 'Remarks',
                          hintText: 'please add your remarks',
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
                        buttonname: 'Add Employee Category',
                        onClick: () async {
                          await screenController.addEmpCategory();
                        //  Get.back();
                        }),
                  ],
                ),
                //  buildSizedBoxH(kDefaultPadding * 3),
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
    );
  }
}
