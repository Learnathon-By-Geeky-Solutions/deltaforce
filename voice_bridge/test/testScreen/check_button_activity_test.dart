import 'package:flutter/material.dart'; // ✅ Required for Route
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_bridge/screens/testScreen/controllers/test_controller.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';

class FakeNavigatorObserver extends NavigatorObserver {
  final List<String> navigatedRoutes = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      navigatedRoutes.add(route.settings.name!);
    }
    super.didPush(route, previousRoute);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('checkButtonActivity triggers testCompletion when last lesson and answer is selected', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final controller = TestController();
    Get.put(controller);

    controller.lessonLength = 1;
    controller.testCurrentLessonIndex.value = 0;
    controller.selectedIndex.value = 0;
    controller.correctIndex = 0;
    controller.testCurrentCategory = "Emotion";
    controller.testTopSessionLevel["Emotion"] = 1;
    controller.startedSessionLevel.value = 1;
    controller.totalSession["Emotion"] = 2;

    final observer = FakeNavigatorObserver();
    await tester.pumpWidget(GetMaterialApp(
      navigatorObservers: [observer],
      getPages: [
        GetPage(name: RoutesName.testCompletion, page: () => const SizedBox()),
        GetPage(name: RoutesName.testDashboardScreen, page: () => const SizedBox()),
      ],
      home: const SizedBox(),
    ));

    await controller.checkButtonActivity();
    await tester.pump(const Duration(seconds: 3)); // Simulate time passage

    expect(observer.navigatedRoutes.contains(RoutesName.testCompletion), isTrue);
  });
}
