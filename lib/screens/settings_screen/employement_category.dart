import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/models/settings/employee_category_model.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/employee_category_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployementCategoryList extends StatelessWidget {
  EmployementCategoryList({super.key});
  final _dataTableHorizontalScrollController = ScrollController();
  final screenController = Get.put(EmployeeCategoryController());
  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: 'Employement Category List',
            subtitle: '',
            icon: Icon(Icons.rocket),
            buttonTitle: 'Add Employment Category',
            onClick: () {
              Get.toNamed(Routes.AddEmployementCategory);
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
                                controller:
                                    _dataTableHorizontalScrollController,
                                child: SizedBox(
                                  width: dataTableWidth,
                                  child: Obx(
                                    () => DataTable(
                                      border: TableBorder(
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
                                        DataColumn(
                                            // numeric: true,
                                            label: Row(
                                          children: [
                                            Text('#'),

                                            //  IconButton(
                                            //      onPressed: () {},
                                            //      icon: Icon(Icons.arrow_drop_down ))
                                          ],
                                        )),
                                        DataColumn(
                                            label: Row(
                                          children: [
                                            Text('Category Name'),
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
                                            // Text('Status'),
                                            //  IconButton(
                                            //      onPressed: () {},
                                            //      icon: Icon(Icons.arrow_drop_down_sharp))
                                          ],
                                        )),
                                      ],
                                      rows: List.generate(
                                          screenController.empcategories.length,
                                          (index) {
                                        var empcategories = screenController
                                            .empcategories[index];
                                        return DataRow.byIndex(
                                          index: index,
                                          cells: [
                                            DataCell(Text('${index + 1}')),
                                            DataCell(Text(empcategories.name)),
                                            DataCell(Text(
                                                empcategories.status??"" )),
                                            DataCell(TextButton(
                                                onPressed: () {
                                                  showEditDialog(
                                                      context,
                                                      DialogType.info,
                                                      index,
                                                      empcategories);
                                                },
                                                child: const Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )))
                                            // DataCell(Text(
                                            //     '${Random().nextInt(50)}')),
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
              ),
            )),
      ],
    )));
  }

  void showEditDialog(BuildContext context, DialogType dialogType, int index,
      EmployeeCategory empcategories) {
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController nameController =
        TextEditingController(text: empcategories.name);
    TextEditingController remarksController =
        TextEditingController(text: empcategories.remarks);
    final dialogWidth = screenWidth * 0.8;
    final dialog = AwesomeDialog(
        alignment: Alignment.center,
        context: context,
        transitionAnimationDuration: const Duration(microseconds: 300),
        dialogType: dialogType,
        title: 'Update Employee Category',
        desc: '',
        body: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.all(kDefaultPadding),
                // decoration: BoxDecoration(color: AppColors.bgGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Update Employee Category',
                        style: GoogleFonts.montserrat(
                            fontSize: kDefaultPadding + kTextPadding,
                            fontWeight: FontWeight.bold)),
                    // buildSizedBoxH(kDefaultPadding),
                    // Text(
                    //   'USER INFORMATION',
                    //   style: themeData.textTheme.labelLarge,
                    // ),
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
                                child: FormBuilderTextField(
                                  name: 'Category Name',
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Category Name',
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
                                  controller: remarksController,
                                  name: 'Remarks',
                                  decoration: const InputDecoration(
                                    labelText: 'Remarks',
                                    hintText: 'Test',
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
                        ],
                      ),
                    ),
                  ],
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
              empcategories.name = nameController.text;

              empcategories.remarks = remarksController.text;
              empcategories.status = screenController.selectedStatus.toString();
              screenController.updateEmpCategory(empcategories);
              Get.off(() => EmployementCategoryList());
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
