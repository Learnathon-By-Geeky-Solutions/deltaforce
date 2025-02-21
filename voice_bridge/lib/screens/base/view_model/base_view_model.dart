import 'package:get/get.dart';

class BaseViewModel extends GetxController {
  RxInt selectedIndex = 1.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
