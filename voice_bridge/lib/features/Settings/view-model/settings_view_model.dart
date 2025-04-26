import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:voice_bridge/features/Settings/service/theme_service.dart';

class ThemeViewModel extends GetxController {
  final ThemeService _themeService = ThemeService();
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _themeService.theme == ThemeMode.dark;
  }

  void toggleTheme() {
    isDarkMode.toggle();
    _themeService.switchTheme();
    update(); // Notify listeners
  }
}