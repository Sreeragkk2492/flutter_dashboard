import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/employee_models/usertype_model.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/controller/company_menu_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class CompanyMenuList extends StatelessWidget {
  CompanyMenuList({super.key});

  final employeecontroller = Get.put(EmployeeController());
  final _dataTableHorizontalScrollController = ScrollController();
  final screenController = Get.put(CompanyMenuController());

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: ' Company Menu List',
            subtitle: '',
            icon: const Icon(Icons.rocket),
            buttonTitle: 'Add Company Menu',
            onClick: () {
              Get.toNamed(Routes.AddCompanyMenu);
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Obx(
                  () => FormBuilderDropdown<Company>(
                    // controller: widget.companyNameController,
                    name: 'Company Name',
                    decoration: const InputDecoration(
                      labelText: 'Company Name',
                      hintText: 'Company Name',
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
                    // enableSuggestions: false,
                    // keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),
                    items: employeecontroller.companydetails
                        .map((company) => DropdownMenuItem(
                              value: company,
                              child: Text(company.companyName),
                            ))
                        .toList(),
                    onChanged: (value) {
                      screenController.onCompanySelected(
                        value!.id,
                      );
                    },
                    // onSaved: (value) => (_formData.firstname = value ?? ''),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Obx(
                  () => FormBuilderDropdown<UserType>(
                    // controller: widget.companyNameController,
                    name: 'User Type',
                    decoration: const InputDecoration(
                      labelText: 'User Type',
                      hintText: 'User Type',
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
                    // enableSuggestions: false,
                    // keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),
                    items: screenController.userTypes
                        .map((user) => DropdownMenuItem(
                              value: user,
                              child: Text(user.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      screenController.onUserTypeSelected(
                        value!.id,
                      );
                    },
                    // onSaved: (value) => (_formData.firstname = value ?? ''),
                  ),
                ),
              ),
            ),
          ],
        ),
        buildSizedBoxH(kDefaultPadding),
        Obx(() {
          if (!screenController.isCompanySelected.value ||
              !screenController.isUserTypeSelected.value) {
            return Center(
                child: Text(
                    "Please select both a company and a usertype to view menus."));
          } else if (screenController.isLoading.value) {
            return Center(
              child:  AnimatedCircularProgressIndicator(
              size: 60.0,
              strokeWidth: 5.0,
              valueColor: AppColors.defaultColor,
            ),
            );
          } else {
            // Filter only selected allowances
            // final selectedAllowances = screenController.companyAllowances
            //     .where((allowance) => allowance.isSelected)
            //     .toList();

            if (screenController.filteredMenus.isEmpty) {
              return Center(
                  child: Text("No menus available for this usertype."));
            } else {
              return Padding(
                  padding: EdgeInsets.only(
                      bottom: kDefaultPadding / 2,
                      top: kDefaultPadding,
                      left: kDefaultPadding / 2,
                      right: kDefaultPadding / 2),
                  child: Container(
                    // decoration: BoxDecoration(boxShadow: [
                    //   BoxShadow(
                    //       color: AppColors.bgGreyColor,
                    //       spreadRadius: 5,
                    //       blurRadius: 7)
                    // ]),
                    child: Padding(
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final double dataTableWidth =
                                    max(kScreenWidthMd, constraints.maxWidth);

                                return Scrollbar(
                                  controller:
                                      _dataTableHorizontalScrollController,
                                  thumbVisibility: true,
                                  trackVisibility: true,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller:
                                        _dataTableHorizontalScrollController,
                                    child: SizedBox(
                                        width: dataTableWidth,
                                        child: DataTable(
                                          headingTextStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                          headingRowHeight: 50,
                                          headingRowColor:
                                              WidgetStateProperty.all(
                                                  AppColors.bgGreyColor),
                                          // border: const TableBorder(
                                          //     verticalInside:
                                          //         BorderSide(width: 0.5),
                                          //     top: BorderSide(width: 0.5),
                                          //     right: BorderSide(width: 0.5),
                                          //     left: BorderSide(width: 0.5),
                                          //     bottom: BorderSide(width: 0.5)),
                                          dividerThickness: 2,
                                          sortColumnIndex: 0,
                                          sortAscending: true,
                                          showCheckboxColumn: false,
                                          showBottomBorder: true,
                                          columns: [
                                            // DataColumn(
                                            //     // numeric: true,
                                            //     label: Row(
                                            //   children: [
                                            //     Text('#'),

                                            //     //  IconButton(
                                            //     //      onPressed: () {},
                                            //     //      icon: Icon(Icons.arrow_drop_down ))
                                            //   ],
                                            // )),
                                             DataColumn(
                                                label: Text(
                                                    'Sl No') // Added S.No column
                                                ),
                                            DataColumn(
                                                // numeric: true,
                                                label: Row(
                                              children: [
                                                Text('Main menu'),

                                                //  IconButton(
                                                //      onPressed: () {},
                                                //      icon: Icon(Icons.arrow_drop_down ))
                                              ],
                                            )),
                                            DataColumn(
                                                label: Row(
                                              children: [
                                                Text('Sub Menu'),
                                                //  IconButton(
                                                //      onPressed: () {},
                                                //      icon: Icon(Icons.arrow_drop_down_sharp))
                                              ],
                                            )),
                                            DataColumn(
                                                label: Row(
                                              children: [
                                                Text('Status'),
                                                //  IconButton(
                                                //      onPressed: () {},
                                                //      icon: Icon(Icons.arrow_drop_down_sharp))
                                              ],
                                            )),
                                            // DataColumn(
                                            //     label: Row(
                                            //   children: [
                                            //     Text(''),
                                            //     //  IconButton(
                                            //     //      onPressed: () {},
                                            //     //      icon: Icon(Icons.arrow_drop_down_sharp))
                                            //   ],
                                            // )),
                                          ],
                                          // ... (keep the existing DataTable properties)
                                          rows: List.generate(screenController.filteredMenus.length,(index){
                                            final menu=screenController.filteredMenus[index];
                                             return DataRow(cells: [
                                               DataCell(Text('${index + 1}')),
                                              DataCell(Text(menu.mainMenuName)),
                                              DataCell(_buildSubMenuCell(menu
                                                  .subMenus
                                                  .map((subMenu) =>
                                                      subMenu.subMenuName)
                                                  .join(', '))),
                                              DataCell(Text(
                                                  menu.isSelected.toString())),
                                            ]);
                                          })
                                              
                                           
                                          
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            }
          }
        })
      ],
    ));
  }

  Widget _buildSubMenuCell(String subMenus) {
    // Truncate the address to show only the first half
    String truncatedSubmenu =
        subMenus.length > 20 ? '${subMenus.substring(0, 20)}...' : subMenus;
    return Tooltip(
      message: subMenus,
      child: Text(
        truncatedSubmenu,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
