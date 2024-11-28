import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/view_models/responsive.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/screens/login_screen/controllers/auth_controller.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final screenController = Get.put(AuthController());

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildMobileLayout(context),
      tablet: _buildTabletLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                children: [ 
                  Image.asset(
                    'assets/l3.jpg',  
                    width: screenWidth / 2,
                    height: screenHeight / 1.2,
                  ),
                ],
              ),
              buildSizedboxW(10),
              Container(
                height: screenHeight / 2,
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(maxWidth: screenWidth / 2.5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _buildForm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTabletLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  'assets/l3.jpg',
                  width: screenWidth,
                  height: screenHeight / 3,
                ),
                buildSizedBoxH(20),
                Container(
                  height: screenHeight / 2,
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(maxWidth: screenWidth - 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _buildForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildMobileLayout(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: AppColors.whiteColor,
  //     body: LayoutBuilder(
  //       builder: (context, constraints) {
  //         return SingleChildScrollView(
  //           child: ConstrainedBox(
  //             constraints: BoxConstraints(minHeight: constraints.maxHeight),
  //             child: IntrinsicHeight(
  //               child: Padding(
  //                 padding: const EdgeInsets.all(16),
  //                 child: Column(
  //                   children: [
  //                     Image.asset(
  //                       'assets/l3.jpg',
  //                       width: double.infinity,
  //                       height: constraints.maxHeight *
  //                           0.25, // 25% of screen height
  //                     ),
  //                     buildSizedBoxH(20),
  //                     Expanded(
  //                       child: Container(
  //                         padding: EdgeInsets.all(10),
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(20),
  //                         ),
  //                         child: _buildForm(context),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  Widget _buildMobileLayout(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.whiteColor,
    body: SafeArea(  // Added SafeArea for better edge handling
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.asset(
                  'assets/l3.jpg',
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              buildSizedBoxH(20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _buildForm(context),
              ),
            ],
          ),
        ),
      ),
    ),
  );
} 

  Widget _buildForm(BuildContext context) {
    return FormBuilder(
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.w900,
              color: AppColors.blackColor,
            ),
          ),
          Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
          ),
          buildSizedBoxH(20),
          Padding(
            padding: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
            child: FormBuilderTextField(
               cursorColor: AppColors.defaultColor,
              name: 'Username',
              controller: screenController.usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your Username',
                labelStyle:
                    TextStyle(color: AppColors.blackColor),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.greycolor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.defaultColor,
                        width: 1.5)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              enableSuggestions: false,
              validator: FormBuilderValidators.required(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: kDefaultPadding * 5.0),
            child: FormBuilderTextField(
              cursorColor: AppColors.defaultColor,
              name: 'Password',
              controller: screenController.passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your Password',
                 labelStyle:
                    TextStyle(color: AppColors.blackColor),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.greycolor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.defaultColor,
                        width: 1.5)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              enableSuggestions: false,
              obscureText: true,
              validator: FormBuilderValidators.required(),
            ),
          ),
          SizedBox(
              height: 50, 
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                ),
                onPressed: ()  {
                 screenController.login(); 
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              )),
          // Padding(
          //   padding: EdgeInsets.only(top: kDefaultPadding),
          //   child: SizedBox(
          //     height: 40,
          //     width: double.infinity,
          //     child: OutlinedButton(
          //       onPressed: () {
          //         // Navigator.of(context).push(
          //         //   MaterialPageRoute(builder: (context) => RegisterScreen()),
          //         // );
          //       },
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Text(
          //             'Don\'t have an Account?',
          //             style: TextStyle(color: AppColors.blackColor),
          //           ),
          //           buildSizedboxW(kTextPadding),
          //           const Text(
          //             'Register Now',
          //             style: TextStyle(color: Colors.blue),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
