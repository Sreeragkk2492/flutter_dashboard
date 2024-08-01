import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkThemeOn = false.obs;

  void toggleTheme() {
    isDarkThemeOn.value = !isDarkThemeOn.value;
  }
}
