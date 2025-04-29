import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/screens/testScreen/controllers/test_controller.dart';
import 'package:voice_bridge/screens/testScreen/views/test_completion_view.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
class TestControllerMock extends TestController {
  final VoidCallback onCalled;

  TestControllerMock(this.onCalled);

  @override
  Future<void> checkButtonActivity() async {
    onCalled();
  }
}

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
          (message) async {
        final String asset = utf8.decode(message?.buffer.asUint8List() ?? []);
        if (asset.contains('badge') || asset.contains('no-star')) {
          return ByteData.view(Uint8List.fromList(utf8.encode('{"animations": {"a": []}}')).buffer);
        }
        return null;
      },
    );
  });


  tearDown(() {
    Get.reset();
  });

  testWidgets('Displays correct message and animation based on result', (tester) async {
    final controller = TestController();
    Get.put(controller);

    controller.result.value = 85;

    await tester.pumpWidget(const GetMaterialApp(home: TestCompletionView()));
    await tester.pumpAndSettle();

    expect(find.text('Great job!'), findsOneWidget);
    expect(find.byType(DotLottieLoader), findsOneWidget);
  });

  testWidgets('Displays "Excellent!" when result is 90 or more', (tester) async {
    final controller = TestController();
    Get.put(controller);

    controller.result.value = 95;

    await tester.pumpWidget(const GetMaterialApp(home: TestCompletionView()));
    await tester.pumpAndSettle();

    expect(find.text('Excellent!'), findsOneWidget);
  });


  testWidgets('Displays "Well done!" when result is 50', (tester) async {
    final controller = TestController();
    Get.put(controller);

    controller.result.value = 55;

    await tester.pumpWidget(const GetMaterialApp(home: TestCompletionView()));
    await tester.pumpAndSettle();

    expect(find.text('Well done!'), findsOneWidget);
  });


  testWidgets('Displays "Try again" when result is below 50', (tester) async {
    final controller = TestController();
    Get.put(controller);

    controller.result.value = 40;

    await tester.pumpWidget(const GetMaterialApp(home: TestCompletionView()));
    await tester.pumpAndSettle();

    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('Pressing button calls checkButtonActivity', (tester) async {
    Get.reset(); // Clear old instances

    var called = false;
    final controller = TestControllerMock(() {
      called = true;
    });
    Get.put<TestController>(controller); // <-- Register BEFORE widget

    await tester.pumpWidget(const GetMaterialApp(home: TestCompletionView()));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_forward_outlined));
    await tester.pump();

    expect(called, isTrue);
  });

}
