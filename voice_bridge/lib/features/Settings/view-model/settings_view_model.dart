import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:voice_bridge/features/Settings/service/theme_service.dart';

class ThemeViewModel extends GetxController {
  final ThemeService _themeService;
  var isDarkMode = false.obs;

  ThemeViewModel({ThemeService? themeService})
      : _themeService = themeService ?? ThemeService();

  factory ThemeViewModel.withService(ThemeService service) {
    final vm = ThemeViewModel(themeService: service);
    vm.isDarkMode.value = service.theme == ThemeMode.dark;
    return vm;
  }

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _themeService.theme == ThemeMode.dark;
  }

  void toggleTheme() {
    isDarkMode.toggle();
    _themeService.switchTheme();
    update();
  }
}
