import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/simple_button.dart';
import '../views/balloon_blast_screen.dart';

class GameBackButton extends SimpleButton with HasGameReference<BalloonBlastGame> {
  GameBackButton({VoidCallback? onPressed})
      : super(
    Path()
      ..moveTo(22, 8)
      ..lineTo(10, 20)
      ..lineTo(22, 32)
      ..moveTo(12, 20)
      ..lineTo(34, 20),
    position: Vector2.all(10),
  ) {
    action = onPressed ?? () => game.router.pop();
  }
}
