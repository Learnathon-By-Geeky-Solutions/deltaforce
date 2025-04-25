import 'package:shared_preferences/shared_preferences.dart';

class ScoreManager {
  static const _keyTopScore = 'top_score';

  static Future<void> saveTopScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    int topScore = prefs.getInt(_keyTopScore) ?? 0;
    if (score > topScore) {
      await prefs.setInt(_keyTopScore, score);
    }
  }

  static Future<int> getTopScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTopScore) ?? 0;
  }
}
