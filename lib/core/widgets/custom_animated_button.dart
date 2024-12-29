import 'package:flutter/material.dart';
import 'package:flutter_dashboard/screens/login_screen/controllers/auth_controller.dart';
import 'package:get/get.dart';

class LoadingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const LoadingButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the AuthController instance
   final screenController = Get.put(AuthController());

    return Obx(() => SizedBox(
          width: width ?? double.infinity,
          height: height ?? 50,
          child: ElevatedButton(
            onPressed: screenController.isLoading.value 
              ? null  // Disable button when loading
              : () {
                  // Call the provided onPressed callback
                  onPressed();
                },
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
              disabledBackgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: screenController.isLoading.value
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ));
  }
}