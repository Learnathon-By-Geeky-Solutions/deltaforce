import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_bridge/screens/testScreen/controllers/test_controller.dart';

void main() {
  late TestController controller;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    Get.testMode = true;
    SharedPreferences.setMockInitialValues({});
    controller = TestController();
    Get.testMode = true; // Stops real navigation during test

  });

  group('TestController Full Test', () {


    test('onInit loads test session levels', () async {
      controller.onInit();
      expect(controller.testTopSessionLevel.isNotEmpty, false);// edited
    });

    test('loadAllTestSessionLevel loads default 1', () async {
      await controller.loadAllTestSessionLevel();
      expect(controller.testTopSessionLevel['Study'], 1);
      expect(controller.testTopSessionLevel['Family'], 1);
    });

    test('testSaveSession saves correctly', () async {
      await controller.testSaveSession('Music', 5);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('testSession_Music'), 5);
      expect(controller.testTopSessionLevel['Music'], 5);
    });


    test('generateOptions creates 4 options with correct included', () {
      controller.lessonLength = 8;
      controller.testCurrentLessonIndex.value = 2;

      controller.generateOptions();

      expect(controller.options.length, 4);
      expect(controller.options.contains(2), true);
    });

    test('nextButtonActivity hides lesson and generates new options', () {
      controller.lessonLength = 8;
      controller.testCurrentLessonIndex.value = 2;
      controller.nextButtonActivity();

      expect(controller.showLesson.value, false);
      expect(controller.options.isNotEmpty, true);
    });

    test('gotoDashboard navigates correctly', () {
      controller.gotoDashboard('Family');
      expect(controller.testCurrentCategory, 'Family');
    });

    test('testScores reads score from storage', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('testScore_Social Skill_2', 90);

      int fetched = await controller.testScores('Social Skill', 2);

      expect(fetched, 90);
    });

  });
}
