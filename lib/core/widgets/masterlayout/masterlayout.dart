import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/generated/l10n.dart';

import 'package:flutter_dashboard/core/widgets/side_bar.dart';

import 'package:flutter_dashboard/routes/routes.dart';

final sidebarMenuConfigs = [
  SidebarMenuConfig(
    parentTitle: 'MAIN MENU',
      uri: Routes.DASHBOARD,
      icon: Icons.dashboard_rounded,
      title: (context) => Lang.of(context).dashboard,
      visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
      
      children: [
         SidebarChildMenuConfig(
        uri: Routes.DASHBOARD,
        icon: Icons.dashboard_sharp,
        title: (context) => 'Dashboard',
        visibleFor: ['CMP_ADMIN','QTS_ADMIN']
      ),
      ]),
      
  SidebarMenuConfig(
    uri: '',
    icon: Icons.interests_rounded,
    title: (context) => 'COMPANY',
    parentTitle: 'COMPANY',
    visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
    children: [
      SidebarChildMenuConfig(
        uri: Routes.CLISTALL,
        icon: Icons.list_alt,
        title: (context) => 'List Companies', visibleFor: ['QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.COMAPANYMODULE,
         icon: Icons.view_module,
        title: (context) => 'Company Modules List', visibleFor: ['QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.COMPANYLEAVETYPE,
         icon: Icons.line_weight_outlined,
        title: (context) => ' Company Leave Types', visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.COMPANYHOLIDAY,
        icon: Icons.holiday_village,
        title: (context) => ' Company Holiday List', visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.CompanyMenuList,
        icon: Icons.menu,
        title: (context) => 'Company Menu List', visibleFor: ['QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.CompanyWorkingShift,
        icon: Icons.work_history,
        title: (context) => 'Company Working Shift', visibleFor: ['QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.CompanyGroupList,
         icon: Icons.group,
        title: (context) => ' Company Group List', visibleFor: ['QTS_ADMIN'],
      ),
    ],
  ),
  SidebarMenuConfig(
      uri: '',
      icon: Icons.charging_station,
      title: (context) => 'EMPLOYEE',
      parentTitle: 'EMPLOYEE',
      visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
      
      children: [
        SidebarChildMenuConfig(
          uri: Routes.EmployeeListAll,
          icon: Icons.list,
          title: (context) => 'List Employees', visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
        ),
        SidebarChildMenuConfig(
          uri: Routes.EmployeeMenu,
          icon: Icons.menu,
          title: (context) => 'List Employee Menus', visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
        ),
      ]),
  SidebarMenuConfig(
    uri: '',
    icon: Icons.interests_rounded,
    title: (context) => 'PAYROLL',
    parentTitle: 'PAYROLL',
    visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
    children: [
      SidebarChildMenuConfig(
        uri: Routes.CompanyPayrollDate,
        icon: Icons.date_range,
        title: (context) => 'Companies Payroll Day', visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.CompanyAllowanceDetails,
        icon: Icons.details,
        title: (context) => 'Companies Allowance Details', visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
      ),

      SidebarChildMenuConfig(
        uri: Routes.CompanyDeductionDetails,
        icon: Icons.details,
        title: (context) => 'Company Deduction Details', visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
      ),
       SidebarChildMenuConfig(
        uri: Routes.EmployeePayrollSettings,
        icon: Icons.details,
        title: (context) => 'Employee Payroll Settings', visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri:Routes.AddEmployeePayslipGeneration,
        icon: Icons.settings,
        title: (context) => 'Employee Payslip Details', visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
      ),
       SidebarChildMenuConfig(
        uri:Routes.PayslipGenerator,
        icon: Icons.payment,
        title: (context) => 'Employee Payslip Generator', visibleFor: ['CMP_ADMIN','QTS_ADMIN'],
      ),
      //   SidebarChildMenuConfig(
      //   uri:Routes.PayrollProcessingDate,
      //   icon: Icons.circle_outlined,
      //   title: (context) => 'Payroll Processing Date',
      // ),
      // SidebarChildMenuConfig(
      //   uri:Routes.MaxLeaveAllowed,
      //   icon: Icons.circle_outlined,
      //   title: (context) => 'Max Leave Allowed',
      // ),
    ],
  ),
  SidebarMenuConfig(
    uri: '',
    icon: Icons.interests_rounded,
    title: (context) => 'SETTINGS',
    parentTitle: 'SETTINGS',
    children: [
      SidebarChildMenuConfig(
        uri: Routes.IndustryList,
        icon: Icons.list,
        title: (context) => 'Industry List', visibleFor: ['QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.DepartmentList,
        icon: Icons.list,
        title: (context) => 'Department List', visibleFor: ['QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.DesignationList,
        icon: Icons.list,
        title: (context) => 'Designation List', visibleFor: ['QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.EmployementCategoryList,
        icon: Icons.list,
        title: (context) => 'Employee Category List', visibleFor: ['QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.PayrollAllowanceList,
        icon: Icons.list,
        title: (context) => 'Payroll Allowance List', visibleFor: ['QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.PayrollDeductionList,
        icon: Icons.list,
        title: (context) => 'Payroll Deduction List', visibleFor: ['QTS_ADMIN'],
      ),
      SidebarChildMenuConfig(
        uri: Routes.SystemModules,
        icon: Icons.view_module_sharp,
        title: (context) => 'System Modules', visibleFor: ['QTS_ADMIN'],
      ),
    ], visibleFor: ['QTS_ADMIN'],
  ),
  // SidebarMenuConfig(
  //   uri: Routes.PROFILE,
  //   icon: Icons.person_2,
  //   title: (context) =>Lang.of(context).profile
  // ),
];

var popupMenuItemIndex = 0;
// Widget popupmenu(profile, context) {
//   return PopupMenuButton(
//     tooltip: '',
//     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
//     onSelected: (value) {
//       // popupMenuItemIndex = value;
//     },
//     offset: const Offset(0.0, 55),
//     itemBuilder: (ctx) => [
//       _buildPopupMenuItemTitle('Activity'),
//       _buildPopupMenuItem('chat', Options.search.index, context),
//       _buildPopupMenuItem('Recover password', Options.upload.index, context),
//       _buildPopupMenuItemTitle('My Account'),
//       _buildPopupMenuItem('Setting', Options.copy.index, context),
//       _buildPopupMenuItem('Messages', Options.exit.index, context),
//       _buildPopupMenuItem('Logs', Options.exit.index, context),
//     ],
//     child: Row(
//       children: [
//         CircleAvatar(
//           backgroundColor: Colors.transparent,
//           backgroundImage: profile,
//         ),
//         const Icon(
//           Icons.arrow_drop_down,
//           color: AppColors.textgreyColor,
//         ),
//       ],
//     ),
//   );
// }

// PopupMenuItem _buildPopupMenuItem(String title, int position, context) {
//   return PopupMenuItem(
//     value: position,
//     onTap: () {
//       if (title == 'Setting') {

//       } else if (title == 'chat') {
//         GoRouter.of(context).go(RouteUri.chatscreen);
//       }
//     },
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               buildSizedboxW(kTextPadding * 2),
//               Text(title),
//             ],
//           ),
//           Visibility(
//             visible:
//                 title == 'chat' || title == 'Messages' || title == 'Setting',
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 color: title == 'chat'
//                     ? AppColors.buttonInfoColor
//                     : title == 'Setting'
//                         ? AppColors.tabscreenbutton
//                         : AppColors.errorcolor,
//               ),
//               child: Text(
//                 title == 'chat'
//                     ? '8'
//                     : title == 'Setting'
//                         ? 'New'
//                         : '512',
//                 style:
//                     const TextStyle(fontSize: 11, color: AppColors.whiteColor),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// PopupMenuItem _buildPopupMenuItemTitle(String title) {
//   return PopupMenuItem(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Visibility(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//               decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   color: AppColors.darkTextColor),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 11,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// // enum Options { activity, search, upload, copy, exit }

// // final userprofile = [
// //   Assets.images.avtars.avtars1.provider(),
// //   Assets.images.avtars.avtars2.provider(),
// //   Assets.images.avtars.avtars3.provider(),
// //   Assets.images.avtars.avtars4.provider(),
// //   Assets.images.avtars.avtars5.provider(),
// //   Assets.images.avtars.avtars6.provider(),
// //   Assets.images.avtars.avtars7.provider(),
// //   Assets.images.avtars.avtars8.provider(),
// //   Assets.images.avtars.avtars9.provider(),
// //   Assets.images.avtars.avtars10.provider(),
// //   Assets.images.avtars.avtars11.provider(),
// //   Assets.images.avtars.avtars12.provider(),
// //   Assets.images.avtars.avtars13.provider(),
// //   Assets.images.avtars.avtars14.provider(),
// // ];
