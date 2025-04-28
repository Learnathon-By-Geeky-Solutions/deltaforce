// import 'package:get/get.dart';
// import 'dart:ui';
//
// class LanguageToggle {
//   // Reactive variable to track current language
//   final RxString currentLanguage = 'en_US'.obs;
//
//   // Getter for current language
//   //String get currentLanguage => _currentLanguage.value;
//
//   // Function to toggle between English (en_US) and Bangla (bn_BD)
//   void toggleLanguage() {
//     if (currentLanguage.value == 'en_US') {
//       Get.updateLocale(const Locale('bn', 'BD'));
//       currentLanguage.value = 'bn_BD';
//     } else {
//       Get.updateLocale(const Locale('en', 'US'));
//       currentLanguage.value = 'en_US';
//     }
//   }
// }