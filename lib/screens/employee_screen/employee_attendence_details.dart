import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/services/pick_date.dart';
import 'package:flutter_dashboard/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter_dashboard/core/widgets/custom_suggestion_feild.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/models/employee_models/user_model.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_attendence_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/condition_widget.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeAttendenceDetails extends StatelessWidget {
  EmployeeAttendenceDetails({super.key});

  final _dataTableHorizontalScrollController = ScrollController();
  final employeeController = Get.put(EmployeeController());
  final screenController = Get.put(EmployeeAttendenceController());
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final userNameController = TextEditingController();
  // Helper function to determine row color based on remarks
  Color getRowColor(String remarks) {
    switch (remarks.toLowerCase()) {
      case 'weekday':
        return Colors.green.withOpacity(0.1);
      case 'weekend':
        return Colors.red.withOpacity(0.1);
      case 'holiday':
        return Colors.brown.withOpacity(0.1);
      case 'leave':
        return Colors.blue.withOpacity(0.1);
      case 'optional holiday':
        return Colors.yellow.withOpacity(0.1);
      default:
        return Colors.transparent;
    }
  }

  // Helper function to determine text color based on remarks
  Color getTextColor(String remarks) {
    switch (remarks.toLowerCase()) {
      case 'weekday':
        return Colors.green.shade900;
      case 'weekend':
        return Colors.red.shade900;
      case 'holiday':
        return Colors.brown.shade900;
      case 'leave':
        return Colors.blue.shade900;
      case 'optional holiday':
        return Colors.orange.shade900;
      default:
        return Colors.black;
    }
  }

  // Helper function to handle API null values
  String handleApiValue(dynamic value) {
    return value == null ? '--' : value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Obx(
            () => UIComponenetsAppBarNoButton(
              title: 'Employee Attendence Details',
              subtitle: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Work Time:${screenController.totalWorkTimes.value}',
                    textAlign: mediaQueryData.size.width >= kScreenWidthLg
                        ? TextAlign.start
                        : TextAlign.center,
                    style: const TextStyle(fontSize: 11),
                  ),
                  // VerticalDivider(width: 5,thickness: 4,),
                  Text(
                    'Total Over Time:${screenController.totolOvertime.value}',
                    textAlign: mediaQueryData.size.width >= kScreenWidthLg
                        ? TextAlign.start
                        : TextAlign.center,
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
              icon: Icon(Icons.rocket),
            ),
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        _buildDatepickers(context),
        _buildDropdowns(context),
        //  _buildDatepickers(context),
        buildSizedBoxH(kDefaultPadding),
        Obx(() {
          if (!screenController.isUserSelected.value) {
            return const Center(
                child: Text("Please select all the dropdowns to view."));
          } else if (screenController.isLoading.value) {
            return const Center(
                child: AnimatedCircularProgressIndicator(
              size: 60.0,
              strokeWidth: 5.0,
              valueColor: AppColors.defaultColor,
            ));
          } else if (screenController.attendance.isEmpty) {
            return const Center(
                child: Text("No attendence available for this user."));
          }

          // Move the table outside of the Obx
          return Padding(
              padding: EdgeInsets.only(
                  bottom: kDefaultPadding / 2,
                  top: kDefaultPadding,
                  left: kDefaultPadding / 2,
                  right: kDefaultPadding / 2),
              child: Container(
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
                              controller: _dataTableHorizontalScrollController,
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
                                          MaterialStateProperty.all(
                                              AppColors.bgGreyColor),
                                      dividerThickness: 2,
                                      sortColumnIndex: 0,
                                      sortAscending: true,
                                      showCheckboxColumn: false,
                                      showBottomBorder: true,
                                      columns: [
                                        DataColumn(label: Text('Sl No')),
                                        DataColumn(label: Text('Date')),
                                        DataColumn(label: Text('In time')),
                                        DataColumn(label: Text('Out time')),
                                        DataColumn(label: Text('Worked time')),
                                        DataColumn(
                                            label: Text('Over/Short time')),
                                        DataColumn(label: Text('Day')),
                                        DataColumn(label: Text('Remarks')),
                                      ],
                                      rows: List.generate(
                                        screenController.attendance.length,
                                        (index) {
                                          final attendance = screenController
                                              .attendance[index];
                                          final remarks =
                                              attendance.remarks ?? '';
                                          final rowColor = getRowColor(remarks);
                                          final textColor =
                                              getTextColor(remarks);

                                          return DataRow(
                                            color: MaterialStateProperty.all(
                                                rowColor),
                                            cells: [
                                              DataCell(Text(
                                                '${index + 1}',
                                                style:
                                                    TextStyle(color: textColor),
                                              )),
                                              DataCell(Text(
                                                attendance.date != null
                                                    ? dateFormat
                                                        .format(attendance.date)
                                                    : "--",
                                                style:
                                                    TextStyle(color: textColor),
                                              )),
                                              DataCell(Text(
                                                handleApiValue(
                                                    attendance.inTime),
                                                style:
                                                    TextStyle(color: textColor),
                                              )),
                                              DataCell(Text(
                                                handleApiValue(
                                                    attendance.outTime),
                                                style:
                                                    TextStyle(color: textColor),
                                              )),
                                              DataCell(Text(
                                                handleApiValue(
                                                    attendance.workedTime),
                                                style:
                                                    TextStyle(color: textColor),
                                              )),
                                              DataCell(Text(
                                                handleApiValue(
                                                    attendance.overShortTime),
                                                style:
                                                    TextStyle(color: textColor),
                                              )),
                                              DataCell(Text(
                                                handleApiValue(attendance.day),
                                                style:
                                                    TextStyle(color: textColor),
                                              )),
                                              DataCell(Text(
                                                handleApiValue(
                                                    attendance.remarks),
                                                style:
                                                    TextStyle(color: textColor),
                                              )),
                                            ],
                                          );
                                        },
                                      ),
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
        }),
      ],
    )));
  }

  Widget _buildDatepickers(BuildContext context) {
    return Row(
      children: [
        // Flexible(
        //   child: Padding(
        //     padding: EdgeInsets.all(kDefaultPadding),
        //     child: FormBuilderDateTimePicker(
        //        // initialValue: screenController.selectedFromDate.value,
        //         inputType: InputType.date,
        //         format: DateFormat('yyyy-MM-dd'),
        //         name: 'From date',
        //         decoration: const InputDecoration(
        //           suffixIcon: Icon(Icons.calendar_month),
        //           labelText: 'From date',
        //           hintText: 'From date',
        //           labelStyle: TextStyle(color: AppColors.blackColor),
        //           border: OutlineInputBorder(),
        //           focusedBorder: OutlineInputBorder(
        //               borderSide: BorderSide(
        //                   color: AppColors.defaultColor, width: 1.5)),
        //           floatingLabelBehavior: FloatingLabelBehavior.always,
        //         ),
        //         keyboardType: TextInputType.name,
        //         validator: FormBuilderValidators.compose([
        //           FormBuilderValidators.required(),
        //           (value) {
        //             if (value != null && value.isAfter(DateTime.now())) {
        //               return 'Date cannot be in the future';
        //             }
        //             return null;
        //           },
        //         ]),
        //         onChanged:(value){
        //             screenController.onFromDateSelected(value);
        //         },

        //         lastDate: DateTime.now(),
        //       ),
        //     ),
        //   ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: FormBuilderTextField(
              // initialValue: screenController.selectedFromDate.value,
              controller: screenController.fromdateController,
              name: 'From date',
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.calendar_month),
                labelText: 'From date',
                hintText: 'From date',
                labelStyle: TextStyle(color: AppColors.blackColor),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.defaultColor, width: 1.5)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              keyboardType: TextInputType.name,
              readOnly: true,
              // validator: FormBuilderValidators.compose([
              //   FormBuilderValidators.required(),
              //   (value) {
              //     if (value != null && value.isAfter(DateTime.now())) {
              //       return 'Date cannot be in the future';
              //     }
              //     return null;
              //   },
              // ]),
              // onChanged:(value){
              //     screenController.onFromDateSelected(value);
              // },
              onTap: () async {
                screenController.fromdateController.text =
                    await pickDate(context, format: "yyyy-MM-dd") ?? "";
              },

              // lastDate: DateTime.now(),
            ),
          ),
        ),

        // Flexible(
        //   child: Padding(
        //     padding: EdgeInsets.all(kDefaultPadding),
        //     child: FormBuilderDateTimePicker(
        //         inputType: InputType.date,
        //         format: DateFormat('yyyy-MM-dd'),
        //         name: 'To date',
        //        // initialValue: screenController.selectedToDate.value,
        //         decoration: const InputDecoration(
        //           suffixIcon: Icon(Icons.calendar_month),
        //           labelText: 'To date',
        //           hintText: 'To date',
        //           labelStyle: TextStyle(color: AppColors.blackColor),
        //           border: OutlineInputBorder(),
        //           focusedBorder: OutlineInputBorder(
        //               borderSide: BorderSide(
        //                   color: AppColors.defaultColor, width: 1.5)),
        //           floatingLabelBehavior: FloatingLabelBehavior.always,
        //         ),
        //         keyboardType: TextInputType.name,
        //         validator: FormBuilderValidators.compose([
        //           FormBuilderValidators.required(),
        //           (value) {
        //             if (value != null && value.isAfter(DateTime.now())) {
        //               return 'Date cannot be in the future';
        //             }
        //             return null;
        //           },
        //         ]),
        //         onChanged:(value){
        //           screenController.onToDateSelected(value);
        //         },

        //         lastDate: DateTime.now(),
        //       ),
        //     ),
        //   ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: FormBuilderTextField(
              controller: screenController.todateController,
              readOnly: true,
              // inputType: InputType.date,
              // format: DateFormat('yyyy-MM-dd'),
              name: 'To date',
              // initialValue: screenController.selectedToDate.value,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.calendar_month),
                labelText: 'To date',
                hintText: 'To date',
                labelStyle: TextStyle(color: AppColors.blackColor),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.defaultColor, width: 1.5)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              keyboardType: TextInputType.name,

              onTap: () async {
                screenController.todateController.text =
                    await pickDate(context, format: "yyyy-MM-dd") ?? "";
              },
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildDropdowns(BuildContext context) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Padding(
  //           padding: EdgeInsets.all(kDefaultPadding),
  //           child: Obx(() {
  //             if (employeeController.companydetails.isEmpty) {
  //               // Show loading indicator while fetching company details
  //               return Center(child: CircularProgressIndicator());
  //             }

  //             if (employeeController.isSuperAdmin.value) {
  //               // Dropdown for superadmin
  //               return FormBuilderDropdown<Company>(
  //                 name: 'Company Name',
  //                 decoration: InputDecoration(
  //                   labelText: 'Company Name',
  //                   hintText: 'Select Company',
  //                   labelStyle: TextStyle(color: AppColors.blackColor),
  //                   border: OutlineInputBorder(),
  //                   enabledBorder: OutlineInputBorder(
  //                       borderSide: BorderSide(color: AppColors.greycolor)),
  //                   focusedBorder: OutlineInputBorder(
  //                       borderSide: BorderSide(
  //                           color: AppColors.defaultColor, width: 1.5)),
  //                   floatingLabelBehavior: FloatingLabelBehavior.always,
  //                 ),
  //                 validator: FormBuilderValidators.required(),
  //                 items: employeeController.companydetails
  //                     .map((company) => DropdownMenuItem(
  //                           value: company,
  //                           child: Text(company.companyName),
  //                         ))
  //                     .toList(),
  //                 onChanged: (value) {
  //                   screenController.onCompanySelected(value!.id);
  //                 },
  //               );
  //             }
  //              else {
  //               // // Single company display for company admin
  //               // final company = employeeController.companydetails[0];
  //               // // This will be called only once when the widget is built
  //               // WidgetsBinding.instance.addPostFrameCallback((_) {
  //               //   screenController.onCompanySelected(company.id);
  //               // });
  //               // return FormBuilderTextField(
  //               //   name: 'Company Name',
  //               //   initialValue: company.companyName,
  //               //   decoration: InputDecoration(
  //               //     labelText: 'Company Name',
  //               //     labelStyle: TextStyle(color: AppColors.blackColor),
  //               //     border: OutlineInputBorder(),
  //               //     enabledBorder: OutlineInputBorder(
  //               //         borderSide: BorderSide(color: AppColors.greycolor)),
  //               //     focusedBorder: OutlineInputBorder(
  //               //         borderSide: BorderSide(
  //               //             color: AppColors.defaultColor, width: 1.5)),
  //               //     floatingLabelBehavior: FloatingLabelBehavior.always,
  //               //   ),
  //               //   readOnly: true,
  //               // );
  //               return SizedBox.shrink();
  //             }

  //           }),
  //         ),
  //       ),
  //      Expanded(
  //         child: Padding(
  //           padding: EdgeInsets.all(kDefaultPadding),
  //           child: Obx(
  //             () => CustomSuggessionTextFormField(
  //               controller: userNameController,
  //               hintText: 'Select User',
  //               labelText: 'User Name',
  //               suggestons: screenController.filteredUsers
  //                   .map((user) => user.name)
  //                   .toList(),
  //               validator: FormBuilderValidators.required(),
  //               width: MediaQuery.of(context).size.width * 0.4,
  //               onSelected: () {
  //                 final selectedUser = screenController.filteredUsers
  //                     .firstWhere((user) =>
  //                         user.name == userNameController.text);
  //                 screenController.onUserSelected(
  //                   selectedUser.userTypeId,
  //                   selectedUser.companyId,
  //                   selectedUser.id,
  //                   selectedUser,
  //                 );
  //               },
  //              // prefixIcon: const Icon(Icons.person),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildDropdowns(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          if (employeeController.isSuperAdmin.value) // Only show if superadmin
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Obx(() {
                  if (employeeController.companydetails.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return FormBuilderDropdown<Company>(
                    name: 'Company Name',
                    decoration: InputDecoration(
                      labelText: 'Company Name',
                      hintText: 'Select Company',
                      labelStyle: TextStyle(color: AppColors.blackColor),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.greycolor)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.defaultColor, width: 1.5)),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    validator: FormBuilderValidators.required(),
                    items: employeeController.companydetails
                        .map((company) => DropdownMenuItem(
                              value: company,
                              child: Text(company.companyName),
                            ))
                        .toList(),
                    onChanged: (value) {
                      screenController.onCompanySelected(value!.id);
                    },
                  );
                }),
              ),
            ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Obx(
                () => CustomSuggessionTextFormField(
                  controller: userNameController,
                  hintText: 'Select User',
                  labelText: 'User Name',
                  suggestons: screenController.filteredUsers
                      .map((user) => user.name)
                      .toList(),
                  validator: FormBuilderValidators.required(),
                  width: MediaQuery.of(context).size.width * 0.4,
                  onSelected: () {
                    final selectedUser = screenController.filteredUsers
                        .firstWhere(
                            (user) => user.name == userNameController.text);
                    screenController.onUserSelected(
                      selectedUser.userTypeId,
                      selectedUser.companyId,
                      selectedUser.id,
                      selectedUser,
                    );
                  },
                ),
              ),
            ),
          ),
          // Add spacer to push content to the left when company field is hidden
          if (!employeeController.isSuperAdmin.value)
            Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}
