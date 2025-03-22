import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../resources/routes/routesName.dart';
import '../view_model/sessionModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class SessionController extends GetxController {
  var currentSessionLevel = <String, int>{}.obs;
  var totalSession =  <String, int>{}.obs;
  var currentLessonIndex = 0.obs;
  var currentCategory = '';
  int lessonLength = 0;

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final String userId = "user_id"; // Replace with actual user ID from FirebaseAuth

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

    // if (sessionNumber % 5 == 0) {
    //   updateSessionInFirebase(category, sessionNumber); // Sync every 5 sessions
    // }
  }

  /// Fetch session progress from Firebase when logging in on a new device
  // Future<void> fetchSessionsFromFirebase() async {
  //   var doc = await _firestore.collection('userProgress').doc(userId).get();
  //
  //   if (doc.exists) {
  //     Map<String, dynamic> data = doc.data()!;
  //     data.forEach((category, session) {
  //       currentSessions[category] = session; // Update local session values
  //     });
  //
  //     // Save fetched sessions to SharedPreferences
  //     final prefs = await SharedPreferences.getInstance();
  //     data.forEach((category, session) {
  //       prefs.setInt('session_$category', session);
  //     });
  //   }
  // }

  /// Update Firebase with the latest session progress
  // Future<void> updateSessionInFirebase(String category, int sessionNumber) async {
  //   await _firestore.collection('userProgress').doc(userId).set(
  //     {category: sessionNumber}, SetOptions(merge: true),
  //   );
  // }

  /// Start the session for the selected category
  // void startSession(String category) {
  //   int session = currentSessionLevel[category] ?? 1;
  //
  //
  //   Get.toNamed(RoutesName.sessionPage, arguments: {'category': category, 'session': sessionLevel});
  // }

  var currentSession = Rxn<Session>(); // Holds the current session data

  /// Load a session from assets
  Future<void> startSession(String category) async {
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



  // var currentLessonIndex = 0.obs;

  // Move to next lesson in the session
  // void goToNextSesson() {
  //   if (currentSessionLevel.value != null && currentLessonIndex.value < lessonLength - 1) {
  //     currentLessonIndex.value++;
  //   }
  // }
  //
  // // Move to previous lesson in the session
  // void goToPreviousSession() {
  //   if (currentLessonIndex.value > 0) {
  //     currentLessonIndex.value--;
  //   }
  // }


  var showCompletionScreen = false.obs;
  Future<void> goToNextLesson() async {
    if(currentLessonIndex.value == lessonLength - 1){

        if(showCompletionScreen == false){
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
        // startSession(category);

        // print('session change lesson index = $currentLessonIndex lessonLength = $lessonLength');
        // print('category = $category session level = $sessionLevel total session = $totalSessions');

    }
    else if (currentLessonIndex.value < lessonLength - 1) {
      currentLessonIndex.value++;
      // print('lesson index = $currentLessonIndex lessonLength = $lessonLength');
    }
  }

  // Move to previous lesson in the session
  // void goToPreviousLesson() {
  //   if (currentLessonIndex.value > 0) {
  //     currentLessonIndex.value--;
  //     print('lesson index = $currentLessonIndex lessonLength = $lessonLength');
  //   }
  // }
}
