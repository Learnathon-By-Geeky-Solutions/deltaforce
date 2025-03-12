import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart';

class RoundedButton extends PositionComponent with TapCallbacks{
  final String text;
  final VoidCallback onPressed;
  late final Offset _textOffSet;
  late TextPainter _textDrawable;
  late RRect _rRect;
  late RRect _borderPaint;
  late final RRect _bgPaint;

  RoundedButton({
    required this.text,
    required this.onPressed,
    required Color color,
    required Color borderColor,
}): _textDrawable = TextPaint(
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Color(0xFF000000),
    ),
  ).toTextPainter(text){
    size = Vector2(150, 40);
    _textOffSet = Offset((size.x - _textDrawable.width)/2, (size.y - _textDrawable.height)/2);

  }
}