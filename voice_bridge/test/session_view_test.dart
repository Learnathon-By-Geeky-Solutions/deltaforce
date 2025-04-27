import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';
import 'package:voice_bridge/screens/base/controllers/base_controller.dart';
import 'package:voice_bridge/screens/base/views/base_view.dart';
import 'package:voice_bridge/screens/sessionScreen/controllers/session_controller.dart';
import 'package:voice_bridge/screens/sessionScreen/view_model/session_model.dart';
import 'package:voice_bridge/screens/sessionScreen/views/session_view.dart';

void main() {
  // Mock data for the test
  var mockSessionData = {
    'lessons': [
      {
        'lessonName': 'Lesson 1',
        'animationAsset': 'assets/animations/lesson1.lottie'
      },
      {
        'lessonName': 'Lesson 2',
        'animationAsset': 'assets/animations/lesson2.lottie'
      }
    ]
  };

  // Initialize necessary controllers for the test
  setUpAll(() {
    Get.put(SessionController());
    Get.put(BaseController());
  });

  testWidgets('SessionView displays session data and navigation works', (WidgetTester tester) async {
    // Prepare the mock session data
    var sessionController = Get.find<SessionController>();
    sessionController.currentSession.value = mockSessionData as Session?;
    sessionController.currentSessionLevel['Emotion'] = 1;
    sessionController.currentLessonIndex.value = 0;

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: RoutesName.sessionView,
        routes: {
          RoutesName.sessionView: (context) => SessionView(),
        },
        home: Scaffold(
          body: SessionView(),
        ),
      ),
    );

    // Wait for animations to load
    await tester.pumpAndSettle();

    // Check if the session level is displayed
    expect(find.text('Session: 1'), findsOneWidget);

    // Check if the lesson name is displayed
    expect(find.text('Lesson 1'), findsOneWidget);

    // Verify the "Next" button is present
    expect(find.text('Next'), findsOneWidget);

    // Tap the "Next" button and check if it progresses to the next lesson
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify the lesson name for the second lesson
    expect(find.text('Lesson 2'), findsOneWidget);

    // Verify the back button navigates to base view (Learn page)
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Check if we are navigating to the correct screen
    expect(find.byType(BaseView), findsOneWidget);
  });
}
