import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/Settings/UI/send_feed_back.dart';

Widget buildTestWidget() => const GetMaterialApp(home: SendFeedbackScreen());

void main() {
  testWidgets('renders UI components', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    expect(find.text('Send Feedback'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Submit Feedback'), findsOneWidget);
  });

  testWidgets('shows error snackbar on empty feedback', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.tap(find.text('Submit Feedback'));
    await tester.pump(); // Let snackbar animate in
    expect(find.text('Error'), findsOneWidget);
    expect(find.text('Please write some feedback first.'), findsOneWidget);

    // Ensure snackbar completes before teardown
    await tester.pump(const Duration(seconds: 4));
  });

  testWidgets('shows thank you snackbar on valid feedback', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.enterText(find.byType(TextField), 'Great app!');
    await tester.tap(find.text('Submit Feedback'));
    await tester.pump(); // Let snackbar animate in
    expect(find.text('Thank you!'), findsOneWidget);
    expect(find.text('Your feedback has been sent.'), findsOneWidget);

    // Ensure snackbar completes before teardown
    await tester.pump(const Duration(seconds: 4));
  });
}
