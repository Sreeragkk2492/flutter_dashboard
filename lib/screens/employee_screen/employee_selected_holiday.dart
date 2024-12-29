import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter_dashboard/core/widgets/custom_suggestion_feild.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar_without_button.dart';
import 'package:flutter_dashboard/models/company_models/company_models.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_selected_holiday_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/condition_widget.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeSelectedHoliday extends StatelessWidget {
   EmployeeSelectedHoliday({super.key});
   final _dataTableHorizontalScrollController = ScrollController();
    final screenController = Get.put(EmployeeSelectedHolidayController());
    final employeeController = Get.put(EmployeeController());
  final userNameController = TextEditingController();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
         Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBarNoButton(
            title: 'Employee Selected Holidays', 
            subtitle: Text(''),
            icon: Icon(Icons.rocket),
           
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        Obx(()=>
           Row(
            children: [
               if (employeeController.isSuperAdmin.value) // Only show if superadmin
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Obx(() {
                if (employeeController.companydetails.isEmpty) {
                  return Center(child: AnimatedCircularProgressIndicator(
                   // size: 60,
                    
                  ));
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
                    () =>  CustomSuggessionTextFormField(
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
                        .firstWhere((user) => 
                            user.name == userNameController.text);
                    screenController.onUserSelected(
                      selectedUser.userTypeId,
                      selectedUser.companyId,
                      selectedUser.id,
                      //selectedUser,
                    );
                  },
                 // prefixIcon: const Icon(Icons.person),
                ),
                  ),
                ),
              ),
               if (!employeeController.isSuperAdmin.value)
            Expanded(flex: 1 , child: SizedBox()),  
            ],
          ),
        ),
         buildSizedBoxH(kDefaultPadding),
        Obx(() {
          if (!screenController.isUserSelected.value) {
            return Center(
                child: Text(
                    "Please select the feils"));
          } else if (screenController.isLoading.value) {
            return Center(
              child: AnimatedCircularProgressIndicator(
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

            if (screenController.seletedHolidays.isEmpty) {
              return Center(child: Text("No selected holiday available for this user."));
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
                                                Text('Date'),
                    
                                                //  IconButton(
                                                //      onPressed: () {},
                                                //      icon: Icon(Icons.arrow_drop_down ))
                                              ],
                                            )),
                                            DataColumn(
                                                label: Row(
                                              children: [
                                                Text('Optional Holiday'),
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
                                          rows: List.generate(screenController.seletedHolidays.length, (index){
                                            final holiday=screenController.seletedHolidays[index];
                                             return DataRow(cells: [
                                               DataCell(Text('${index + 1}')),
                                              DataCell(
                                                  Text(dateFormat.format(holiday.date))),
                                              DataCell(Text(holiday.description.toString())),
                                              // DataCell(Text(menu.isSelected
                                              //     .toString())),
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
    )));
  }
}
