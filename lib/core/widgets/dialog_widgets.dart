import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/models/user_model.dart';
import 'package:flutter_dashboard/screens/company_screen/widget/company_form_widget.dart';
import 'package:flutter_dashboard/screens/company_screen/widget/details_form_widgte.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/employee_screen/employee_list_all.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/details_dialog_widget.dart';
import 'package:flutter_dashboard/screens/employee_screen/widget/edit_employee_form.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final screenController = Get.put(EmployeeController());

class DialogWidgets {
  static void showDialog(BuildContext context, DialogType dialogType) {
    final dialog = AwesomeDialog(
        context: context,
        transitionAnimationDuration: const Duration(microseconds: 300),
        dialogType: dialogType,
        title: 'Dialog Title',
        desc: 'Dialog body...',
        width: kDialogWidth,
        btnOkOnPress: () {
          Get.back();
        },
        btnCancelOnPress: () {},
        body: const Center(
          child: Text('Updated succesfully'),
        ));

    dialog.show();
  }

  static void showDetailsDialog(BuildContext context, DialogType dialogType) {
    final screenWidth = MediaQuery.of(context).size.width;
    Size screenSize = MediaQuery.of(context).size;
    final dialogWidth = screenWidth * 0.8;
    final dialog = AwesomeDialog(
        alignment: Alignment.center,
        context: context,
        transitionAnimationDuration: const Duration(microseconds: 300),
        dialogType: dialogType,
        title: 'Company Info',
        desc: '',
        body: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(children: [
              screenSize.width >= kScreenWidthLg
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding + kTextPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(flex: 4, child: DetailsFormWidget()),
                          buildSizedboxW(kDefaultPadding),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding + kTextPadding),
                      child: Column(
                        children: [
                          DetailsFormWidget(),
                          buildSizedBoxH(kDefaultPadding),
                        ],
                      ),
                    )
            ]),
          ),
        ),

        // width: dialogWidth,
        btnOkOnPress: () {},
        btnOk: Container(
          alignment: Alignment.bottomRight,
          width: 150,
          //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                // fixedSize: const Size.fromHeight(3),
                padding: EdgeInsets.zero,
                backgroundColor: AppColors
                    .defaultColor // Change this color to your desired color
                ),

            onPressed: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'ok ',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            // onPressed: widget.onClick
          ),
        ));

    dialog.show();
  }

  static void showEmpDetailsDialog(
      BuildContext context, DialogType dialogType) {
    final screenWidth = MediaQuery.of(context).size.width;
    Size screenSize = MediaQuery.of(context).size;
    final dialogWidth = screenWidth * 0.8;
    final dialog = AwesomeDialog(
        alignment: Alignment.center,
        context: context,
        transitionAnimationDuration: const Duration(microseconds: 300),
        dialogType: dialogType,
        title: 'Employee Info',
        desc: '',
        body: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child: Column(children: [
              screenSize.width >= kScreenWidthLg
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding + kTextPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(flex: 4, child: DetailsDialogEmpWidget()),
                          buildSizedboxW(kDefaultPadding),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                          vertical: kDefaultPadding + kTextPadding),
                      child: Column(
                        children: [
                          DetailsDialogEmpWidget(),
                          buildSizedBoxH(kDefaultPadding),
                        ],
                      ),
                    )
            ]),
          ),
        ),
        // width: dialogWidth,
        btnOkOnPress: () {},
        btnOk: Container(
          alignment: Alignment.bottomRight,
          width: 150,
          //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                // fixedSize: const Size.fromHeight(3),
                padding: EdgeInsets.zero,
                backgroundColor: AppColors
                    .defaultColor // Change this color to your desired color
                ),

            onPressed: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'ok ',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            // onPressed: widget.onClick
          ),
        ));

    dialog.show();
  }

  // static void showEditDialog(BuildContext context, DialogType dialogType,
  //     , int index) {
  //   TextEditingController namecontroller =
  //       TextEditingController(text: controller.filteredCompany[index].name);
  //   TextEditingController idcontroller =
  //       TextEditingController(text: controller.filteredCompany[index].Comp_id);
  //   TextEditingController codecontroller = TextEditingController(
  //       text: controller.filteredCompany[index].Comp_code);
  //   TextEditingController statuscontroller =
  //       TextEditingController(text: controller.filteredCompany[index].Status);
  //   TextEditingController whatsappcontroller =
  //       TextEditingController(text: controller.filteredCompany[index].Whatsapp);
  //   TextEditingController mobcontroller = TextEditingController(
  //       text: controller.filteredCompany[index].Mobilenumber);
  //   final screenWidth = MediaQuery.of(context).size.width;
  //   final dialogWidth = screenWidth * 0.8;
  //   final dialog = AwesomeDialog(
  //       alignment: Alignment.center,
  //       context: context,
  //       transitionAnimationDuration: const Duration(microseconds: 300),
  //       dialogType: dialogType,
  //       title: 'Company Info',
  //       desc: '',
  //       body: Padding(
  //         padding: EdgeInsets.all(kDefaultPadding),
  //         child: SingleChildScrollView(
  //           child:
  //               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //             Text('Basic information',
  //                 style: GoogleFonts.montserrat(
  //                     fontSize: kDefaultPadding + kTextPadding,
  //                     fontWeight: FontWeight.bold)),
  //             buildSizedBoxH(kDefaultPadding),
  //             CompanyFormWidget(
  //               companyIdController: idcontroller,
  //               companyCodeController: codecontroller,
  //               companyNameController: namecontroller,
  //               statusController: statuscontroller,
  //               whatsappController: whatsappcontroller,
  //               phoneNumberController: mobcontroller,
  //               industryController: TextEditingController(),
  //               groupNameController: TextEditingController(),
  //               legalNameController: TextEditingController(),
  //               founderController: TextEditingController(),
  //               emailController: TextEditingController(),
  //               panController: TextEditingController(),
  //               addressController: TextEditingController(),
  //               landmarkController: TextEditingController(),
  //               cityController: TextEditingController(),
  //               stateController: TextEditingController(),
  //               countryController: TextEditingController(),
  //             )
  //           ]),
  //         ),
  //       ),
  //       //  width: dialogWidth,
  //       btnOkOnPress: () {},
  //       btnOk: Container(
  //         alignment: Alignment.bottomRight,
  //         width: 150,
  //         //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
  //         child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(5)),
  //               // fixedSize: const Size.fromHeight(3),
  //               padding: EdgeInsets.zero,
  //               backgroundColor: AppColors
  //                   .defaultColor // Change this color to your desired color
  //               ),

  //           onPressed: () {
  //             showDialog(context, DialogType.success);
  //             // Get.back();
  //           },
  //           child: const Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Text(
  //               'Update',
  //               style: TextStyle(color: AppColors.whiteColor),
  //             ),
  //           ),
  //           // onPressed: widget.onClick
  //         ),
  //       ));

  //   dialog.show();
  // }

  static void showEmpEditDialog(
      BuildContext context, DialogType dialogType, UserModel user) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth * 0.8;
    final dialog = AwesomeDialog(
        alignment: Alignment.center,
        context: context,
        transitionAnimationDuration: const Duration(microseconds: 300),
        dialogType: dialogType,
        title: 'Employee Info',
        desc: '',
        body: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Basic information',
                  style: GoogleFonts.montserrat(
                      fontSize: kDefaultPadding + kTextPadding,
                      fontWeight: FontWeight.bold)),
              buildSizedBoxH(kDefaultPadding),
              EditEmployeeForm()
            ]),
          ),
        ),
        // width: dialogWidth,
        btnOkOnPress: () {},
        btnOk: Container(
          alignment: Alignment.bottomRight,
          width: 150,
          //  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                // fixedSize: const Size.fromHeight(3),
                padding: EdgeInsets.zero,
                backgroundColor: AppColors
                    .defaultColor // Change this color to your desired color
                ),

            onPressed: () {
             // screenController.updateEmployee(user);
              Get.off(() => EmployeeListAll());
              // Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Update',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
            // onPressed: widget.onClick
          ),
        ));

    dialog.show();
  }
}
