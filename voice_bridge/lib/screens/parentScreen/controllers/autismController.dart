import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutismController extends GetxController {
  var score = 0.0.obs;
  var level = "Not Tested".obs;

  Color get levelColor {
    if (score.value < 0.3) return Colors.green;
    if (score.value < 0.7) return Colors.orange;
    return Colors.red;
  }

  @override
  void onInit() {
    super.onInit();
    loadScore();
  }

  void updateScore(double newScore) {
    score.value = newScore;
    if (newScore < 0.3) {
      level.value = "Mild";
    } else if (newScore < 0.7) {
      level.value = "Moderate";
    } else {
      level.value = "Severe";
    }
    saveScore(newScore);
  }

  Future<void> saveScore(double newScore) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('autism_score', newScore);
  }

  Future<void> loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    double savedScore = prefs.getDouble('autism_score') ?? 0.0;
    updateScore(savedScore);
  }

  void calculateFromAnswers(List<int> ratingAnswers, List<bool> yesNoAnswers) {
    double ratingAvg = ratingAnswers.isNotEmpty
        ? ratingAnswers.reduce((a, b) => a + b) / (ratingAnswers.length * 10)
        : 0.0;

    double yesNoScore = yesNoAnswers.isNotEmpty
        ? yesNoAnswers.where((e) => e).length / yesNoAnswers.length
        : 0.0;

    double finalScore = (ratingAvg + yesNoScore) / 2;
    updateScore(finalScore);
  }
}
