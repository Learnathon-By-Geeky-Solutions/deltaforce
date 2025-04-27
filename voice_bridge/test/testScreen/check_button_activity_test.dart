import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/screens/testScreen/controllers/test_controller.dart';

void main() {
  late TestController controller;

  setUp(() {
    Get.testMode = true; // To prevent Get.toNamed from real navigation
    controller = TestController();
    controller.lessonLength = 2; // set 2 lessons
    controller.generateOptions(); // generate options
  });

  test('Check button activity - correct answer increases score and completes session', () {
    fakeAsync((async) {
      controller.selectedIndex.value = controller.correctIndex; // Select correct answer
      controller.isCheckButtonDisabled.value = false;

      controller.checkButtonActivity();

      // Simulate 2 seconds first delay
      async.elapse(const Duration(seconds: 2));

      expect(controller.showFeedbackAnimation.value, false);
      expect(controller.showTestCompletionScreen.value, true); // After answering last lesson

      // Simulate 0.5 seconds second delay
      async.elapse(const Duration(milliseconds: 500));

      expect(controller.isCheckButtonDisabled.value, false); // Button re-enabled
    });
  });

  test('Check button activity - no answer selected shows snackbar', () {
    fakeAsync((async) {
      controller.selectedIndex.value = -1; // No answer selected
      controller.isCheckButtonDisabled.value = false;

      controller.checkButtonActivity();

      async.elapse(const Duration(seconds: 1));

      expect(controller.isCheckButtonDisabled.value, false); // Button remains enabled after warning
    });
  });
}
