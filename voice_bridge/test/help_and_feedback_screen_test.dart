import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/Settings/UI/help_feedback.dart';
import 'package:voice_bridge/features/Settings/UI/faq_screen.dart';
import 'package:voice_bridge/features/Settings/UI/send_feed_back.dart';
import 'package:voice_bridge/features/Settings/UI/contact_support_screen.dart';

void main() {
  Widget buildTestWidget() => const GetMaterialApp(home: HelpAndFeedbackScreen());

  testWidgets('renders all UI elements correctly', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    expect(find.text('Help & Feedback'), findsOneWidget);
    expect(find.text('How can we assist you today?'), findsOneWidget);
    expect(find.text('FAQs'), findsOneWidget);
    expect(find.text('Send Feedback'), findsOneWidget);
    expect(find.text('Contact Support'), findsOneWidget);
  });

  testWidgets('navigates to FAQs screen on tap', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    await tester.tap(find.text('FAQs'));
    await tester.pumpAndSettle();

    expect(find.byType(FAQsScreen), findsOneWidget);
  });

  testWidgets('navigates to Send Feedback screen on tap', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    await tester.tap(find.text('Send Feedback'));
    await tester.pumpAndSettle();

    expect(find.byType(SendFeedbackScreen), findsOneWidget);
  });

  testWidgets('navigates to Contact Support screen on tap', (tester) async {
    await tester.pumpWidget(buildTestWidget());

    await tester.tap(find.text('Contact Support'));
    await tester.pumpAndSettle();

    expect(find.byType(ContactSupportScreen), findsOneWidget);
  });
}
