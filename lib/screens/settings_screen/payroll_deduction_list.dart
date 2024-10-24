import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/models/settings/deduction_model.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/settings_screen/controller/deduction_controller.dart';
import 'package:flutter_dashboard/screens/settings_screen/widget/default_add_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PayrollDeductionList extends StatelessWidget {
  PayrollDeductionList({super.key});
  final _dataTableHorizontalScrollController = ScrollController();
  final screenController = Get.put(DeductionController());
  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: 'Deduction List',
            subtitle: '',
            icon: Icon(Icons.rocket),
            buttonTitle: 'Add Deduction Type',
            onClick: () {
              Get.toNamed(Routes.AddDeductionType);
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
                                child: Obx(() {
                                  if (screenController.deduction.isEmpty) {
                                    return Center(
                                      child:
                                          Text('No payroll_deductions found'),
                                    );
                                  } else {
                                    return DataTable(
                                      headingTextStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      headingRowHeight: 50,
                                      headingRowColor: WidgetStateProperty.all(
                                          AppColors.bgGreyColor),
                                      // border: TableBorder(
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
                                              if (screenController
                                                  .isSortasc.value) {
                                                screenController.deduction.sort(
                                                    (a, b) => a.deductionName
                                                        .compareTo(
                                                            b.deductionName));
                                              } else {
                                                screenController.deduction.sort(
                                                    (a, b) => b.deductionName
                                                        .compareTo(
                                                            a.deductionName));
                                              }
                                              screenController.isSortasc.value =
                                                  !screenController
                                                      .isSortasc.value;
                                            },
                                            label: Row(
                                              children: [
                                                Text('Deduction'),
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
                                            Text(''),
                                            //  IconButton(
                                            //      onPressed: () {},
                                            //      icon: Icon(Icons.arrow_drop_down_sharp))
                                          ],
                                        )),
                                      ],
                                      rows: List.generate(
                                          screenController.deduction.length,
                                          (index) {
                                        var deduction =
                                            screenController.deduction[index];
                                        return DataRow.byIndex(
                                          index: index,
                                          cells: [
                                            DataCell(Text('${index + 1}')),
                                            DataCell(_buildDeductionCell(
                                                deduction.deductionName)),
                                            DataCell(Text(
                                                deduction.isActive.toString())),
                                            DataCell(TextButton(
                                                onPressed: () {
                                                  showEditDialog(
                                                      context,
                                                      DialogType.info,
                                                      index,
                                                      deduction);
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
                                    );
                                  }
                                }),
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

  Widget _buildDeductionCell(String name) {
    String truncatedname =
        name.length > 15 ? '${name.substring(0, 15)}...' : name;
    return Tooltip(
      message: name,
      child: Text(
        truncatedname,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  showEditDialog(BuildContext context, DialogType dialogType, int index,
      Deduction deduction) {
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController nameController =
        TextEditingController(text: deduction.deductionName);
    //  TextEditingController statusController =
    // TextEditingController(text: industry.status);
    TextEditingController remarksController =
        TextEditingController(text: deduction.remarks);
    final dialogWidth = screenWidth * 0.8;
    final dialog = AwesomeDialog(
      alignment: Alignment.center,
      context: context,
      transitionAnimationDuration: const Duration(microseconds: 300),
      dialogType: dialogType,
      title: 'Update Deduction',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Update Deduction',
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
                                cursorColor: AppColors.defaultColor,
                                name: 'Deduction Name',
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Deduction Name',
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
                                initialValue: deduction.status,
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
                                controller: remarksController,
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
                                buttonname: 'Update Deduction',
                                onClick: () async {
                                  deduction.deductionName = nameController.text;
                                  deduction.remarks = remarksController.text;
                                  await screenController
                                      .updateDeduction(deduction);
                                  // Get.back();
                                }),
                          ],
                        ),
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
            buildSizedBoxH(kDefaultPadding),
          ]),
        ),
      ),
      //  width: dialogWidth,
      // btnOkOnPress: () {},
      // btnOk: Container(
      //   alignment: Alignment.bottomRight,
      //   width: 150,
      //   //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(5)),
      //         // fixedSize: const Size.fromHeight(3),
      //         padding: EdgeInsets.zero,
      //         backgroundColor: AppColors
      //             .defaultColor // Change this color to your desired color
      //         ),

      //     onPressed: () {
      //       deduction.deductionName = nameController.text;
      //       deduction.remarks = remarksController.text;
      //       deduction.status = screenController.selectedStatus.toString();
      //       screenController.updateDeduction(deduction);
      //       Get.off(() => PayrollDeductionList());
      //     },
      //     child: const Padding(
      //       padding: EdgeInsets.all(8.0),
      //       child: Text(
      //         'Update',
      //         style: TextStyle(color: AppColors.whiteColor),
      //       ),
      //     ),
      //     // onPressed: widget.onClick
      //   ),
      // )
    );

    dialog.show();
  }
}
