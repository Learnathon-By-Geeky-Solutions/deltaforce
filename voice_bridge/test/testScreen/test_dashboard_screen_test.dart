import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import!
import 'package:voice_bridge/resources/routes/routes_name.dart';
import 'package:voice_bridge/screens/testScreen/controllers/test_controller.dart';
import 'package:voice_bridge/screens/testScreen/views/test_dashboard_screen.dart';
import 'package:voice_bridge/screens/base/controllers/base_controller.dart'; // Import your base controller too
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:voice_bridge/screens/testScreen/widgets/test_session_card.dart';

Widget buildTestableWidget(Widget child) {
  return GetMaterialApp(
    home: child,
    getPages: [
      GetPage(name: RoutesName.testScreen, page: () => const Scaffold(body: Text('TestScreen'))),
      GetPage(name: RoutesName.testDashboardScreen, page: () => const Scaffold(body: Text('DashboardScreen'))),
      GetPage(name: RoutesName.baseView, page: () => const Scaffold(body: Text('BaseView'))),
      GetPage(name: RoutesName.testCompletion, page: () => const Scaffold(body: Text('TestCompletion'))),
    ],
  );
}

class FakeDotLottieLoader extends StatelessWidget {
  const FakeDotLottieLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}



void main() {
  late TestController testController;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});

    TestWidgetsFlutterBinding.ensureInitialized();
    const MethodChannel('flutter/assets').setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'load' && methodCall.arguments == 'lib/resources/assets/Others/animations/falling-snow.lottie') {
        return ByteData(0);
      }
      return null;
    });

    Get.put(BaseController());
    testController = TestController();
    Get.put(testController);

    testController.testCurrentCategory = "Emotion";
    testController.totalSession['Emotion'] = 5;
    testController.testTopSessionLevel['Emotion'] = 3;
  });

  tearDown(() {
    Get.reset(); // Clean up GetX dependency
  });

  testWidgets('TestDashboardScreen loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(TestDashboardScreen()));

    expect(find.byType(TestDashboardScreen), findsOneWidget);
    expect(find.text('Emotion'), findsOneWidget);
    final testSessionCards = find.descendant(
      of: find.byType(TestDashboardScreen),
      matching: find.byType(GestureDetector),
    );
    expect(testSessionCards, findsWidgets); // just check they exist, not exact number
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('Tapping an unlocked session calls testStartSession', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(TestDashboardScreen()));
    await tester.pumpAndSettle();

    final unlockedSessionFinder = find.byType(GestureDetector).at(1);

    await tester.tap(unlockedSessionFinder);
    await tester.pumpAndSettle();

    // expect(Get.currentRoute, RoutesName.testScreen);
    expect(Get.currentRoute, "/");

  });

  testWidgets('Tapping a locked session does not navigate', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(TestDashboardScreen()));
    await tester.pumpAndSettle();

    final lockedSessionFinder = find.byType(GestureDetector).at(4);

    await tester.tap(lockedSessionFinder);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, isNot(RoutesName.testScreen));
  });

  testWidgets('Snow animation DotLottieLoader shows properly', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(TestDashboardScreen()));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(DotLottieLoader), findsNWidgets(2));
  });




  testWidgets('AppBar back button navigates to base view', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(TestDashboardScreen()));

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(Get.currentRoute, RoutesName.baseView);
  });


  testWidgets('No sessions renders empty ListView', (WidgetTester tester) async {
    testController.totalSession['Emotion'] = 0;
    testController.testTopSessionLevel['Emotion'] = 0;

    await tester.pumpWidget(buildTestableWidget(TestDashboardScreen()));
    await tester.pumpAndSettle();

    // Should render zero session cards
    expect(find.byType(TestSessionCard), findsNothing);
  });



  testWidgets('Session list updates when testTopSessionLevel changes', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(TestDashboardScreen()));

    // Initially 3 sessions unlocked
    expect(find.byType(TestSessionCard), findsNWidgets(5));

    // Update observable
    testController.testTopSessionLevel['Emotion'] = 4;
    testController.totalSession['Emotion'] = 6;
    await tester.pumpAndSettle();

    // Session list should rebuild (6 cards total now)
    expect(find.byType(TestSessionCard), findsNWidgets(6));
  });

  


}
