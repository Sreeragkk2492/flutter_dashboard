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
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_leave_days_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/condition_widget.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeLeaveDays extends StatelessWidget {
  EmployeeLeaveDays({super.key});

  final _dataTableHorizontalScrollController = ScrollController();

  final employeeController = Get.put(EmployeeController());
 final userNameController = TextEditingController();
  final screenController = Get.put(EmployeeLeaveDaysController());


  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
     final mediaQueryData = MediaQuery.of(context);
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Obx(() {
            return UIComponenetsAppBarNoButton(
              title: 'Employee Leave Days',
              subtitle: Text('Total leaves:${screenController.totalleaves.value}', textAlign: mediaQueryData.size.width >= kScreenWidthLg
                            ? TextAlign.start
                            : TextAlign.center,
                        style: const TextStyle(fontSize: 11),),
              icon: Icon(Icons.rocket),
            );
          }),
        ),
        buildSizedBoxH(kDefaultPadding),
       // _builDropdown(),
        _buildDatepickers(context),
         _builDropdown(context),
        buildSizedBoxH(kDefaultPadding), 
        _buildTable()
      ],
    )));
  }

  Widget _buildTable() {
    return Obx(() {
       if (!screenController.isUserSelected.value) {  
      return Center(child: Text("Please select all the dropdowns to view."));
    }  else if (screenController.isLoading.value) {
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

        if (screenController.leavereport.isEmpty) {
          return Center(child: Text("No leave available for this user."));
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
                                          DataColumn(label: Text('Sl No')),
                                        DataColumn(
                                            // numeric: true,
                                            label: Row(
                                          children: [
                                            Text('Leave date'),

                                            //  IconButton(
                                            //      onPressed: () {},
                                            //      icon: Icon(Icons.arrow_drop_down ))
                                          ],
                                        )),
                                        DataColumn(
                                            // numeric: true,
                                            label: Row(
                                          children: [
                                            Text('Reason'),

                                            //  IconButton(
                                            //      onPressed: () {},
                                            //      icon: Icon(Icons.arrow_drop_down ))
                                          ],
                                        )),
                                        DataColumn(
                                            label: Row(
                                          children: [
                                            Text('Type of leave'),
                                            //  IconButton(
                                            //      onPressed: () {},
                                            //      icon: Icon(Icons.arrow_drop_down_sharp))
                                          ],
                                        )),
                                        // DataColumn(
                                        //     label: Row(
                                        //   children: [
                                        //     Text('Worked time'),
                                        //     //  IconButton(
                                        //     //      onPressed: () {},
                                        //     //      icon: Icon(Icons.arrow_drop_down_sharp))
                                        //   ],
                                        // )),
                                        // DataColumn(
                                        //     label: Row(
                                        //   children: [
                                        //     Text('Over/Short time'),
                                        //     //  IconButton(
                                        //     //      onPressed: () {},
                                        //     //      icon: Icon(Icons.arrow_drop_down_sharp))
                                        //   ],
                                        // )),
                                      ],
                                      // ... (keep the existing DataTable properties)
                                      
                                      rows: List.generate(screenController.leavereport.length, (index){
                                        final leave=screenController.leavereport[index];
                                         return DataRow(
                                           onSelectChanged: (_) {
                                            // setState(() {
                                            //   _selectedUser = screenController.users.firstWhere((user) => user.id == leave.leaveDate); 
                                            // });
                                          },
                                          cells: [
                                            DataCell(Text(
                                          '${index + 1}',
                                        //  style: TextStyle(color: textColor),
                                        )),
                                          DataCell(Text(dateFormat
                                              .format(leave.leaveDate))),
                                          DataCell(Text(leave.reason ?? 'N/A')),
                                          DataCell(
                                              Text(leave.typeOfLeave ?? 'N/A')),
                                          // DataCell(Text(attendece.workedTime
                                          //     .toString())),
                                          // DataCell(Text(attendece
                                          //     .overShortTime
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
    });
  }

  Widget _buildDatepickers(BuildContext context) {
    return Row(
      children: [
        // Flexible(
        //   child: Padding(
        //     padding: EdgeInsets.all(kDefaultPadding),
        //     child: Obx(
        //       () => FormBuilderDateTimePicker(
        //         initialValue: screenController.selectedFromDate.value,
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
        //         onChanged: screenController.onFromDateSelected,
        //         lastDate: DateTime.now(),
        //       ),
        //     ),
        //   ),
        // ),
        // Flexible(
        //   child: Padding(
        //     padding: EdgeInsets.all(kDefaultPadding),
        //     child: Obx(
        //       () => FormBuilderDateTimePicker(
        //         inputType: InputType.date,
        //         format: DateFormat('yyyy-MM-dd'),
        //         name: 'To date',
        //         initialValue: screenController.selectedToDate.value,
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
        //         onChanged: screenController.onToDateSelected,  
        //         lastDate: DateTime.now(),
        //       ),
        //     ),
        //   ),
        // ),
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
                      borderSide: BorderSide(
                          color: AppColors.defaultColor, width: 1.5)),
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
                onTap: ()async{
                  screenController.fromdateController.text=await pickDate(context,format: "yyyy-MM-dd") ?? "";
                },
                
               // lastDate: DateTime.now(),
              ),
            ),
          ),
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
                      borderSide: BorderSide(
                          color: AppColors.defaultColor, width: 1.5)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                keyboardType: TextInputType.name,
               
               
                 
                onTap: ()async{
                  screenController.todateController.text=await pickDate(context,format: "yyyy-MM-dd") ?? "";
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _builDropdown(BuildContext context) { 
    return Obx(()=>
       Row(
        children: [
          // Expanded(
          //   child: Padding(
          //     padding: EdgeInsets.all(kDefaultPadding),
          //     child: Obx(() {
          //       if (employeeController.companydetails.isEmpty) {
          //         // Show loading indicator while fetching company details
          //         return Center(child: CircularProgressIndicator());
          //       }
      
          //       if (employeeController.isSuperAdmin.value) {
          //         // Dropdown for superadmin
          //         return FormBuilderDropdown<Company>(
          //           name: 'Company Name',
          //           decoration: InputDecoration(
          //             labelText: 'Company Name',
          //             hintText: 'Select Company',
          //             labelStyle: TextStyle(color: AppColors.blackColor),
          //             border: OutlineInputBorder(),
          //             enabledBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(color: AppColors.greycolor)),
          //             focusedBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     color: AppColors.defaultColor, width: 1.5)),
          //             floatingLabelBehavior: FloatingLabelBehavior.always,
          //           ),
          //           validator: FormBuilderValidators.required(),
          //           items: employeeController.companydetails
          //               .map((company) => DropdownMenuItem(
          //                     value: company,
          //                     child: Text(company.companyName),
          //                   ))
          //               .toList(),
          //           onChanged: (value) {
          //             screenController.onCompanySelected(value!.id);
          //           },
          //         );
          //       } else {
          //         // Single company display for company admin
          //         final company = employeeController.companydetails[0];
          //         // This will be called only once when the widget is built
          //         WidgetsBinding.instance.addPostFrameCallback((_) {
          //           screenController.onCompanySelected(company.id);
          //         });
          //         return FormBuilderTextField(
          //           name: 'Company Name',
          //           initialValue: company.companyName,
          //           decoration: InputDecoration(
          //             labelText: 'Company Name',
          //             labelStyle: TextStyle(color: AppColors.blackColor),
          //             border: OutlineInputBorder(),
          //             enabledBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(color: AppColors.greycolor)),
          //             focusedBorder: OutlineInputBorder(
          //                 borderSide: BorderSide(
          //                     color: AppColors.defaultColor, width: 1.5)),
          //             floatingLabelBehavior: FloatingLabelBehavior.always,
          //           ),
          //           readOnly: true,
          //         );
          //       }
          //     }),
          //   ),
          // ),
          
          // Expanded(
          //   child: Padding(
          //     padding: EdgeInsets.all(kDefaultPadding),
          //     child: Obx(
          //       () => CustomSuggessionTextFormField(
          //         controller: userNameController,
          //         hintText: 'Select User',
          //         labelText: 'User Name',
          //         suggestons: screenController.filteredUsers
          //             .map((user) => user.name)
          //             .toList(),
          //         validator: FormBuilderValidators.required(),
          //         width: MediaQuery.of(context).size.width * 0.4,
          //         onSelected: () {
          //           final selectedUser = screenController.filteredUsers
          //               .firstWhere((user) => 
          //                   user.name == userNameController.text);
          //           screenController.onUserSelected(
          //             selectedUser.userTypeId,
          //             selectedUser.companyId,
          //             selectedUser.id,
          //            // selectedUser,
          //           );
          //         },
          //        // prefixIcon: const Icon(Icons.person),
          //       ),
          //     ),
          //   ),
          // ),
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
                      .firstWhere((user) => 
                          user.name == userNameController.text);
                  screenController.onUserSelected(
                    selectedUser.userTypeId,
                    selectedUser.companyId,
                    selectedUser.id,
                   // selectedUser,
                  );
                },
              ),
            ),
                 ),
         ),
           // Add spacer to push content to the left when company field is hidden
          if (!employeeController.isSuperAdmin.value)
            Expanded(flex: 1 , child: SizedBox()), 
        ],
      ),
    );
  }
}
