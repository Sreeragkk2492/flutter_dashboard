import 'package:get/get.dart';

class SettingsServices extends GetxService {
  static SettingsServices get get => Get.find<SettingsServices>();

  static init() async {
    Get.put(SettingsServices());
  }

  RxBool isAuthenticated = false.obs;
}