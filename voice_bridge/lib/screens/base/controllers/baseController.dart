import 'package:get/get.dart';

class BaseController extends GetxController {
  RxInt selectedIndex = 1.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
