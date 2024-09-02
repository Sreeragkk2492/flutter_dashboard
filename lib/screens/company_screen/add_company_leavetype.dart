import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_leavetype_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCompanyLeavetype extends StatelessWidget {
   AddCompanyLeavetype({super.key});

  final _formKey = GlobalKey<FormState>();

  final screenController=Get.put(CompanyLeavetypeController());
   final employeeController = Get.put(EmployeeController());

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
                            Text('Add Company Leave Type',
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
                        Flexible(flex: 4, child: addCompanyLeaveType()),
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
                        addCompanyLeaveType(),
                        buildSizedBoxH(kDefaultPadding),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    )));
  }

   Widget addCompanyLeaveType() {
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
              Text('Add Company Leave Type',
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
                          child: Obx(
                            () =>FormBuilderDropdown<Company>(
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
                screenController.onCompanySelected(value!.id);
              },
            ),
                          ),
                        ),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 3),
                   
                       Obx(()=>
                          Column(
                          children: [
                              ...screenController.leaveTypeControllers.asMap().entries.map((entry) {
                            int index = entry.key;
                           
                            return Padding(
                              padding: EdgeInsets.only(bottom: kDefaultPadding),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: 
                                     FormBuilderTextField(
                                        name: 'Leave Type',
                                       controller: entry.value,
                                        decoration: InputDecoration(
                                          labelText: 'Leave Type',
                                          border: OutlineInputBorder(),
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                        ),
                                        validator: FormBuilderValidators.required(),
                                      ),
                                    
                                  ),
                                 buildSizedboxW(kDefaultPadding * 4),
                                  Flexible(
                                    flex: 1,
                                    child:index == screenController.leaveTypeControllers.length - 1?
                                    ElevatedButton(
                                      onPressed: () {
                                         screenController.addLeaveType();
                                      },
                                       
                                      child: Text('Add New'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.defaultColor,
                                        foregroundColor: AppColors.whiteColor,
                                      ),
                                    ):SizedBox(),
                                  )
                                 
                                ],
                              ),
                            );
                          }).toList(),
                            buildSizedboxW(kDefaultPadding),
                            
                          ],
                                               ),
                       ),
                    
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
                            buttonname: 'Add Company Leave Type',
                            onClick: () async {
                              await screenController.addCompanyLeaveTypes();
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
