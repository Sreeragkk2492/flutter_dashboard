import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/company_payroll_allowance_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/company_models.dart';

class AddCompanyAllowanceDetails extends StatelessWidget {
  AddCompanyAllowanceDetails({super.key});

  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(CompanyPayrollAllowanceController());

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return PortalMasterLayout(
        body: ListView(
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
                            Text('Add Company Allowance',
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
                        Flexible(flex: 4, child: addCompanyallowance()),
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
                        addCompanyallowance(),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    ));
  }

  Widget addCompanyallowance() {
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
              Text('Add Company Allowance',
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
                            () => FormBuilderDropdown(
                              // controller: widget.companyNameController,
                              name: 'Company Name',
                              decoration: const InputDecoration(
                                labelText: 'Company Name',
                                hintText: 'Company Name',
                                border: OutlineInputBorder(),
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
                                screenController.onCompanySelected(
                                    value!.id, value.companyCode);
                              },
                              // onSaved: (value) => (_formData.firstname = value ?? ''),
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 3),
                    Obx(() {
                      // Check if a company is selected
                      if (screenController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else if (!screenController.isCompanySelected.value) {
                        return Center(
                            child: Text(
                                "Please select a company to view allowances."));
                      } else if (screenController.companyAllowances.isEmpty) {
                        return Center(
                            child: Text(
                                "No allowances available for the selected company."));
                      } else {
                        // Display the list of allowances as checkboxes
                        return GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 10,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: screenController.companyAllowances
                              .map((allowance) => CheckboxListTile(
                                    title: Text(allowance.allowance),
                                    value: allowance.isSelected,
                                    onChanged: (bool? value) {
                                      screenController.toggleAllowance(
                                          allowance.allowanceId);
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
                            buttonname: 'Add Company Allowance',
                            onClick: () async {
                              await screenController
                                  .addCompanyPayrollAllowance();
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
        ),
      ),
    );
  }
}
