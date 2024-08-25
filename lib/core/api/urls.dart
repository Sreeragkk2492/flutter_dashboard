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
   static const GET_ALL_DEPARTMENTBYCOMPANYID = "/designation/department_by_company_id/";

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

  ///user
  static const ADD_USER = "/user/add_user";
  static const GET_ALL_USER = "/user/get_users";
  static const UPDATE_USER = "/user/update_user";

  ///company

  static const ADD_COMPANY = "/company/add_company";
  static const GET_ALL_COMPANY = "/company/get_company";

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
   static const GET_ALL_PROCESSING_DATE = "/payroll_processing_day/get_payroll_processing_dates";
   
  

  ///prcompanypayrollallowance
  
   static const ADD_COMPANY_PAYROLL_ALLOWANCE = "/company_payroll_allowance/select_allowance_for_company";
  static const GET_ALL_PRCOMPANYPAYROLL_ALLOWANCE =
      "/company_payroll_allowance/get_company_payroll_allowance";

  ///companydeduction
    
   static const ADD_COMPANY_PAYROLL_DEDUCTION = "/company_payroll_deduction/create_payroll_deduction"; 
    static const GET_ALL_PRCOMPANYPAYROLL_DEDUCTION =
      "/company_payroll_deduction/get_payroll_deduction";


  ///companymodule
  static const GET_ALL_PRAPPLICATION_MODULE =
      "/application_modules/get_application_module";
 static const ADD_COMPANY_MODULE = "/company_modules/add_company_module";

  static const GET_ALL_COMPANY_MODULE = "/company_modules/get_company_module";
      
}
