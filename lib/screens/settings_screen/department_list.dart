import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/models/settings/department_model.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/settings_screen/add_department.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/department_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/industry_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DepartmentList extends StatelessWidget {
  DepartmentList({super.key});

  final _dataTableHorizontalScrollController = ScrollController();
  final screenController = Get.put(SettingsController());
  final industryController = Get.put(IndustryController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: 'Department List',
            subtitle: '',
            icon: Icon(Icons.rocket),
            buttonTitle: 'Add Department',
            onClick: () {
              Get.toNamed(Routes.AddDepartment);
            },
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        Padding(
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
                    // CardHeader(
                    //   title: 'Company Details',
                    //   showDivider: false,
                    // ),
                    SizedBox(
                      width: double.infinity,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double dataTableWidth =
                              max(kScreenWidthMd, constraints.maxWidth);

                          return Scrollbar(
                            controller: _dataTableHorizontalScrollController,
                            thumbVisibility: true,
                            trackVisibility: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: _dataTableHorizontalScrollController,
                              child: SizedBox(
                                width: dataTableWidth,
                                child: Obx(
                                  () => DataTable(
                                    headingTextStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    headingRowHeight: 50,
                                    headingRowColor: WidgetStateProperty.all(
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
                                      DataColumn(
                                          // numeric: true,
                                          label: Row(
                                        children: [
                                          Text('No'),

                                          //  IconButton(
                                          //      onPressed: () {},
                                          //      icon: Icon(Icons.arrow_drop_down ))
                                        ],
                                      )),
                                      DataColumn(
                                          onSort: (columnIndex, _) {
                                            if (industryController
                                                .isSortasc.value) {
                                              industryController.industries
                                                  .sort((a, b) =>
                                                      a.name.compareTo(b.name));
                                            } else {
                                              industryController.industries
                                                  .sort((a, b) =>
                                                      b.name.compareTo(a.name));
                                            }
                                            industryController.isSortasc.value =
                                                !industryController
                                                    .isSortasc.value;
                                          },
                                          // numeric: true,
                                          label: Row(
                                            children: [
                                              Text('Industry'),

                                              //  IconButton(
                                              //      onPressed: () {},
                                              //      icon: Icon(Icons.arrow_drop_down ))
                                            ],
                                          )),
                                      DataColumn(
                                          onSort: (columnIndex, _) {
                                            if (screenController
                                                .isSortasc.value) {
                                              screenController.departments.sort(
                                                  (a, b) => a.departmentName
                                                      .compareTo(
                                                          b.departmentName));
                                            } else {
                                              screenController.departments.sort(
                                                  (a, b) => b.departmentName
                                                      .compareTo(
                                                          a.departmentName));
                                            }
                                            screenController.isSortasc.value =
                                                !screenController
                                                    .isSortasc.value;
                                          },
                                          label: Row(
                                            children: [
                                              Text('Dept Name'),
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
                                      DataColumn(
                                          label: Row(
                                        children: [
                                          //  Text('Status'),
                                          //  IconButton(
                                          //      onPressed: () {},
                                          //      icon: Icon(Icons.arrow_drop_down_sharp))
                                        ],
                                      )),
                                    ],
                                    rows: List.generate(
                                        screenController.departments.length,
                                        (index) {
                                      var department =
                                          screenController.departments[index];
                                      print(
                                          "Processing department: $department"); // Debug print
                                      return DataRow.byIndex(
                                        index: index,
                                        cells: [
                                          DataCell(Text('${index + 1}')),
                                          DataCell(Text(
                                              department.categoryIndustry)),
                                          DataCell(
                                              Text(department.departmentName)),
                                          DataCell(Text(department.isActive.toString())),
                                          DataCell(TextButton(
                                              onPressed: () {
                                                showEditDialog(
                                                    context,
                                                    DialogType.info,
                                                    index,
                                                    department);
                                              },
                                              child: const Text(
                                                'Edit',
                                                style: TextStyle(
                                                    color: AppColors.blackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )))
                                          // DataCell(Text(
                                          //     '${Random().nextInt(100)}')),
                                          // DataCell(Text(
                                          //     '${Random().nextInt(10000)}')),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    )));
  }

  showEditDialog(BuildContext context, DialogType dialogType, int index,
      DepartmentModel department) {
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController nameController =
        TextEditingController(text: department.departmentName);
    TextEditingController remarksController =
        TextEditingController(text: department.remarks);
    final dialogWidth = screenWidth * 0.8;
    final dialog = AwesomeDialog(
        alignment: Alignment.center,
        context: context,
        transitionAnimationDuration: const Duration(microseconds: 300),
        dialogType: dialogType,
        title: 'Update Department',
        desc: '',
        body: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.all(kDefaultPadding),
                // decoration: BoxDecoration(boxShadow: [
                //   BoxShadow(color: AppColors.bgGreyColor, spreadRadius: 5, blurRadius: 7)
                // ]),
                child: Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Update Department',
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
                                    () => FormBuilderDropdown(
                                      // controller: widget.statusController,
                                      name: 'Category/Industry',
                                      decoration: const InputDecoration(
                                        labelText: 'Category/Industry',
                                        hintText: 'Category/Industry',
                                        border: OutlineInputBorder(),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                      // enableSuggestions: false,
                                      // keyboardType: TextInputType.name,
                                      validator:
                                          FormBuilderValidators.required(),
                                      items: industryController.industries
                                          .map((industry) => DropdownMenuItem(
                                                value: industry.id,
                                                child: Text(industry.name),
                                              ))
                                          .toList(),
                                      initialValue:
                                          screenController.selectedCategory,
                                      onChanged: (value) => screenController
                                          .selectedCategory = value,
                                      // onSaved: (value) => (_formData.firstname = value ?? ''),
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
                                    controller: nameController,
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
                                    initialValue:
                                        screenController.selectedStatus,
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
                                    controller: remarksController,
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
              buildSizedBoxH(kDefaultPadding),
            ]),
          ),
        ),
        //  width: dialogWidth,
        btnOkOnPress: () {},
        btnOk: Container(
          alignment: Alignment.bottomRight,
          width: 150,
          //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                // fixedSize: const Size.fromHeight(3),
                padding: EdgeInsets.zero,
                backgroundColor: AppColors
                    .defaultColor // Change this color to your desired color
                ),

            onPressed: () {
              department.departmentName = nameController.text;
              department.remarks = remarksController.text;
              department.status = screenController.selectedStatus.toString();
              // industry.status=screenController.selectedStatus.toString();
              screenController.updateDepartment(department);
              Get.off(() => DepartmentList());
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Update',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            // onPressed: widget.onClick
          ),
        ));

    dialog.show();
  }
}
