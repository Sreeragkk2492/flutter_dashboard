import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> awesomeOkDialog({
  Function()? onOk,
  String? title,
  String? message,
  String? okLabel,
  bool isDismissible = true,
}) async {
  await AwesomeDialog(
    context: Get.context!,
    dialogType: DialogType.info,
    animType: AnimType.bottomSlide,
    title: title,
    desc: message,
    btnOkText: okLabel ?? 'OK',
    btnOkOnPress: onOk,
    dismissOnTouchOutside: isDismissible,
    dismissOnBackKeyPress: isDismissible,
    btnOkColor: Colors.green,
    headerAnimationLoop: false,
    padding: const EdgeInsets.all(12), // Reduced padding
    dialogBackgroundColor: Colors.white,
    buttonsTextStyle: const TextStyle(color: Colors.white, fontSize: 14), // Reduced font size
    titleTextStyle: const TextStyle(
      fontSize: 18, // Reduced font size
      fontWeight: FontWeight.bold,
    ),
    descTextStyle: const TextStyle(fontSize: 14), // Reduced font size
    width: 500, // Set a specific width for the dialog
    buttonsBorderRadius: BorderRadius.circular(5), // Smaller button radius
   // buttonsTextStyle: const TextStyle(fontSize: 14), // Smaller button text
  ).show();
}

Future<void> awesomeSuccessDialog({
  Function()? onOk,
  String? title,
  String? message,
  String? okLabel,
  bool isDismissible = true,
}) async {
  await AwesomeDialog(
    context: Get.context!,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    title: title,
    desc: message,
    btnOkText: okLabel ?? 'OK',
    btnOkOnPress: onOk,
    dismissOnTouchOutside: isDismissible,
    dismissOnBackKeyPress: isDismissible,    
    btnOkColor: Colors.green,
    headerAnimationLoop: false,
    padding: const EdgeInsets.all(12), // Reduced padding
    dialogBackgroundColor: Colors.white,
    buttonsTextStyle: const TextStyle(color: Colors.white, fontSize: 14), // Reduced font size
    titleTextStyle: const TextStyle(
      fontSize: 18, // Reduced font size
      fontWeight: FontWeight.bold,
    ),
    descTextStyle: const TextStyle(fontSize: 14), // Reduced font size
    width: 500, // Set a specific width for the dialog
    buttonsBorderRadius: BorderRadius.circular(5), // Smaller button radius
   // buttonsTextStyle: const TextStyle(fontSize: 14), // Smaller button text 
  ).show();
}