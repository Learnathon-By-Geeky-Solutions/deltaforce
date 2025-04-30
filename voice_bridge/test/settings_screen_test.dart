import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/Settings/UI/settings_page_ui.dart';
import 'package:voice_bridge/features/Settings/view-model/settings_view_model.dart';

void main() {
  setUp(() {
    // Reset GetX state before each test
    Get.reset();
  });

  Widget createWidgetUnderTest() => GetMaterialApp(home: SettingsScreen());

  // testWidgets('renders all settings items', (tester) async {
  //   await tester.pumpWidget(createWidgetUnderTest());
  //
  //   expect(find.text('Settings'), findsOneWidget);
  //   expect(find.text('Dark Mode'), findsOneWidget);
  //   expect(find.text('Language'), findsOneWidget);
  //   expect(find.text('Password Update'), findsOneWidget);
  // });

  testWidgets('toggles dark mode switch', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final switchFinder = find.byType(Switch);
    final ThemeViewModel controller = Get.find();

    expect(controller.isDarkMode.value, false);

    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    expect(controller.isDarkMode.value, true);
  });

  // testWidgets('navigates to PasswordUpdateScreen', (tester) async {
  //   await tester.pumpWidget(createWidgetUnderTest());
  //
  //   await tester.tap(find.text('Password Update'));
  //   await tester.pumpAndSettle();
  //
  //   expect(find.byType(PasswordUpdateScreen), findsOneWidget);
  // });
}
