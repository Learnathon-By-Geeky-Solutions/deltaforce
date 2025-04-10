
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/screens/testScreen/views/testLearningView.dart';
import 'package:voice_bridge/screens/testScreen/views/testQuestionView.dart';

import '../controllers/testController.dart';
import '../widgets/checkButton.dart';
import '../widgets/nextButton.dart';


class TestScreen extends StatelessWidget {
  final TestController controller = Get.find();

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