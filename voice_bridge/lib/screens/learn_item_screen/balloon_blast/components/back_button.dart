import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/simple_button.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/game_main.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/views/balloon_blast_screen.dart';

class BackButton extends SimpleButton with HasGameReference<MyGame> {
  BackButton({VoidCallback? onPressed})
      : super(
    Path()
      ..moveTo(22, 8)
      ..lineTo(10, 20)
      ..lineTo(22, 32)
      ..moveTo(12, 20)
      ..lineTo(34, 20),
    position: Vector2.all(10),
  ) {
    action = onPressed ?? () => BalloonBlastGame().router.pop();
  }
}
