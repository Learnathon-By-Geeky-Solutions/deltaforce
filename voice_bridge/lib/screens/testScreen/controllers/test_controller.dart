import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resources/routes/routes_name.dart';
import '../../sessionScreen/controllers/session_controller.dart';
import '../../sessionScreen/view_model/session_model.dart';

class TestController extends SessionController {
  var testTopSessionLevel = <String, int>{}.obs;
  var testScore = <String, int>{}.obs;
  var testCurrentLessonIndex = 0.obs;
  var testCurrentCategory = '';
  var testCurrentSession = Rxn<Session>(); // Holds the current session data

  var settingsShowLesson = true.obs;
  var showLesson = true.obs;

  var selectedIndex = (-1).obs;
  var showTestCompletionScreen = false.obs;

  var isAnswerCorrect = false.obs;
  var showFeedbackAnimation = false.obs;

  int correctIndex = 0;
  RxList<int> options = <int>[].obs;

  var isCheckButtonDisabled = false.obs;
  var score = 0.obs;
  var result = 0.obs;
  var startedSessionLevel = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllTestSessionLevel();
  }

  Future<void> loadAllTestSessionLevel() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> categories = [
      "Emotion",
      "Family",
      "Living Skill",
      "Study"
    ]; // Add all categories// Add all categories

    for (var category in categories) {
      int testSessionLevel = prefs.getInt('testSession_$category') ??
          1; // Default sessionLevel is 1
      testTopSessionLevel[category] = testSessionLevel;
    }
  }

  Future<void> testSaveSession(String category, int testSessionNumber) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('testSession_$category', testSessionNumber);
    testTopSessionLevel[category] = testSessionNumber;
  }

  /// Load a session from assets
  Future<void> testStartSession(String category, int testSessionLevel) async {
    isCheckButtonDisabled.value = false;
    startedSessionLevel.value = testSessionLevel;
    score.value = 0;
    testCurrentLessonIndex.value = 0;
    testCurrentCategory = category;
    selectedIndex.value = -1;
    try {
      // Load JSON file
      String jsonString = await rootBundle.loadString(
          "lib/resources/assets/$category/sessions/sessions$testSessionLevel.json");
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Convert JSON to Session object and update state
      testCurrentSession.value = Session.fromJson(jsonData);
      lessonLength = testCurrentSession.value!.lessons.length;

      if (!settingsShowLesson.value) {
        showLesson.value = false;
        generateOptions(); // So UI gets data before building
      }
      Get.toNamed(RoutesName.testScreen);
    } catch (e) {
      if (kDebugMode) {
        print("Error loading session: $e");
      }
    }
  }

  Future<void> checkButtonActivity() async {
    if (isCheckButtonDisabled.value) return;
    isCheckButtonDisabled.value = true;

    if (selectedIndex.value < 0) {
      _showSelectOptionError();
      return;
    }

    if (testCurrentLessonIndex.value == lessonLength - 1) {
      await _handleFinalLesson();
    } else {
      await _handleIntermediateLesson();
    }
  }


  void _showSelectOptionError() {
    isCheckButtonDisabled.value = false;
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      const SnackBar(
        content: Text("Select Correct Option"),
        backgroundColor: Color(0xFFF44336),
      ),
    );
  }

  Future<void> _handleFinalLesson() async {
    if (!showTestCompletionScreen.value) {
      await _showFinalFeedbackAndResult();
    } else {
      await _processPostTestSession();
    }

    if (kDebugMode) {
      print("con result $result");
      print('session change lesson index = $testCurrentLessonIndex lessonLength = $lessonLength');
    }
  }

  Future<void> _showFinalFeedbackAndResult() async {
    showFeedbackAnimation.value = true;
    isAnswerCorrect.value = (selectedIndex.value == correctIndex);
    if (isAnswerCorrect.value) score.value++;

    await Future.delayed(const Duration(seconds: 2));
    showFeedbackAnimation.value = false;
    showTestCompletionScreen.value = true;

    await Future.delayed(const Duration(milliseconds: 500));
    result.value = ((score * 100) / lessonLength).toInt();
    isCheckButtonDisabled.value = false;

    Get.toNamed(RoutesName.testCompletion);
  }

  Future<void> _processPostTestSession() async {
    showTestCompletionScreen.value = false;
    showLesson.value = true;

    final category = testCurrentCategory;
    final topSessionLevel = testTopSessionLevel[category];
    final currentSessionLevel = startedSessionLevel.value;
    final totalSessions = totalSession[category];

    if (topSessionLevel == currentSessionLevel && result >= 80) {
      if (topSessionLevel! < totalSessions!) {
        await testSaveSession(category, topSessionLevel + 1);
        testTopSessionLevel[category] = topSessionLevel + 1;
      }
    }

    final prefs = await SharedPreferences.getInstance();
    final key = 'testScore_${category}_$currentSessionLevel';
    final savedResult = prefs.getInt(key) ?? 0;

    if (result > savedResult) {
      await prefs.setInt(key, result.value);
    }

    Get.toNamed(RoutesName.testDashboardScreen);
  }

  Future<void> _handleIntermediateLesson() async {
    showFeedbackAnimation.value = true;
    isAnswerCorrect.value = (selectedIndex.value == correctIndex);
    if (isAnswerCorrect.value) score.value++;

    await Future.delayed(const Duration(seconds: 2));
    showFeedbackAnimation.value = false;

    await Future.delayed(const Duration(milliseconds: 500));
    testCurrentLessonIndex.value++;
    selectedIndex.value = -1;
    isCheckButtonDisabled.value = false;
    showLesson.value = settingsShowLesson.value;

    if (!settingsShowLesson.value) generateOptions();
  }


  void nextButtonActivity() {
    showLesson.value = false;
    generateOptions();
  }

  void generateOptions() {
    selectedIndex.value = -1;
    Random random = Random();
    int correctOptionIndex = testCurrentLessonIndex.value;
    correctIndex = correctOptionIndex;

    Set<int> selectedOptionsIndex = {correctOptionIndex};

    while (selectedOptionsIndex.length < 4) {
      selectedOptionsIndex.add(random.nextInt(lessonLength));
    }
    options.value = selectedOptionsIndex.toList();
    options.shuffle(); // Shuffle for random order
  }

  void gotoDashboard(String category) {
    testCurrentCategory = category;
    Get.toNamed(RoutesName.testDashboardScreen);
    if (kDebugMode) {
      print("goto dashboard");
    }
  }

  Future<int> testScores(category, currentSessionLevel) async {
    final prefs = await SharedPreferences.getInstance();
    int testScores =
        prefs.getInt('testScore_${category}_$currentSessionLevel') ??
            0; // Default sessionLevel is 1
    return testScores;
  }
}
