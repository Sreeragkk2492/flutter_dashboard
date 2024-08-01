import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/httpservice.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:get/get.dart';



class AuthController extends GetxController {
  //for login screen
  RxBool isLoading = false.obs;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  autoLogin() async {
    ///automatically login from background
  }

  login() async {
  
    try {
      final result = await Httpservice.getJwt(usernameController.text, passwordController.text);
      if (result['success'] == true && result['token'] != null) {
        Get.toNamed(Routes.DASHBOARD);
      } else {
        String errorMessage = result['error'] ?? 'Unknown error occurred';
        awesomeOkDialog(message: 'Login failed: $errorMessage');
        if (result['body'] != null) {
          debugPrint('Response body: ${result['body']}');
        }
      }
    } catch (e) {
      awesomeOkDialog(message: 'An error occurred: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
}
}
