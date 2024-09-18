import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/api/networkManager.dart';
import 'package:flutter_dashboard/core/api/urls.dart';
import 'package:flutter_dashboard/core/constants/credentials.dart';
import 'package:flutter_dashboard/core/services/dialogs/adaptive_ok_dialog.dart';
import 'package:flutter_dashboard/core/services/getx/storage_service.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class AuthController extends GetxController {
  //for login screen
  RxBool isLoading = false.obs;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  autoLogin() async {
    ///automatically login from background
  }

//   login() async {

//     try {
//       final result = await Httpservice.getJwt(usernameController.text, passwordController.text);
//       if (result['success'] == true && result['token'] != null) {
//         Get.toNamed(Routes.DASHBOARD);
//       } else {
//         String errorMessage = result['error'] ?? 'Unknown error occurred';
//         awesomeOkDialog(message: 'Login failed: $errorMessage');
//         if (result['body'] != null) {
//           debugPrint('Response body: ${result['body']}');
//         }
//       }
//     } catch (e) {
//       awesomeOkDialog(message: 'An error occurred: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
// }
  login() async {
    try {
      final result = await NetWorkManager.shared().request(
          url: ApiUrls.BASE_URL + ApiUrls.COMPANY_ADMIN_LOGIN_PAGE,
          params: {
            'username': usernameController.text,
            'password': passwordController.text
          },
          method: 'get',
          isAuthRequired: false);
      if (result.isLeft) {
        awesomeOkDialog(message: result.left.message);
        print(result.left.message);
      } else {
        final data = result.right;

       
        token = data['token'];
        companyId = data['company_id'];
        userType = data['user_type'];

        // Store token and company code securely
        await StorageServices().write("token", token);
        await StorageServices().write("company_id", companyId);
        await StorageServices().write('user_type', userType);

        // Set global variables if needed
        // this.token = token;
        // this.companyCode = companyCode;

        Get.toNamed(Routes.DASHBOARD, );
      }
    } on SocketException catch (e) {
      awesomeOkDialog(
          message:
              "Network error: ${e.message}. Please check your internet connection.");
    } on HttpException catch (e) {
      awesomeOkDialog(message: "HTTP error: ${e.message}");
    } on ClientException catch (e) {
      awesomeOkDialog(message: "Client exception: ${e.message}. URI: ${e.uri}");
    } catch (e) {
      awesomeOkDialog(message: "Unexpected error: $e");
    }
  }
}
