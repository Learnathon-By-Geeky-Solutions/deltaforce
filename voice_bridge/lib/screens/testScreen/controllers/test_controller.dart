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
    if (isCheckButtonDisabled.value) return; // Block when animation is showing
    isCheckButtonDisabled.value = true; // Disable button during processing

    if (testCurrentLessonIndex.value == lessonLength - 1) {
      if (showTestCompletionScreen.value == false) {
        if (selectedIndex.value < 0) {
          isCheckButtonDisabled.value = false;
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(
              content: Text("Select Correct Option"),
              backgroundColor: Color(0xFFF44336),
            ),
          );


        } else {
          showFeedbackAnimation.value = true;
          isAnswerCorrect.value = (selectedIndex.value == correctIndex);
          isAnswerCorrect.value ? score.value++ : score.value; //count mark

          Future.delayed(const Duration(seconds: 2), () {
            showFeedbackAnimation.value = false;
            showTestCompletionScreen.value = true;
            Future.delayed(const Duration(milliseconds: 500), () {
              isCheckButtonDisabled.value = false; // Enable button again

              result.value = ((score * 100) / lessonLength).toInt();

              Get.toNamed(RoutesName.testCompletion);
            });
          });
        }
      } else {
        showTestCompletionScreen.value = false;
        String category = testCurrentCategory;
        var topSessionLevel = testTopSessionLevel[category];
        var currentSessionLevel = startedSessionLevel.value;
        var totalSessions = totalSession[category];
        showLesson.value = true; //for next lesson showing

        if (topSessionLevel == currentSessionLevel) {
          if (result >= 80) {
            if (topSessionLevel! < totalSessions!) {
              await testSaveSession(category, topSessionLevel + 1);
              testTopSessionLevel[category] = topSessionLevel +
                  1; // this line change  only// already change in savesession
            }
          }
        }

        //fetch score
        final prefs = await SharedPreferences.getInstance();
        int savedResult =
            prefs.getInt('testScore_${category}_$currentSessionLevel') ??
                0; // Default sessionLevel is 1

        if (result > savedResult) {
          await prefs.setInt('testScore_${category}_$currentSessionLevel',
              result.value); //write in share pref
        }
        Get.toNamed(RoutesName.testDashboardScreen);
      }
      print("con result $result");
      if (kDebugMode) {
        print(
            'session change lesson index = $testCurrentLessonIndex lessonLength = $lessonLength');
      }
    } else if (testCurrentLessonIndex.value < lessonLength - 1) {
      if (selectedIndex.value < 0) {
        isCheckButtonDisabled.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Select Correct Option"),
            backgroundColor: Color(0xFFF44336),
          ),
        );


      } else {
        showFeedbackAnimation.value = true;
        isAnswerCorrect.value = (selectedIndex.value == correctIndex);
        isAnswerCorrect.value ? score.value++ : score.value; //count mark

        Future.delayed(const Duration(seconds: 2), () {
          showFeedbackAnimation.value = false;

          Future.delayed(const Duration(milliseconds: 500), () {
            testCurrentLessonIndex.value++;
            selectedIndex.value = -1;
            isCheckButtonDisabled.value = false; // Enable button again

            if (settingsShowLesson.value) {
              showLesson.value = true;
            } else {
              showLesson.value = false;
              generateOptions();
            }
          });
        });
      }
    }
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
