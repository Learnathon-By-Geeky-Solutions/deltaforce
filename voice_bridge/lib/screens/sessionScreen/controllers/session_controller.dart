import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../resources/routes/routes_name.dart';
import '../view_model/session_model.dart';

class SessionController extends GetxController {
  var currentSessionLevel = <String, int>{}.obs;
  var totalSession =  <String, int>{}.obs;
  var currentLessonIndex = 0.obs;
  var currentCategory = '';
  int lessonLength = 0;
  @override
  void onInit() {
    super.onInit();
    loadAllSessionLevel(); // Load session data when the app starts
  }
/// Get total session under a category
  Future<int> getTotalSessions(String category) async {
    try {
      String jsonString = await rootBundle.loadString("lib/resources/assets/$category/sessions/totalSession.json");
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      return jsonData["total_session"];
    } catch (e) {
      if (kDebugMode) {
        print("Error loading session index: $e");
      }
      return 0;
    }
  }


  /// Load session progress from SharedPreferences
  Future<void> loadAllSessionLevel() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> categories = ["Emotion","Family","Living Skill","Music","Profession","Psychological","Social Skill","Study"]; // Add all categories

    for (var category in categories) {
      int sessionLevel = prefs.getInt('session_$category') ?? 1;// Default sessionLevel is 1
      var totalSessions = await getTotalSessions(category);
      currentSessionLevel[category] = sessionLevel;
      totalSession[category] = totalSessions;
    }

    // await fetchSessionsFromFirebase(); // Fetch sessionLevel progress from Firebase
  }

  /// Save session progress locally
  Future<void> saveSession(String category, int sessionNumber) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('session_$category', sessionNumber);
    currentSessionLevel[category] = sessionNumber;

  }
  var currentSession = Rxn<Session>(); // Holds the current session data

  /// Load a session from assets
  Future<void> startSession(String category) async {
    if(category == "Fruits Ninja"){
      Get.toNamed(RoutesName.balloonBlast);
    }
    else{
     currentLessonIndex.value = 0;
    currentCategory = category;
    int sessionLevel = currentSessionLevel[category] ?? 1;
    try {
      // Load JSON file
      String jsonString = await rootBundle.loadString("lib/resources/assets/$category/sessions/sessions$sessionLevel.json");
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Convert JSON to Session object and update state
      currentSession.value = Session.fromJson(jsonData);
      lessonLength = currentSession.value!.lessons.length;
      // 'sessionLevel': currentSessionLevel[category], //for next line
      Get.toNamed(RoutesName.sessionView, arguments: {'category': category, 'currentSession' : currentSession});
    } catch (e) {
      if (kDebugMode) {
        print("Error loading session: $e");
      }

    }
    }
  }

  var showCompletionScreen = false.obs;
  Future<void> goToNextLesson() async {
    if(currentLessonIndex.value == lessonLength - 1){

        if(showCompletionScreen.value == false){
          showCompletionScreen.value = true;
          Get.toNamed(RoutesName.sessionCompletion);

        }else{
          showCompletionScreen.value = false;
          String category = currentCategory;
          var sessionLevel = currentSessionLevel[category];
          var totalSessions = totalSession[category];

          if(totalSessions! > sessionLevel!){
            await saveSession(category, sessionLevel + 1);
            startSession(category);
          }
          else{
            currentSessionLevel[category] = 1;
            startSession(category);
          }
        }

    }
    else if (currentLessonIndex.value < lessonLength - 1) {
      currentLessonIndex.value++;
    }
  }
}
