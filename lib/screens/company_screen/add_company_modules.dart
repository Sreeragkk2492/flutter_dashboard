import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_controller.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_module_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/company_dropdown_item.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCompanyModules extends StatelessWidget {
  AddCompanyModules({super.key});
  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(CompanyModuleController());

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
            title: 'Add Company Modules',  
           // subtitle: '',
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
            //                 Text('Add Company Modules',
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
                        Flexible(flex: 4, child: addCompanyModules()),
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
                        addCompanyModules(),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    )));
  }

  Widget addCompanyModules() {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          // Text('Add Company Modules',
          //     style: GoogleFonts.montserrat(
          //         fontSize: kDefaultPadding + kTextPadding,
          //         fontWeight: FontWeight.bold)),
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
                      child: Obx(
                        () => FormBuilderDropdown<Company>(
                          // controller: widget.companyNameController,
                          name: 'Company Name',
                          decoration: const InputDecoration(
                            labelText: 'Company Name',
                            hintText: 'Company Name',
                              labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                          ),
                          // enableSuggestions: false,
                          // keyboardType: TextInputType.name,
                          validator: FormBuilderValidators.required(),
                          items: employeeController.companydetails
                              .map((company) => DropdownMenuItem(
                                    value: Company(
                                        id: company.id,
                                        companyName: company.companyName,
                                        companyCode: company.companyCode,
                                        databaseName: company.databaseName,
                                        companyTypeId:
                                            company.companyTypeId,
                                        remarks: company.remarks,
                                        status: company.status,
                                        isActive: company.isActive,
                                        companytype: company.companytype),
                                    child: Text(company.companyName),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            screenController.onCompanySelected(value!.id);
                          },
                          // onSaved: (value) => (_formData.firstname = value ?? ''),
                        ),
                      ),
                    ),
                  ],
                ),
                buildSizedBoxH(kDefaultPadding * 3),
                Obx(() {
                  if (screenController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!screenController.isCompanySelected.value) {
                    return Center(
                        child: Text(
                            "Please select a company to view allowances."));
                  } else if (screenController.companyModules.isEmpty) {
                    return Center(
                        child: Text(
                            "No allowances available for the selected company."));
                  } else {
                    return GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: screenController.companyModules
                          .map((modules) => CheckboxListTile(
                            activeColor: AppColors.defaultColor,
                                title: Text(modules.moduleName),
                                value: modules.isSelected,
                                onChanged: (bool? value) {
                                  screenController
                                      .toggleAllowance(modules.moduleId);
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ))
                          .toList(),
                    );
                  }
                }),
                buildSizedBoxH(kDefaultPadding * 3),
                // Row(
                //   children: [
                //     Flexible(
                //       child:
                //     ),
                //     buildSizedboxW(kDefaultPadding),
                //   ],
                // ),
                buildSizedBoxH(kDefaultPadding * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultAddButton(
                        buttonname: 'Add Company Module',
                        onClick: () async {
                          await screenController.addCompanyModule();
                          Get.back();
                        }),
                  ],
                ),
                buildSizedBoxH(kDefaultPadding * 5),
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
    );
  }
}
