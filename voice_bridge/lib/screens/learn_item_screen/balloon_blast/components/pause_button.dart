import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/simple_button.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/game_main.dart';
import '../views/balloon_blast_screen.dart';

class PauseButton extends SimpleButton with HasGameReference<BalloonBlastGame> {
  PauseButton({VoidCallback? onPressed})
      : super(
    Path()
      ..moveTo(14, 10)
      ..lineTo(14, 30)
      ..moveTo(26, 10)
      ..lineTo(26, 30),
    position: Vector2(60, 10),
  ) {
    super.action = onPressed ?? () {

      game.router.pushNamed('pause');
    };
  }
}
