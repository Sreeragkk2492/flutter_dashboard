import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/animations/entrance_fader.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/portal_master_layout.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/core/widgets/ui_component_appbar.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/payroll/controller/company_payroll_deduction_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../models/company_models.dart';

class CompanyDeductionDetails extends StatelessWidget {
  CompanyDeductionDetails({super.key});
  final screenController = Get.put(CompanyPayrollDeductionController());
  final _dataTableHorizontalScrollController = ScrollController();
  final employeecontroller = Get.put(EmployeeController());
  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        body: EntranceFader(
            child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: UIComponenetsAppBar(
            title: 'Company Payroll Deduction ',
            subtitle: '',
            icon: Icon(Icons.rocket),
            buttonTitle: 'Add Company Deduction Details',
            onClick: () {
              Get.toNamed(Routes.AddCompanyDeductionDetails);
            },
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        Padding(
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
              items: employeecontroller.companydetails
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
                screenController.onCompanySelected(
                    value!.id, value.companyCode);
              },
              // onSaved: (value) => (_formData.firstname = value ?? ''),
            ),
          ),
        ),
        buildSizedBoxH(kDefaultPadding),
        Obx(() {
          if (!screenController.isCompanySelected.value) {
            return Center(
                child: Text("Please select a company to view deduction."));
          } else if (screenController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final selectedDeduction = screenController.companyDeduction
                .where((deduction) => deduction.isSelected)
                .toList();

            if (selectedDeduction.isEmpty) {
              return Center(
                  child: Text("No selected deduction for this company."));
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
                                                // numeric: true,
                                                label: Row(
                                              children: [
                                                Text('Company Name'),

                                                //  IconButton(
                                                //      onPressed: () {},
                                                //      icon: Icon(Icons.arrow_drop_down ))
                                              ],
                                            )),
                                            DataColumn(
                                                label: Row(
                                              children: [
                                                Text('Payroll Deduction '),
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
                                              selectedDeduction.length,
                                              (index) {
                                            var companypayrolldeduction =
                                                selectedDeduction[index];
                                            return DataRow.byIndex(
                                              index: index,
                                              cells: [
                                                DataCell(Text('#${index + 1}')),
                                                DataCell(Text(screenController
                                                    .companypayrolldeduction
                                                    .value
                                                    .companyId)),
                                                DataCell(Text(
                                                    companypayrolldeduction
                                                        .deduction)),
                                                DataCell(Text(screenController
                                                    .companypayrolldeduction
                                                    .value
                                                    .status)),
                                                DataCell(TextButton(
                                                    onPressed: () {
                                                      // showEditDialog(
                                                      //     context,
                                                      //     DialogType.info,
                                                      //     index,
                                                      //     department);
                                                    },
                                                    child: const Text(
                                                      'Edit',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .blackColor,
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
        }),
      ],
    )));
  }
}
