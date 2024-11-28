// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiUrls {
  static String BASE_URL = "https://percapita.qhance.com/app1";

  ///get base url
  // static const GET_BASE_URL = "/get_customer_link";

  ///auth
  // static const LOGIN_URL = "/user/company_admin_login_page";
  static const COMPANY_ADMIN_LOGIN_PAGE = "/user/company_admin_login_page";

  //department
  static const ADD_DEPARTMENT = "/department/add_department";
  static const GET_ALL_DEPARTMENT = "/department/get_departments";
  static const UPDATE_DEPARTMENT = "/department/update_department";
  static const GET_ALL_DEPARTMENTBYCOMPANYID =
      "/designation/department_by_company_id/";

  ///designation
  static const ADD_DESIGNATION = "/designation/add_designation";
  static const GET_ALL_DESIGNATION = "/designation/get_designations";
  static const UPDATE_DESIGNATION = "/designation/update_designation";

  ///employee category
  static const ADD_EMPLOYEE_CATEGORY =
      "/employee_category/add_employee_category";
  static const GET_ALL_EMPLOYEE_CATEGORY =
      "/employee_category/get_emplopyee_category";
  static const UPDATE_EMPLOYEE_CATEGORY =
      "/employee_category/update_employee_category";

  ///employee
  static const ADD_USER = "/user/add_user";
  static const GET_ALL_USER = "/user/get_users";
  static const GET_ALL_USER_BY_CATEGORY = "/user/get_users_by_category";
  static const UPDATE_USER = "/user/update_user";
  static const GET_EMPLOYEE_MENU = "/user_menu_permission/get_all_menus";
  static const GET_ADMIN_FOR_REPORTING = "/user/get_admins_for_reporting";
  static const GET_ALL_USER_BY_COMPANY_ID = "/user/get_users_by_company_id";
  
  static const GET_EMPLOYEE_SELECTED_HOLIDAYS = "/user_holidays/get_user_selected_optional_holidays";

static const GET_EMPLOYEE_LEAVE_REPORT = "/leave/get_leave_report";
static const GET_EMPLOYEE_ATTENDENCE_REPORT = "/attendance_entry/get_attendance_report";
  static const ADD_EMPLOYEE_MENU =
      "/user_menu_permission/add_user_menu_permissions";

  ///company

  static const ADD_COMPANY = "/company/add_company";
  static const GET_ALL_COMPANY = "/company/get_company";
   static const UPDATE_COMPANY = "/company/update_company";
  

  ///prpayrollallowance
  static const ADD_ALLOWANCE = "/meta_payroll_allowance/create_allowance";
  static const GET_ALL_ALLOWANCE = "/meta_payroll_allowance/get_allowance";
  static const UPDATE_ALLOWANCE = "/meta_payroll_allowance/update_allowance";

  ///prpayrolldeduction

  static const ADD_DEDUCTION = "/meta_payroll_deduction/create_deduction";
  static const GET_ALL_DEDUCTION = "/meta_payroll_deduction/get_deduction";

  static const UPDATE_DEDUCTION = "/meta_payroll_deduction/update_deduction";

  ///usertype
  static const GET_ALL_USERTYPE = "/user_type/get_user_type";

  ///attendence

  static const GET_ALL_ATTENDENCE =
      "/attendance-statistics/app_attendance_page";

  ///industry

  static const ADD_INDUSTRY = "/company_types/add_company_type";
  static const GET_ALL_INDUSTRY = "/company_types/get_company_type";
  static const UPDATE_INDUSTRY = "/company_types/update_company_type";

  ///payroll processing date
  static const ADD_PROCESSING_DATE = "/payroll_processing_day/create";
  static const GET_ALL_PROCESSING_DATE =
      "/payroll_processing_day/get_payroll_processing_dates";

  ///prcompanypayrollallowance

  static const ADD_COMPANY_PAYROLL_ALLOWANCE =
      "/company_payroll_allowance/select_allowance_for_company";
  static const GET_ALL_PRCOMPANYPAYROLL_ALLOWANCE =
      "/company_payroll_allowance/get_company_payroll_allowance";

  ///companydeduction

  static const ADD_COMPANY_PAYROLL_DEDUCTION =
      "/company_payroll_deduction/select_deduction_for_company";
  static const GET_ALL_PRCOMPANYPAYROLL_DEDUCTION =
      "/company_payroll_deduction/get_payroll_deduction";

  ///companymodule
  static const GET_ALL_PRAPPLICATION_MODULE =
      "/application_modules/get_application_module";
  static const ADD_COMPANY_MODULE = "/company_modules/add_company_module";

  static const GET_ALL_COMPANY_MODULE =
      "/company_modules/get_company_module_for_admins";

  ///company leave type
  static const GET_ALL_COMPANY_LEAVE_TYPE =
      "/leave-type/get_leave_type_for_superadmin";

  static const ADD_COMPANY_LEAVETYPE = "/leave-type/create_leave_type";

  ///holidaylist
  static const GET_ALL_COMPANY_HOLIDAY =
      "/holiday/get_all_holiday_for_super_admin";

  static const ADD_COMPANY_HOLIDAY = "/holiday/create_holiday_company";

  //company menu list

  static const GET_ALL_COMPANY_MENU =
      "/company_menu_mapping/get_all_menus_for_company";

  static const ADD_COMPANY_MENU =
      "/company_menu_mapping/add_company_menu_permissions";

  //working shifts

  static const GET_ALL_COMPANY_WORKING_SHIFTS = "/shift/shifts";

  static const ADD_COMPANY_WORKING_SHIFTS = "/shift/create_shift";

  //payslip

  static const GET_ALL_EMPLOYEE_PAYSLIP_DETAILS =
      "/employee_payslip_details/get_all_employees_payslip_for_generation";
  static const GET_ALL_EMPLOYEE_PAYROLL_ALLOWANCE_AND_DEDUCTION =
      "/employee_payroll_allowance/show_allowances_and_deductions_of_user";
  static const GET_ALL_EMPLOYEE_PAYROLL_ALLOWANCE_AND_DEDUCTION_IN_ADD =
      "/employee_payroll_allowance/show_allowance_and_deduction_for_user";

  static const ADD_EMPLOYEE_PAYROLL =
      "/employee_payroll_allowance/add_allowances_and_deductions_of_user";
  static const ADD_PAYSLIP_DETAILS =
      "/employee_payslip_details/generate_employee_payslip";

  static const GET_ALL_EMPLOYEE_GENERATED_PAYSLIP_DETAILS =
      "/employee_payslip_details/get_generated_employee_payslip";
}
