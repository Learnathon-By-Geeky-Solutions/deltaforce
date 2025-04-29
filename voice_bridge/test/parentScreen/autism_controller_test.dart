import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_bridge/screens/parentScreen/controllers/autism_controller.dart';

void main() {
  setUp(() {
    // Use mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
  });

  test('Initial values should be correct', () {
    final controller = AutismController();
    expect(controller.score.value, 0.0);
    expect(controller.level.value, 'Not Tested');
    expect(controller.levelColor, Colors.green);
  });

  test('updateScore should update score and level correctly', () async {
    final controller = AutismController();

    controller.updateScore(0.2);
    expect(controller.score.value, 0.2);
    expect(controller.level.value, 'Mild');
    expect(controller.levelColor, Colors.green);

    controller.updateScore(0.5);
    expect(controller.score.value, 0.5);
    expect(controller.level.value, 'Moderate');
    expect(controller.levelColor, Colors.orange);

    controller.updateScore(0.8);
    expect(controller.score.value, 0.8);
    expect(controller.level.value, 'Severe');
    expect(controller.levelColor, Colors.red);
  });

  test('saveScore and loadScore should work correctly', () async {
    final controller = AutismController();

    await controller.saveScore(0.6);
    await controller.loadScore();

    expect(controller.score.value, 0.6);
    expect(controller.level.value, 'Moderate');
  });

  test('calculateFromAnswers should calculate the correct score', () {
    final controller = AutismController();

    // 3 ratings: 8, 6, 4 out of 10 -> avg = (8+6+4)/(3*10) = 0.6
    // 3 yes/no: [true, false, false] -> 2 false out of 3 = 2/3 ≈ 0.6667
    controller.calculateFromAnswers([8, 6, 4], [true, false, false]);

    double expectedScore = (0.6 + (2/3)) / 2;
    expect(controller.score.value, closeTo(expectedScore, 0.001));
  });

  test('calculateFromAnswers empty lists should give 0', () {
    final controller = AutismController();

    controller.calculateFromAnswers([], []);
    expect(controller.score.value, 0.0);
  });

  test('onInit should load saved score', () async {
    // Pre-save a score
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('autism_score', 0.4);

    final controller = AutismController();
    controller.onInit(); // Manually call

    // Now after onInit, the score and level should be updated
    await Future.delayed(Duration(milliseconds: 100)); // Wait a little for async
    expect(controller.score.value, 0.4);
    expect(controller.level.value, 'Moderate');
  });

}
