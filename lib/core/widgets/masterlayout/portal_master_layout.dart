import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/colors.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/constants/dimens.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/core/widgets/collapsible_sidebar.dart';
import 'package:flutter_dashboard/core/widgets/custom_animated_button.dart';
import 'package:flutter_dashboard/core/widgets/masterlayout/masterlayout.dart';
import 'package:flutter_dashboard/core/widgets/side_bar.dart';
import 'package:flutter_dashboard/core/widgets/sized_boxes.dart';
import 'package:flutter_dashboard/getx/drawer_getx.dart';
import 'package:flutter_dashboard/getx/sidebar_controller.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_dashboard/screens/employee_screen/controller/employee_controller.dart';
import 'package:flutter_dashboard/screens/login_screen/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LocaleMenuConfig {
  final String languageCode;
  final String? scriptCode;
  final String name;

  const LocaleMenuConfig({
    required this.languageCode,
    this.scriptCode,
    required this.name,
  });
}

class PortalMasterLayout extends StatelessWidget {
  final Widget body;
  final bool autoSelectMenu;
  final String? selectedMenuUri;
  final void Function(bool isOpened)? onDrawerChanged;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final Widget? bottomNavigationBar;
  String? usertype;
   // Make name an observable
  final RxString name = ''.obs;
  final List<Widget>? persistentFooterButtons;

  final screenController=Get.put(AuthController());

  PortalMasterLayout({
    Key? key,
    required this.body,
    this.autoSelectMenu = true,
    this.selectedMenuUri,
    this.onDrawerChanged,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.bottomNavigationBar,
    this.usertype
  }) : super(key: key){
    fetchName();
  }

  final ThemeController themeController = Get.put(ThemeController());
  final  employeeController = Get.put(EmployeeController());
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Update fetchName to set the observable
  fetchName() async {
    String? storedName = await StorageServices().read('name');
    if (storedName != null) {
      name.value = storedName;
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Obx(() {
      final mediaQueryData = MediaQuery.of(context);
      final drawer = (mediaQueryData.size.width <= kScreenWidthLg
          ? _sidebar(context)
          : null);
     // final drawer = _sidebar(context);  
      return Scaffold(
        key: _scaffoldKey, 
        backgroundColor: AppColors.whiteColor, 
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: AppBar(
            
                
            elevation: 4,
            titleSpacing: mediaQueryData.size.width >= kScreenWidthLg
                ? kDefaultPadding * kDefaultPadding / 3
                : 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: themeController.isDarkThemeOn.value
                    ? AppColors.whiteColor
                    : AppColors.whiteColor,
                    boxShadow:  [
                BoxShadow(
                  color: AppColors.bgGreyColor,
                  spreadRadius: 5,
                  blurRadius: 7 
                )
              ] 
              ),
            ),
            automaticallyImplyLeading: (drawer != null),
            centerTitle: mediaQueryData.size.width < kScreenWidthLg,
            title: mediaQueryData.size.width < kScreenWidthLg
                ? Text(
                    'Percapita',
                    style: GoogleFonts.pacifico(
                      fontSize: kDefaultPadding * 2 - kTextPadding,
                      color: AppColors.defaultColor, 
                    ),
                  )
                : ResponsiveAppBarTitle(
                    onAppBarTitlePressed: () =>
                        Get.toNamed(Routes.DASHBOARD),
                  ),
            actions: [
              buildSizedboxW(kDefaultPadding),
              Visibility(
                visible: mediaQueryData.size.width >= kScreenWidthLg,
                child: Row(
                  children: [
                    buildSizedboxW(kDefaultPadding), 
                    _username(name.value), 
                    buildSizedboxW(kDefaultPadding),
                    Padding(
                      padding: EdgeInsets.only(top: kTextPadding * 2),
                      // child: LoadingButton(
                      //   backgroundColor: AppColors.defaultColor,
                      //   width: 150,
                      //   height: 40,
                      //   text: 'Sign Out', onPressed: (){
                      //   screenController.logout();
                        
                      // }),
                      child: TextButton(onPressed: (){
                     screenController.logout();
                      }, child: Text('Sign Out',style: TextStyle(color: AppColors.blackColor),)),
                    ),
                    buildSizedboxW(kDefaultPadding),
                  ],
                ),
              ),
              buildSizedboxW(kDefaultPadding),
            ],
          ),
        ),
        drawer: drawer,
        drawerEnableOpenDragGesture: false,
        onDrawerChanged: onDrawerChanged,
        body: _layoutBody(context),
        bottomNavigationBar: footer(context),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        persistentFooterButtons: persistentFooterButtons,
      );
    });
  }

  

  Widget _layoutBody(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          top: height * 0.2,
          left: 8,
          child: Container(
            height: height / 3,
            width: 166,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,  
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
              child: Container(
                height: 166,
                width: 166,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 100,
          child: Container(
            height: 100,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor, 
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 500,
                sigmaY: 500,
              ),
              child: Container(
                height: 200,
                width: 200,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        _responsiveBody(context),
      ],
    );
  }

  

  Widget _responsiveBody(BuildContext context) {
   if (MediaQuery.of(context).size.width <= kScreenWidthLg) {
      return body;
     } 
    else {
      return Row(
        children: [
          SizedBox(
           // width:250,  
            child: _sidebar(context),
          ),
          Expanded(child: body),
        ],
      );
    }
    // final screenWidth = MediaQuery.of(context).size.width;
    
    // if (screenWidth <= kScreenWidthLg) {
    //   return body;
    // } else {
    //   return Row(
    //     children: [
    //       CollapsibleSidebar(
    //         autoSelectMenu: autoSelectMenu,
    //         selectedMenuUri: selectedMenuUri,
    //         sidebarConfigs: sidebarMenuConfigs,
    //         userType: usertype,
    //       ),
    //       Expanded(
    //         child: Container(
    //           color: AppColors.whiteColor,
    //           child: body,
    //         ),
    //       ),
    //     ],
    //   );
    // }
  }

  Widget footer(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(color: AppColors.drbackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Copyright @ Percapita Fintech Solutions ',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.whiteColor,
              fontSize: MediaQuery.of(context).size.width < kScreenWidthSm
                  ? kDefaultPadding / 1.35
                  : kDefaultPadding,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebar(BuildContext context) {
    return 
    Sidebar(
      autoSelectMenu: autoSelectMenu,
      selectedMenuUri: selectedMenuUri, 
      sidebarConfigs: sidebarMenuConfigs, userType: userType, 
    );
  //   CollapsibleSidebar(
  //   autoSelectMenu: autoSelectMenu,
  //   selectedMenuUri: selectedMenuUri,
  //   sidebarConfigs: sidebarMenuConfigs,
  //   userType: usertype,
  // );
   
  }

 Widget _username(String userName) {
    return Obx(() {
      String companyName = '';
      
      if (!employeeController.isSuperAdmin.value && 
          employeeController.companydetails.isNotEmpty) {
        companyName = employeeController.companydetails.first.companyName;
      }

      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Text(
              userName,
              style: GoogleFonts.inter(
                color: AppColors.textgreyColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSizedBoxH(kTextPadding / 3),
            Text(
              companyName,
              style: GoogleFonts.inter(
                color: AppColors.textgreyColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ResponsiveAppBarTitle extends StatelessWidget {
  final void Function() onAppBarTitlePressed;

  const ResponsiveAppBarTitle({
    Key? key,
    required this.onAppBarTitlePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onAppBarTitlePressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: (mediaQueryData.size.width > kScreenWidthLg),
              child: Text(
                'Percapita',
                style: GoogleFonts.pacifico(
                  fontSize: kDefaultPadding * 2 - kTextPadding,
                  color: AppColors.defaultColor, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
