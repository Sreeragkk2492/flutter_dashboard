import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_leave_days_controller.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';

class EmployeeLeaveDataTable extends StatelessWidget {
  final EmployeeLeaveDaysController screenController;
  final ScrollController scrollController;

  EmployeeLeaveDataTable({
    Key? key,
    required this.screenController,
    required this.scrollController,
  }) : super(key: key);

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (screenController.leavereport.isEmpty) {
        return Center(child: Text("No leave available for this user."));
      } else {
        return Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            child: DataTable(
              headingTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              headingRowHeight: 50,
              headingRowColor: MaterialStateProperty.all(AppColors.bgGreyColor),
              dividerThickness: 2,
              sortColumnIndex: 0,
              sortAscending: true,
              showCheckboxColumn: false,
              showBottomBorder: true,
              columns: [
                DataColumn(label: Text('Leave date')),
                DataColumn(label: Text('Reason')),
                DataColumn(label: Text('Type of leave')),
              ],
              rows: screenController.leavereport.map((leave) {
                return DataRow(cells: [
                  DataCell(Text(dateFormat.format(leave.leaveDate))),
                  DataCell(Text(leave.reason ?? 'N/A')),
                  DataCell(Text(leave.typeOfLeave ?? 'N/A')),
                ]);
              }).toList(),
            ),
          ),
        );
      }
    });
  }
}