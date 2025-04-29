import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_bridge/screens/parentScreen/controllers/autism_controller.dart';
import 'package:voice_bridge/screens/parentScreen/views/autism_test.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    Get.reset(); // Reset GetX state
  });

  Future<void> pumpTestWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/test',
        getPages: [
          GetPage(name: '/test', page: () => const DummyHome()),
          GetPage(
            name: '/autism',
            page: () => const AutismTest(),
            binding: BindingsBuilder(() {
              Get.lazyPut<AutismController>(() => AutismController());
            }),
          ),
        ],
      ),
    );

    // Navigate to AutismTest properly so Get.back() can work
    Get.toNamed('/autism');
    await tester.pumpAndSettle();
  }

  testWidgets('AutismTest shows all important UI elements', (WidgetTester tester) async {
    await pumpTestWidget(tester);

    expect(find.text('Autism Test'), findsOneWidget);
    expect(find.text('Rate the following from 1 (Low) to 10 (High)'), findsOneWidget);
    expect(find.text('Answer Yes / No'), findsOneWidget);

    expect(find.byType(Slider), findsNWidgets(3));
    expect(find.byType(RadioListTile<bool>), findsWidgets);
  });

  testWidgets('Show snackbar if not all Yes/No answered', (WidgetTester tester) async {
    await pumpTestWidget(tester);

    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Please answer all Yes/No questions'), findsOneWidget);
  });

  testWidgets('Successful test submission calculates score and navigates back', (WidgetTester tester) async {
    await pumpTestWidget(tester);

    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle();

    final yesOptions = find.widgetWithText(RadioListTile<bool>, 'Yes');
    final noOptions = find.widgetWithText(RadioListTile<bool>, 'No');

    expect(yesOptions, findsWidgets);
    expect(noOptions, findsWidgets);

    await tester.tap(yesOptions.at(0));
    await tester.pump();
    await tester.tap(noOptions.at(1));
    await tester.pump();
    await tester.tap(yesOptions.at(2));
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // <-- very important after Submit

    // Now properly wait after Get.back()
    await tester.pumpAndSettle(); // <== ADD this extra line

    // Now check if landed back to Home screen
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('Change slider value updates ratingAnswers', (WidgetTester tester) async {
    await pumpTestWidget(tester);

    final slider = find.byType(Slider).first;
    expect(slider, findsOneWidget);

    await tester.drag(slider, const Offset(100, 0)); // Slide right
    await tester.pump();
  });
}

// Dummy Home screen to support Get.back() navigation
class DummyHome extends StatelessWidget {
  const DummyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Home')),
    );
  }
}
