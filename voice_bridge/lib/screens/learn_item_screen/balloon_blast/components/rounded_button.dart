import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart';

class RoundedButton extends PositionComponent with TapCallbacks {
  final String text;
  final VoidCallback onPressed;
  late final Offset _textOffSet;
  late TextPainter _textDrawable;
  late RRect _rRect;
  late Paint _bgPaint;
  late Paint _borderPaint;

  RoundedButton({
    required this.text,
    required this.onPressed,
    required Color color,
    required Color borderColor,
    super.anchor = Anchor.center,
  }) : _textDrawable = TextPaint(
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF000000),
          ),
        ).toTextPainter(text) {
    size = Vector2(150, 40);
    _textOffSet = Offset((size.x - _textDrawable.width) / 2,
        (size.y - _textDrawable.height) / 2);
    _rRect = RRect.fromLTRBR(0, 0, size.x, size.y, Radius.circular(size.y / 2));

    _bgPaint = Paint()..color = color;
    _borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = borderColor;
  }

  @override
  void render(Canvas canvas) {
    // Draw background and border using Paint
    canvas.drawRRect(_rRect, _bgPaint);
    canvas.drawRRect(_rRect, _borderPaint);

    // Draw text
    _textDrawable.paint(canvas, _textOffSet);
  }

  @override
  void onTapDown(TapDownEvent event) {
    scale = Vector2.all(1.05);
  }

  @override
  void onTapUp(TapUpEvent event) {
    scale = Vector2.all(1.0);
    onPressed.call();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    scale = Vector2.all(1.0);
  }
}
