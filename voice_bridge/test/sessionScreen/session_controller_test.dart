import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_bridge/screens/sessionScreen/controllers/session_controller.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';
import '../testScreen/check_button_activity_test.dart';

class FakeErrorAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) {
    throw Exception('Simulated loadString failure');
  }

  @override
  Future<ByteData> load(String key) {
    throw UnimplementedError(); // not used in this test
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });
  testWidgets(
      'goToNextLesson shows sessionCompletion if last lesson and showCompletionScreen false',
      (tester) async {
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
        GetPage(
            name: RoutesName.sessionCompletion, page: () => const SizedBox()),
        GetPage(name: RoutesName.sessionView, page: () => const SizedBox()),
      ],
      home: const SizedBox(),
    ));

    await controller.goToNextLesson();
    await tester.pumpAndSettle();

    expect(controller.showCompletionScreen.value, isTrue);
    expect(observer.navigatedRoutes, contains(RoutesName.sessionCompletion));
  });

  test(
      'goToNextLesson restarts or progresses to next session when showCompletionScreen is true',
      () async {
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

  testWidgets('startSession navigates to balloonBlast for "Fruits Ninja"',
      (tester) async {
    final controller = SessionController();
    Get.put(controller);

    final observer = FakeNavigatorObserver();

    await tester.pumpWidget(GetMaterialApp(
      navigatorObservers: [observer],
      getPages: [
        GetPage(name: RoutesName.balloonBlast, page: () => const SizedBox()),
      ],
      home: const SizedBox(),
    ));

    await controller.startSession("Fruits Ninja");
    await tester.pumpAndSettle();

    expect(observer.navigatedRoutes, contains(RoutesName.balloonBlast));
  });

  testWidgets('startSession handles JSON load error gracefully',
      (tester) async {
    final controller = SessionController(bundle: FakeErrorAssetBundle());
    Get.put(controller);

    controller.currentSessionLevel['Emotion'] = 1;

    await tester
        .pumpWidget(GetMaterialApp(home: Scaffold(body: Text('Testing'))));

    await controller.startSession('Emotion');

    // Assert it didn't crash or assign session
    expect(controller.currentSession.value, isNull);
  });

  test('loadAllSessionLevel sets current and total session levels for all categories', () async {
    final controller = SessionController(bundle: FakeErrorAssetBundle());
    await controller.loadAllSessionLevel();

    expect(controller.currentSessionLevel.keys, containsAll(["Emotion", "Family", "Living Skill", "Study"]));
    expect(controller.totalSession.values, everyElement(isA<int>()));
  });

  test('loadAllSessionLevel sets current and total session levels', () async {
    final controller = SessionController(bundle: FakeErrorAssetBundle());
    SharedPreferences.setMockInitialValues({
      'session_Emotion': 2,
      'session_Family': 3,
      'session_Living Skill': 1,
      'session_Study': 4,
    });

    await controller.loadAllSessionLevel();

    expect(controller.currentSessionLevel["Emotion"], equals(2));
    expect(controller.currentSessionLevel["Family"], equals(3));
    expect(controller.currentSessionLevel["Living Skill"], equals(1));
    expect(controller.currentSessionLevel["Study"], equals(4));

    // totalSession would be 0 due to FakeErrorAssetBundle, but at least non-null
    expect(controller.totalSession.containsKey("Emotion"), isTrue);
  });


  test('saveSession stores session level in prefs and updates controller', () async {
    SharedPreferences.setMockInitialValues({}); // Clean start
    final controller = SessionController();

    await controller.saveSession("Emotion", 5);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt('session_Emotion'), equals(5));
    expect(controller.currentSessionLevel["Emotion"], equals(5));
  });


}
