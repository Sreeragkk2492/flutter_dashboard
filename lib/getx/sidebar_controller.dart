import 'package:get/get.dart';

class SidebarController extends GetxController {
  RxString selectedMenuUri = ''.obs;

 final RxBool isExpanded = false.obs;
  
  void toggleSidebar() {
    isExpanded.value = !isExpanded.value;
  }
}