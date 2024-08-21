// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dashboard/core/constants/colors.dart';
// import 'package:flutter_dashboard/core/widgets/dialog_widgets.dart';
// import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';

// class EmployeeDataSource extends DataTableSource {
//   EmployeeDataSource(this.screenController);

//   final EmployeeController screenController;

//   @override
//   int get rowCount => screenController.users.length;

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get selectedRowCount => 0;

//   @override
//   DataRow getRow(int index) {
//     final user = screenController.users[index];
//     return DataRow.byIndex(
//       index: index,
//       cells: [
//         DataCell(GestureDetector(
//           onTap: () {
//            // DialogWidgets.showEmpDetailsDialog(DialogType.info);
//           },
//           child: Text(user.name),
//         )),
//         DataCell(Text(user.employeeId)),
//         DataCell(Text('')),
//         DataCell(Text(user.phoneNumber.toString())),
//         DataCell(TextButton(
//           onPressed: () {
//            // DialogWidgets.showEmpEditDialog(context, DialogType.info, user);
//           },
//           child: const Text(
//             'Edit',
//             style: TextStyle(
//               color: AppColors.blackColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         )),
//       ],
//     );
//   }
// }