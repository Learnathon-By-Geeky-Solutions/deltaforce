import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_bridge/screens/testScreen/widgets/test_session_card.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
          (message) async {
        final String asset = utf8.decode(message?.buffer.asUint8List() ?? []);
        if (asset.contains('start.lottie')) {
          return ByteData.view(Uint8List.fromList(utf8.encode('{"animations": {"a": []}}')).buffer);
        }
        return null;
      },
    );
  });

  testWidgets('Shows correct star colors based on score', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TestSessionCard(
          index: 1,
          isUnlocked: true,
          isLastUnlocked: false,
          testScore: Future.value(85),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    final yellowStars = tester.widgetList<Icon>(find.byIcon(Icons.star)).where(
          (icon) => icon.color == Colors.yellowAccent,
    );

    expect(yellowStars.length, 2);
  });

  testWidgets('Shows fallback stars on score error', (WidgetTester tester) async {
    final fallbackScore = Future<int>.error(Exception('fail'))
        .catchError((_) => -1); // Use a valid fallback int

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TestSessionCard(
          index: 2,
          isUnlocked: true,
          isLastUnlocked: false,
          testScore: fallbackScore,
        ),
      ),
    ));

    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.star), findsNWidgets(3));
  });

  testWidgets('Shows nothing while waiting for score', (WidgetTester tester) async {
    final completer = Completer<int>();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TestSessionCard(
          index: 3,
          isUnlocked: true,
          isLastUnlocked: false,
          testScore: completer.future,
        ),
      ),
    ));

    expect(find.byIcon(Icons.star), findsNothing);
  });

  testWidgets('Shows DotLottie animation when lastUnlocked is true', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TestSessionCard(
          index: 4,
          isUnlocked: true,
          isLastUnlocked: true,
          testScore: Future.value(95),
        ),
      ),
    ));
    await tester.pumpAndSettle(const Duration(milliseconds: 300));

    expect(find.byType(DotLottieLoader), findsOneWidget);
  });

  testWidgets('Displays index with correct font size', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TestSessionCard(
          index: 9,
          isUnlocked: true,
          isLastUnlocked: false,
          testScore: Future.value(60),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    final text = tester.widget<Text>(find.text('9'));
    expect(text.style?.fontSize, 30);
  });
}