import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/rounded_button.dart';
import '../game_main.dart';
import '../views/balloon_blast_screen.dart';

class HomePage extends PositionComponent with HasGameReference<BalloonBlastGame> {
  late RoundedButton _button1;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _button1 = RoundedButton(
      text: "Start",
      onPressed: () {
        game.router.pushNamed('game-page'); // Navigate to GamePage
      },
      color: Colors.blue,
      borderColor: Colors.white,
    );

    _button1.position = Vector2(game.size.x / 2, game.size.y / 2); // Center button
    add(_button1);
  }
}
