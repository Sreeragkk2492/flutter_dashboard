import 'dart:async';

import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/screens/login_screen/controllers/auth_controller.dart';
import 'package:flutter_dashboard/screens/login_screen/login_screen.dart';
import 'package:get/get.dart';
import '../services/dialogs/adaptive_ok_dialog.dart';

//this function used for the time of token time out
//so the entire screen redirect to login screen

bool isLoginDialogShowing = false;
bool isLoginAutoInitiated = false;
Future<bool> tokenManagement() async {
  bool result = false;
  if (!isLoginAutoInitiated) {
    isLoginAutoInitiated = true;
    result = await Get.put(AuthController()).autoLogin();
    await Future.delayed(const Duration(seconds: 1));
    isLoginAutoInitiated = false;
  }
  return result;
}

forceLogin() {
  if (!isLoginDialogShowing && Get.currentRoute != "/LoginScreen") {
    awesomeOkDialog(
      onOk: () {
        StorageServices().delete("token");
        StorageServices().delete("username");
        StorageServices().delete("password");
        Get.offAll(() => LoginScreen());

        isLoginDialogShowing = false;
      },
      title: "Login timeout!",
      message: "Please login to continue",
      okLabel: "Login",
    );
    isLoginDialogShowing = true;
  }
}
