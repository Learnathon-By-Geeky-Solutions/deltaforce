import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_bridge/screens/testScreen/controllers/test_controller.dart';


void main() {
  late TestController testController;

  setUp(() {
    Get.testMode = true; // Important for navigation mocking
    SharedPreferences.setMockInitialValues({}); // Mock storage
    testController = TestController();
  });

  group('TestController', () {
    test('initial values are correct', () {
      expect(testController.testTopSessionLevel, {});
      expect(testController.testScore, {});
      expect(testController.testCurrentLessonIndex.value, 0);
      expect(testController.testCurrentCategory, '');
      expect(testController.settingsShowLesson.value, true);
      expect(testController.showLesson.value, true);
      expect(testController.selectedIndex.value, -1);
      expect(testController.showTestCompletionScreen.value, false);
      expect(testController.isAnswerCorrect.value, false);
      expect(testController.score.value, 0);
    });

    test('testSaveSession saves session correctly', () async {
      await testController.testSaveSession('Music', 3);

      final prefs = await SharedPreferences.getInstance();
      int? savedSession = prefs.getInt('testSession_Music');

      expect(savedSession, 3);
      expect(testController.testTopSessionLevel['Music'], 3);
    });

    test('generateOptions creates 4 options including correct answer', () async {
      testController.lessonLength = 10;
      testController.testCurrentLessonIndex.value = 2; // Correct answer index

      testController.generateOptions();

      expect(testController.options.length, 4);
      expect(testController.options.contains(2), true); // Must include correct
    });

    test('nextButtonActivity hides lesson and generates new options', () {
      testController.lessonLength = 10;
      testController.testCurrentLessonIndex.value = 1;

      testController.nextButtonActivity();

      expect(testController.showLesson.value, false);
      expect(testController.options.length, 4);
    });



    test('testScores fetches saved score', () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('testScore_Study_2', 85);

      int fetchedScore = await testController.testScores('Study', 2);

      expect(fetchedScore, 85);
    });

    // You can add more specific tests for checkButtonActivity, etc.
  });
}
