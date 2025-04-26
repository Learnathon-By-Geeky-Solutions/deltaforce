
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/screens/testScreen/views/test_learning_view.dart';
import 'package:voice_bridge/screens/testScreen/views/test_question_view.dart';

import '../controllers/test_controller.dart';
import '../widgets/check_button.dart';
import '../widgets/next_button.dart';


class TestScreen extends StatelessWidget {
  final TestController controller = Get.find();

  TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // bool showingLesson = (controller.showLesson.value && controller.settingsShowLesson.value);
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 21, child: Obx(() => (controller.showLesson.value && controller.settingsShowLesson.value) ? TestLearningView() : TestQuestionView())),
          Expanded(flex: 3, child: Obx(() => (controller.showLesson.value && controller.settingsShowLesson.value) ?  NextButton() : CheckButton()))
        ],
      ),
    );
  }
}