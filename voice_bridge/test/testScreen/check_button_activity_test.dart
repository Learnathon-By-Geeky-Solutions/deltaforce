import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';
import 'package:voice_bridge/screens/testScreen/controllers/test_controller.dart';

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

  setUp(() async {
    Get.testMode = true;
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    Get.reset();
  });


  testWidgets('Should do nothing if button is already disabled', (tester) async {
    final controller = TestController();
    controller.isCheckButtonDisabled.value = true;

    // No need to pump anything because nothing should happen
    await controller.checkButtonActivity();
  });

  testWidgets('Should show snackbar if no option is selected on last question', (tester) async {
    final controller = TestController();
    Get.put(controller);

    controller.lessonLength = 1;
    controller.testCurrentLessonIndex.value = 0;
    controller.selectedIndex.value = -1;

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(body: const Text('placeholder')),
      ),
    );

    await controller.checkButtonActivity();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.textContaining("Select Correct Option"), findsOneWidget);
  });

  testWidgets('Should handle already completed test and go to dashboard', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final controller = TestController();
    Get.put(controller);

    controller.lessonLength = 1;
    controller.testCurrentLessonIndex.value = 0;
    controller.selectedIndex.value = 0;
    controller.correctIndex = 0;
    controller.result.value = 90;
    controller.showTestCompletionScreen.value = true;
    controller.testCurrentCategory = "Emotion";
    controller.testTopSessionLevel["Emotion"] = 1;
    controller.startedSessionLevel.value = 1;
    controller.totalSession["Emotion"] = 2;

    final observer = FakeNavigatorObserver();
    await tester.pumpWidget(GetMaterialApp(
      navigatorObservers: [observer],
      getPages: [
        GetPage(name: RoutesName.testDashboardScreen, page: () => const SizedBox()),
      ],
      home: const SizedBox(),
    ));

    await controller.checkButtonActivity();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    expect(observer.navigatedRoutes, contains(RoutesName.testDashboardScreen));
  });

  testWidgets('Should show snackbar if no option selected in mid-lesson', (tester) async {
    final controller = TestController();
    Get.put(controller);

    controller.lessonLength = 5;
    controller.testCurrentLessonIndex.value = 2;
    controller.selectedIndex.value = -1;

    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(body: const Text('placeholder')),
      ),
    );

    await controller.checkButtonActivity();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.textContaining("Select Correct Option"), findsOneWidget);
  });





  // testWidgets('checkButtonActivity triggers testCompletion when last lesson and answer is selected', (tester) async {
  //   SharedPreferences.setMockInitialValues({});
  //   final controller = TestController();
  //   Get.put(controller);
  //
  //   controller.lessonLength = 1;
  //   controller.testCurrentLessonIndex.value = 0;
  //   controller.selectedIndex.value = 0;
  //   controller.correctIndex = 0;
  //   controller.testCurrentCategory = "Emotion";
  //   controller.testTopSessionLevel["Emotion"] = 1;
  //   controller.startedSessionLevel.value = 1;
  //   controller.totalSession["Emotion"] = 2;
  //
  //   final observer = FakeNavigatorObserver();
  //   await tester.pumpWidget(GetMaterialApp(
  //     navigatorObservers: [observer],
  //     getPages: [
  //       GetPage(name: RoutesName.testCompletion, page: () => const SizedBox()),
  //       GetPage(name: RoutesName.testDashboardScreen, page: () => const SizedBox()),
  //     ],
  //     home: Scaffold(body: const Text('Test Screen')), // ✅ Give context to Get.context!
  //   ));
  //
  //   await controller.checkButtonActivity();
  //
  //   await tester.pump(const Duration(seconds: 3));
  //   await tester.pumpAndSettle();
  //
  //   expect(observer.navigatedRoutes.contains(RoutesName.testCompletion), isTrue);
  // });



  // testWidgets('Should go to next question if answer selected mid-lesson', (tester) async {
  //   final controller = TestController();
  //   Get.put(controller);
  //
  //   controller.lessonLength = 5;
  //   controller.testCurrentLessonIndex.value = 2;
  //   controller.selectedIndex.value = 1;
  //   controller.correctIndex = 1;
  //
  //   await tester.pumpWidget(
  //     GetMaterialApp(
  //       home: Scaffold(body: const Text('Question Screen')), // ✅ needed context
  //     ),
  //   );
  //
  //   await controller.checkButtonActivity();
  //
  //   await tester.pump(const Duration(seconds: 3));
  //   await tester.pumpAndSettle();
  //
  //   expect(controller.testCurrentLessonIndex.value, 3);
  //   expect(controller.selectedIndex.value, -1);
  // });
}
