import 'package:flutter_dashboard/core/middlewares/employee_reset.dart';
import 'package:flutter_dashboard/core/middlewares/payroll/reset_employee_payslip_details.dart';
import 'package:flutter_dashboard/core/middlewares/payroll/reset_invoice_page.dart';
import 'package:flutter_dashboard/core/middlewares/resetAllowance.dart';
import 'package:flutter_dashboard/core/middlewares/reset_company_holiday.dart';
import 'package:flutter_dashboard/core/middlewares/reset_company_leave_type.dart';
import 'package:flutter_dashboard/core/middlewares/reset_company_menu.dart';
import 'package:flutter_dashboard/core/middlewares/reset_company_modules.dart';
import 'package:flutter_dashboard/core/middlewares/reset_deduction.dart';
import 'package:flutter_dashboard/core/middlewares/reset_employee_payroll.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/company_screen/add_company.dart';
import 'package:flutter_dashboard/screens/company_screen/add_company_holiday.dart';
import 'package:flutter_dashboard/screens/company_screen/add_company_leavetype.dart';
import 'package:flutter_dashboard/screens/company_screen/add_company_menu.dart';
import 'package:flutter_dashboard/screens/company_screen/add_company_modules.dart';
import 'package:flutter_dashboard/screens/company_screen/add_working_shifts.dart';
import 'package:flutter_dashboard/screens/company_screen/comapny_menu.dart';
import 'package:flutter_dashboard/screens/company_screen/company_modules_list.dart';
import 'package:flutter_dashboard/screens/company_screen/company_group_list.dart';
import 'package:flutter_dashboard/screens/company_screen/company_holiday_list.dart';
import 'package:flutter_dashboard/screens/company_screen/company_leave_type.dart';
import 'package:flutter_dashboard/screens/company_screen/company_working_shift.dart';
import 'package:flutter_dashboard/screens/company_screen/list_all_screen.dart';
import 'package:flutter_dashboard/screens/dashboard_screen/dashboard_screen.dart';
import 'package:flutter_dashboard/screens/employee_screen/add_employee.dart';
import 'package:flutter_dashboard/screens/employee_screen/add_employee_menu.dart';
import 'package:flutter_dashboard/screens/employee_screen/employee_attendence_details.dart';
import 'package:flutter_dashboard/screens/employee_screen/employee_leave_days.dart';
import 'package:flutter_dashboard/screens/employee_screen/employee_list_all.dart';
import 'package:flutter_dashboard/screens/employee_screen/employee_menu.dart';
import 'package:flutter_dashboard/screens/employee_screen/employee_selected_holiday.dart';
import 'package:flutter_dashboard/screens/login_screen/login_screen.dart';
import 'package:flutter_dashboard/screens/payroll/add_employee_payroll_settings.dart';
import 'package:flutter_dashboard/screens/payroll/add_employee_payslip.dart';
import 'package:flutter_dashboard/screens/payroll/add_employee_payslip_generation.dart';
import 'package:flutter_dashboard/screens/payroll/employee_payroll_settings.dart';
import 'package:flutter_dashboard/screens/payroll/emp_payslip_details.dart';
import 'package:flutter_dashboard/screens/payroll/payslip_generator.dart';
import 'package:flutter_dashboard/screens/payroll/payslip_invoice.dart';
import 'package:flutter_dashboard/screens/settings_screen/add_allowance.dart';
import 'package:flutter_dashboard/screens/payroll/add_company_allowance_details.dart';
import 'package:flutter_dashboard/screens/payroll/add_company_deduction_details.dart';
import 'package:flutter_dashboard/screens/settings_screen/add_deduction.dart';
import 'package:flutter_dashboard/screens/payroll/add_max_leave_allowed.dart';
import 'package:flutter_dashboard/screens/payroll/add_processing_date.dart';
import 'package:flutter_dashboard/screens/payroll/company_payroll_allowance.dart';
import 'package:flutter_dashboard/screens/payroll/Allowance_list.dart';
import 'package:flutter_dashboard/screens/payroll/deduction_list.dart';
import 'package:flutter_dashboard/screens/payroll/company_payroll_deduction.dart';
import 'package:flutter_dashboard/screens/payroll/deduction_list.dart';
import 'package:flutter_dashboard/screens/payroll/max_leave_allowed.dart';
import 'package:flutter_dashboard/screens/payroll/payroll_processing_date.dart';
import 'package:flutter_dashboard/screens/profile_screen.dart/profile.dart';
import 'package:flutter_dashboard/screens/settings_screen/add_department.dart';
import 'package:flutter_dashboard/screens/settings_screen/add_designation.dart';
import 'package:flutter_dashboard/screens/settings_screen/add_employement.dart';
import 'package:flutter_dashboard/screens/settings_screen/add_industry.dart';
import 'package:flutter_dashboard/screens/settings_screen/department_list.dart';
import 'package:flutter_dashboard/screens/settings_screen/designation_list.dart';
import 'package:flutter_dashboard/screens/settings_screen/employement_category.dart';
import 'package:flutter_dashboard/screens/settings_screen/industry_list.dart';
import 'package:flutter_dashboard/screens/settings_screen/payroll_allowance_list.dart';
import 'package:flutter_dashboard/screens/settings_screen/payroll_deduction_list.dart';
import 'package:flutter_dashboard/screens/settings_screen/system_modules.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../screens/payroll/deduction_list.dart';

class GetPages {
  static const INITAL = Routes.LOGIN;

  static final routes = [
    // GetPage(name: Routes.SPLASH, page: () => const SplashScreen()),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      // binding: AuthBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
        name: Routes.COMAPANYMODULE,
        page: () => ComapnyModules(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.COMPANYHOLIDAY,
        page: () => CompanyHolidayList(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.ADDCOMPANY,
        page: () => AddCompany(),
        transition: Transition.noTransition),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashboardScreen(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileSection(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
        name: Routes.CLISTALL,
        page: () => ListAll(),
        //  binding: HomeBinding(),
        transition: Transition.noTransition,
        middlewares: [
          ResetCompanyLeaveType(),
          ResetCompanyModule(),
          ResetCompanyHoliday(),
          ResetCompanyMenu()
        ]),
    GetPage(
        name: Routes.COMPANYLEAVETYPE,
        page: () => CompanyLeaveType(),
        //  binding: HomeBinding(),
        transition: Transition.noTransition,
        middlewares: [
          ResetCompanyLeaveType(),
          ResetCompanyModule(),
          ResetCompanyHoliday(),
          ResetCompanyMenu()
        ]),
    GetPage(
        name: Routes.CompanyMenuList,
        page: () => CompanyMenuList(),
        //  binding: HomeBinding(),
        transition: Transition.noTransition,
        middlewares: [
          ResetCompanyLeaveType(),
          ResetCompanyModule(),
          ResetCompanyHoliday(),
          ResetCompanyMenu()
        ]),
    GetPage(
        name: Routes.CompanyWorkingShift,
        page: () => CompanyWorkingShift(),
        //  binding: HomeBinding(),
        transition: Transition.noTransition,
        middlewares: [
          ResetCompanyLeaveType(),
          ResetCompanyModule(),
          ResetCompanyHoliday(),
          ResetCompanyMenu()
        ]),
    GetPage(
        name: Routes.CompanyGroupList,
        page: () => CompanyGroupList(),
        //  binding: HomeBinding(),
        transition: Transition.noTransition,
        middlewares: [
          ResetCompanyLeaveType(),
          ResetCompanyModule(),
          ResetCompanyHoliday(),
          ResetCompanyMenu()
        ]),
    GetPage(
        name: Routes.ADDCOMPANYMODULELIST,
        page: () => AddCompanyModules(),
        //  binding: HomeBinding(),
        transition: Transition.noTransition,
        middlewares: [ResetCompanyModule()]),
    GetPage(
      name: Routes.AddWorkingShifts,
      page: () => AddWorkingShifts(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
        name: Routes.AddCompanyLeavetype,
        page: () => AddCompanyLeavetype(),
        //  binding: HomeBinding(),
        transition: Transition.noTransition,
        middlewares: [ResetCompanyLeaveType()]),
    GetPage(
      name: Routes.AddCompanyHoliday,
      page: () => AddCompanyHoliday(),
      //  binding: HomeBinding(),
      middlewares: [ResetCompanyHoliday()],
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddCompanyMenu,
      page: () => AddCompanyMenu(),
      //  binding: HomeBinding(),
      middlewares: [ResetCompanyHoliday(),ResetCompanyMenu()],
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.EmployeeListAll,
      page: () => EmployeeListAll(),
      middlewares: [ResetEmployeeMenuMiddleware()],
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
        name: Routes.AddEmployee,
        page: () => AddEmployee(),
        transition: Transition.noTransition),
    GetPage(
      name: Routes.EmployeeMenu,
      page: () => EmployeeMenu(),
      middlewares: [ResetEmployeeMenuMiddleware()],
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddEmployeeMenu,
      page: () => AddEmployeeMenu(),
      middlewares: [ResetEmployeeMenuMiddleware()],
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
     GetPage(
      name: Routes.EmployeeAttendenceDetails,
      page: () => EmployeeAttendenceDetails(),
      middlewares: [ResetEmployeeMenuMiddleware()],
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
     GetPage(
      name: Routes.EmployeeLeaveDays,
      page: () => EmployeeLeaveDays(),
      middlewares: [ResetEmployeeMenuMiddleware()],
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
      GetPage(
      name: Routes.EmployeeSelectedHolidays,
      page: () => EmployeeSelectedHoliday(),
      middlewares: [ResetEmployeeMenuMiddleware()],
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),

    ///payroll///

    // GetPage(
    //   name: Routes.AllowanceList,
    //   page: () => AllowanceList(),
    //   //  binding: HomeBinding(),
    //   transition: Transition.noTransition,
    // ),
    // GetPage(
    //   name: Routes.DeductionList,
    //   page: () => DeductionList(),
    //   //  binding: HomeBinding(),
    //   transition: Transition.noTransition,
    // ),

    GetPage(
      name: Routes.CompanyAllowanceDetails,
      page: () => CompanyAllowanceDetails(),
      //  binding: HomeBinding(),
      middlewares: [ResetAllowanceMiddleware(), ResetDeductionMiddleware(),ResetEmployeePayroll(),ResetEmployeePayslipDetails()], 
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.CompanyDeductionDetails,
      page: () => CompanyDeductionDetails(),
       middlewares: [ResetAllowanceMiddleware(), ResetDeductionMiddleware(),ResetEmployeePayroll(),ResetEmployeePayslipDetails()],
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.CompanyPayrollDate,
      page: () => CompanyPayrollDate(),
      middlewares: [ResetAllowanceMiddleware(), ResetDeductionMiddleware(),ResetEmployeePayroll(),ResetEmployeePayslipDetails()],
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    // GetPage(
    //   name: Routes.MaxLeaveAllowed,
    //   page: () => MaxLeaveAllowed(),
    //   //  binding: HomeBinding(),
    //   transition: Transition.noTransition,
    // ),
    GetPage(
      name: Routes.AddAllowanceType,
      page: () => AddAllowance(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddDeductionType,
      page: () => AddDeduction(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddCompanyAllowanceDetails,
      page: () => AddCompanyAllowanceDetails(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddCompanyDeductionDetails,
      page: () => AddCompanyDeductionDetails(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddProcessingDate,
      page: () => AddProcessingDate(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.EmployeePayslippDetails,
      page: () => PayslipDetails(),
      //  binding: HomeBinding(),
       middlewares: [ResetAllowanceMiddleware(), ResetDeductionMiddleware(),ResetEmployeePayroll(),ResetEmployeePayslipDetails(),],
      transition: Transition.noTransition,
    ),
    
     GetPage(
      name: Routes.AddEmployeePayslipDetails,
      page: () =>AddEmployeePayslip(),
      //  binding: HomeBinding(),
     //  middlewares: [ ResetEmployeePayslipDetails(),],
      transition: Transition.noTransition,
    ),
      GetPage(
      name: Routes.AddEmployeePayslipGeneration,
      page: () =>AddEmployeePayslipGeneration(),
      //  binding: HomeBinding(),
       middlewares: [ResetAllowanceMiddleware(), ResetDeductionMiddleware(),ResetEmployeePayroll(),ResetEmployeePayslipDetails(),],
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddEmployeePayrollSettings,
      page: () =>AddEmployeePayrollSettings(),
      //  binding: HomeBinding(),
       middlewares: [ResetAllowanceMiddleware(), ResetDeductionMiddleware(),ResetEmployeePayroll(),ResetEmployeePayslipDetails()],
      transition: Transition.noTransition,
    ),
     GetPage(
      name: Routes.EmployeePayrollSettings,
      page: () =>EmployeePayrollSettings(),
      //  binding: HomeBinding(),
       middlewares: [ResetAllowanceMiddleware(), ResetDeductionMiddleware(),ResetEmployeePayroll(),ResetEmployeePayslipDetails()],
      transition: Transition.noTransition,
    ),
     GetPage(
      name: Routes.PayslipGenerator,
      page: () =>PayslipGenerator(),
      //  binding: HomeBinding(),
       middlewares: [ResetAllowanceMiddleware(), ResetDeductionMiddleware(),ResetEmployeePayroll(),ResetEmployeePayslipDetails()],
      transition: Transition.noTransition,
    ),
     GetPage(
      name: Routes.InvoicePage,
      page: () =>PayslipInvoice(),
      //  binding: HomeBinding(),
       middlewares: [ResetAllowanceMiddleware(), ResetDeductionMiddleware(),ResetEmployeePayroll(),ResetEmployeePayslipDetails()],
      transition: Transition.noTransition,
    ),

    ///settings///

    GetPage(
      name: Routes.IndustryList,
      page: () => IndustryList(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),

    GetPage(
      name: Routes.DepartmentList,
      page: () => DepartmentList(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),

    GetPage(
      name: Routes.DesignationList,
      page: () => DesignationList(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),

    GetPage(
      name: Routes.EmployementCategoryList,
      page: () => EmployementCategoryList(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddIndustry,
      page: () => AddIndustry(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddDepartment,
      page: () => AddDepartment(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddDesignation,
      page: () => AddDesignation(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.AddEmployementCategory,
      page: () => AddEmployementCategory(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.PayrollAllowanceList,
      page: () => PayrollAllowanceList(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.PayrollDeductionList,
      page: () => PayrollDeductionList(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.SystemModules,
      page: () => SystemModules(),
      //  binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
  ];
}

// GoRouter appRouter() {
//   return GoRouter(
//     initialLocation: Routes.LOGIN,
//     errorPageBuilder: (context, state) => NoTransitionPage<void>(
//       key: state.pageKey,
//       child:   DashboardScreen(), 
//     ),
//     routes: [
//       // GoRoute(
//       //   path: RouteUri.splash,
//       //   pageBuilder: (context, state) => NoTransitionPage<void>(
//       //     key: state.pageKey,
//       //     child: const SplashScreen(),
//       //   ),
//       // ),
//       GoRoute(
//         path: Routes.LOGIN,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const LoginScreen(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.DASHBOARD,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child:  DashboardScreen(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.COMAPANYMODULE,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const ComapnyModules(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.COMPANYHOLIDAY,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const CompanyHolidayList(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.ADDCOMPANY,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const AddCompany(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.PROFILE,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child:  ProfileSection(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.CLISTALL,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child:  ListAll(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.COMPANYLEAVETYPE,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const CompanyLeaveType(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.COMPANYMENU,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const ComapnyMenu(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.EmployeeListAll,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child:  EmployeeListAll(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.AddEmployee,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const AddEmployee(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.EmployeeMenu,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const EmployeeMenu(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.PayrollListall,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const PayrollListall(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.PayrollMaxleaveallowed,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const PayrollMaxleaveallowed(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.PayrollHolidayList,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const PayrollHolidayList(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.PayrollProcessing,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const PayrollProcessing(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.PayrollProcessingDate,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const PayrollProcessingDate(),
//         ),
//       ),
//       GoRoute(
//           path: Routes.IndustryList,
//           pageBuilder: (context, state) => NoTransitionPage<void>(
//                 key: state.pageKey,
//                 child:  IndustryList(),
//               )),
//       GoRoute(
//         path: Routes.DepartmentList,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child:  DepartmentList(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.DesignationList,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child:  DesignationList(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.EmployementCategoryList,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child:  EmployementCategoryList(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.AddIndustry,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const AddIndustry(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.AddDepartment,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const AddDepartment(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.AddDesignation,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const AddDesignation(),
//         ),
//       ),
//       GoRoute(
//         path: Routes.AddEmployementCategory,
//         pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: const AddEmployementCategory(),
//         ),
//       ),
      // GoRoute(
      //     path: RouteUri.reset,
      //     pageBuilder: (context, state) => NoTransitionPage<void>(
      //           key: state.pageKey,
      //           child: const ResetPasswordScreen(),
      //         )),
      // GoRoute(
      //   path: RouteUri.error404,
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     child: const Error404Screen(),
      //   ),
      // ),
      // GoRoute(
      //   path: RouteUri.error500,
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     child: const Error500Screen(),
      //   ),
      // ),
      // GoRoute(
      //   path: RouteUri.maintanence,
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     child: const MaintanenceScreen(),
      //   ),
      // ),
      // GoRoute(
      //   path: RouteUri.commingsoon,
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     child: const CommingSoonScreen(),
      //   ),
      // ),
      // GoRoute(
      //   path: RouteUri.faqs,
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     child: FAQSScreen(),
      //   ),
      // ),
      // GoRoute(
      //   path: RouteUri.profile,
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     child: ProfileSection(),
      //   ),
      // ),
      // GoRoute(
      //   path: RouteUri.chatscreen,
      //   pageBuilder: (context, state) => NoTransitionPage<void>(
      //     key: state.pageKey,
      //     child: const ChatScreen(),
      //   ),
      // ),
    
    // redirect: (context, state) {
    //   if (unrestrictedRoutes.contains(state.matchedLocation)) {
    //     return null;
    //   } else if (publicRoutes.contains(state.matchedLocation)) {
    //     RouteUri.home;
    //     // Is public route.
    //     // if (userDataProvider.isUserLoggedIn()) {
    //     //   // User is logged in, redirect to home page.
    //     //   return RouteUri.home;
    //     // }
    //   } else {
    //     // Not public route.
    //     // if (!userDataProvider.isUserLoggedIn()) {
    //     // User is not logged in, redirect to login page.
    //     // return RouteUri.login;
    //     // }
    //     RouteUri.home;
    //   }

    //   return null;
    // },
  