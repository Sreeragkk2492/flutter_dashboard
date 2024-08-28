import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/models/company_models.dart';
import 'package:flutter_dashboard/models/user_model.dart';
import 'package:flutter_dashboard/models/usertype_model.dart';

import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_menu_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class EmployeeMenu extends StatelessWidget {
  EmployeeMenu({super.key});
  final _dataTableHorizontalScrollController = ScrollController();
  //final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(EmployeeMenuController());
  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: 'Employee Menu Details',
            subtitle: '',
            icon: Icon(Icons.rocket),
            buttonTitle: 'Add Employee Menu',
            onClick: () {
              Get.toNamed(Routes.AddEmployeeMenu);
            },
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
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
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // enableSuggestions: false,
                    // keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),
                    items: screenController.companydetails
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
                  () => FormBuilderDropdown<UserModel>(
                    // controller: widget.companyNameController,
                    name: 'User Name',
                    decoration: const InputDecoration(
                      labelText: 'User Name',
                      hintText: 'User Name',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // enableSuggestions: false,
                    // keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.required(),
                    items: screenController.filteredUsers
                        .map((user) => DropdownMenuItem(
                              value: user,
                              child: Text(user.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      screenController.onUserSelected(
                          value!.userTypeId, value.companyId, value.id);
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
              !screenController.isUserSelected.value) {
            return Center(
                child: Text(
                    "Please select both a company and a user to view menus."));
          } else if (screenController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Filter only selected allowances
            // final selectedAllowances = screenController.companyAllowances
            //     .where((allowance) => allowance.isSelected)
            //     .toList();

            if (screenController.filteredMenus.isEmpty) {
              return Center(child: Text("No menus available for this user."));
            } else {
              return Padding(
                  padding: EdgeInsets.only(
                      bottom: kDefaultPadding / 2,
                      top: kDefaultPadding,
                      left: kDefaultPadding / 2,
                      right: kDefaultPadding / 2),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: AppColors.bgGreyColor,
                          spreadRadius: 5,
                          blurRadius: 7)
                    ]),
                    child: Card(
                      color: AppColors.whiteColor,
                      clipBehavior: Clip.antiAlias,
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
                                            border: const TableBorder(
                                                verticalInside:
                                                    BorderSide(width: 0.5),
                                                top: BorderSide(width: 0.5),
                                                right: BorderSide(width: 0.5),
                                                left: BorderSide(width: 0.5),
                                                bottom: BorderSide(width: 0.5)),
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
                                              // DataColumn(
                                              //     label: Row(
                                              //   children: [
                                              //     Text('Status'),
                                              //     //  IconButton(
                                              //     //      onPressed: () {},
                                              //     //      icon: Icon(Icons.arrow_drop_down_sharp))
                                              //   ],
                                              // )),
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
                                            rows: screenController.filteredMenus
                                                .map((menu) {
                                              return DataRow(cells: [
                                                DataCell(
                                                    Text(menu.mainMenuName)),
                                                DataCell(Text(menu.subMenus
                                                    .map((subMenu) =>
                                                        subMenu.subMenuName)
                                                    .join(', '))),
                                                // DataCell(Text(menu.)),
                                              ]);
                                            }).toList(),
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            }
          }
        })
      ],
    )));
  }
}
