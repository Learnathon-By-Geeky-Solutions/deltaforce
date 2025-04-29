import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_bridge/screens/sessionScreen/controllers/session_controller.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';

import '../testScreen/check_button_activity_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });
  testWidgets('goToNextLesson shows sessionCompletion if last lesson and showCompletionScreen false', (tester) async {
    final controller = SessionController();
    Get.put(controller);

    controller.lessonLength = 1;
    controller.currentLessonIndex.value = 0;
    controller.showCompletionScreen.value = false;
    controller.currentCategory = "Emotion";
    controller.currentSessionLevel["Emotion"] = 1;
    controller.totalSession["Emotion"] = 2;

    final observer = FakeNavigatorObserver();

    await tester.pumpWidget(GetMaterialApp(
      navigatorObservers: [observer],
      getPages: [
        GetPage(name: RoutesName.sessionCompletion, page: () => const SizedBox()),
        GetPage(name: RoutesName.sessionView, page: () => const SizedBox()),
      ],
      home: const SizedBox(),
    ));

    await controller.goToNextLesson();
    await tester.pumpAndSettle();

    expect(controller.showCompletionScreen.value, isTrue);
    expect(observer.navigatedRoutes, contains(RoutesName.sessionCompletion));
  });

  test('goToNextLesson restarts or progresses to next session when showCompletionScreen is true', () async {
    final controller = SessionController();
    Get.put(controller);

    controller.lessonLength = 1;
    controller.currentLessonIndex.value = 0;
    controller.showCompletionScreen.value = true;
    controller.currentCategory = "Emotion";
    controller.currentSessionLevel["Emotion"] = 1;
    controller.totalSession["Emotion"] = 1;

    await controller.goToNextLesson();

    expect(controller.showCompletionScreen.value, isFalse);
    expect(controller.currentSessionLevel["Emotion"], equals(1));
  });

  test('goToNextLesson increments lesson if not last lesson', () async {
    final controller = SessionController();
    Get.put(controller);

    controller.lessonLength = 5;
    controller.currentLessonIndex.value = 2;

    await controller.goToNextLesson();

    expect(controller.currentLessonIndex.value, 3);
  });
}
