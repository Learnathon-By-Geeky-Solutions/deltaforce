import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:voice_bridge/features/Settings/service/theme_service.dart';
import 'package:voice_bridge/features/Settings/view-model/settings_view_model.dart';

import 'theme_view_model_test.mocks.dart';

@GenerateMocks([ThemeService])
void main() {
  late MockThemeService mockService;
  late ThemeViewModel viewModel;

  setUp(() {
    mockService = MockThemeService();

    // Set up a valid default theme mode
    when(mockService.theme).thenReturn(ThemeMode.light);
    viewModel = ThemeViewModel.withService(mockService);
  });

  test('initializes with correct theme mode (light)', () {
    expect(viewModel.isDarkMode.value, false);
  });

  test('toggles theme and calls ThemeService', () {
    expect(viewModel.isDarkMode.value, false);
    viewModel.toggleTheme();
    expect(viewModel.isDarkMode.value, true);
    verify(mockService.switchTheme()).called(1);
  });
  test('calls onInit and sets isDarkMode correctly from ThemeService', () {
    when(mockService.theme).thenReturn(ThemeMode.dark);

    final vm = ThemeViewModel(themeService: mockService);
    vm.onInit();

    expect(vm.isDarkMode.value, true);
  });

}
