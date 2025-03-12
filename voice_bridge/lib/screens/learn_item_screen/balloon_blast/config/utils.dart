import 'dart:math';

import 'package:flame/components.dart';

class Utils {
  Utils._();

  static int getAngleOfTouchPont({
    required Vector2 center,
    required double initAngle,
    required Vector2 touch,
  }) {
      final touchPoint = touch - center;
      double angle = atan2(touchPoint.y, touchPoint.x);

      angle -=initAngle;
      angle %= 2 * pi;

      return radians2Degrees(angle).toInt();
  }
  static double radians2Degrees(double angle){
    return angle * 180 / pi;
  }
}