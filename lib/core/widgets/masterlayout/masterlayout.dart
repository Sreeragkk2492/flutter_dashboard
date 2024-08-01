
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/generated/l10n.dart';

import 'package:flutter_dashboard/core/widgets/side_bar.dart';



import 'package:flutter_dashboard/routes/routes.dart';

final sidebarMenuConfigs = [
  SidebarMenuConfig(
      uri: Routes.DASHBOARD,
      icon: Icons.dashboard_rounded,
      title: (context) => Lang.of(context).dashboard),
       SidebarMenuConfig(
    uri: '', 
    icon: Icons.interests_rounded,
    title: (context) => 'Company',
    children: [
      SidebarChildMenuConfig(
        uri:  Routes.CLISTALL,   
        icon: Icons.circle_outlined,
        title: (context) => 'List All',
      ),
      SidebarChildMenuConfig(
        uri:  Routes.COMAPANYMODULE,
        icon: Icons.circle_outlined,
        title: (context) => 'Company Modules',
      ),
      SidebarChildMenuConfig(
        uri:  Routes.COMPANYLEAVETYPE,
        icon: Icons.circle_outlined,
        title: (context) => 'Leave Type',
      ),
      SidebarChildMenuConfig(
        uri:Routes.COMPANYHOLIDAY,
        icon: Icons.circle_outlined,
        title: (context) => 'Holiday List',
      ),
       SidebarChildMenuConfig(
        uri:Routes.COMPANYMENU,
        icon: Icons.circle_outlined,
        title: (context) => 'Company menu', 
      ),
    ],
  ),
   SidebarMenuConfig(
    uri: '', 
    icon: Icons.charging_station,
    title: (context) => 'Employee',
    children: [
      SidebarChildMenuConfig(
        uri:  Routes.EmployeeListAll,  
        icon: Icons.circle_outlined,
        title: (context) => 'List All',
      ),
      SidebarChildMenuConfig(
        uri:  Routes.EmployeeMenu,
        icon: Icons.circle_outlined,
        title: (context) => 'Employee Menu',
      ),
    ]),
    SidebarMenuConfig(
    uri: '', 
    icon: Icons.interests_rounded,
    title: (context) => 'Payroll',
    children: [
      SidebarChildMenuConfig(
        uri:  Routes.AllowanceList,  
        icon: Icons.circle_outlined,
        title: (context) => 'Allowance List',
      ),
       SidebarChildMenuConfig(
        uri:  Routes.DeductionList,  
        icon: Icons.circle_outlined,
        title: (context) => 'Deduction List',
      ),
     
      SidebarChildMenuConfig(
        uri:  Routes.CompanyPayrollAllowance,
        icon: Icons.circle_outlined,
        title: (context) => 'Comapny Payroll Allowance',
      ),
      SidebarChildMenuConfig(
        uri:Routes.CompanyPayrollDeduction,
        icon: Icons.circle_outlined,
        title: (context) => 'Company Payroll Deduction',
      ),
        SidebarChildMenuConfig(
        uri:Routes.PayrollProcessingDate,
        icon: Icons.circle_outlined,
        title: (context) => 'Payroll Processing Date',
      ),
      SidebarChildMenuConfig(
        uri:Routes.MaxLeaveAllowed,
        icon: Icons.circle_outlined,
        title: (context) => 'Max Leave Allowed',
      ),
    ],
  ),
    SidebarMenuConfig(
    uri: '', 
    icon: Icons.interests_rounded,
    title: (context) => 'Settings', 
    children: [
      SidebarChildMenuConfig(
        uri:  Routes.IndustryList,   
        icon: Icons.circle_outlined,
        title: (context) => 'Industry List',
      ),
       SidebarChildMenuConfig(
        uri:  Routes.DepartmentList,   
        icon: Icons.circle_outlined,
        title: (context) => 'Department List',
      ),
       SidebarChildMenuConfig(
        uri:  Routes.DesignationList,   
        icon: Icons.circle_outlined,
        title: (context) => 'Designation List',
      ),
       SidebarChildMenuConfig(
        uri:  Routes.EmployementCategoryList,   
        icon: Icons.circle_outlined,
        title: (context) => 'Employement Category List',
      ),
     
    ],
  ),
  SidebarMenuConfig(
    uri: Routes.PROFILE,
    icon: Icons.person_2,
    title: (context) =>Lang.of(context).profile 
  ),
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
