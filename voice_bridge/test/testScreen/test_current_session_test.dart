import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voice_bridge/screens/sessionScreen/view_model/session_model.dart';
import 'package:voice_bridge/screens/testScreen/controllers/test_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final controller = TestController();

  setUp(() {
    // Clear mocks before each test
    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler('flutter/assets', null);
  });

  test('testStartSession loads JSON session', () async {
    final sessionData = {
      "sessionName": "Session 2",
      "lessons": [
        {
          "lessonName": "A",
          "imageAsset": "lib/resources/assets/Study/images/a.jpg",
          "animationAsset": "lib/resources/assets/Study/animations/a.lottie",
          "audioAsset": "lib/resources/assets/Study/audio/a.mp3"
        }
      ]
    };
    final encoded = jsonEncode(sessionData);

    ServicesBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
        'flutter/assets/lib/resources/assets/Study/sessions/sessions1.json',
            (ByteData? message) async {
          return ByteData.view(Uint8List.fromList(utf8.encode(encoded)).buffer);
        }
    );

    await controller.testStartSession('Study', 1);

    expect(controller.testCurrentSession.value, isA<Session>());
    expect(controller.lessonLength, 10);
  });
}
