import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/rounded_button.dart';
import '../../fruit_slash/game_main.dart';

class HomePage extends Component with HasGameReference<Game> {
  // Declare the button as nullable
  RoundedButton? _button1;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Initialize the button inside onLoad
    _button1 = RoundedButton(
      text: "Start",
      onPressed: () {
        // Navigate to the game page using the router
        game.router.pushNamed('game-page');
      },
      color: Colors.blue,
      borderColor: Colors.white,
    );

    // Ensure the button is initialized before adding
    if (_button1 != null) {
      add(_button1!);  // Use the non-nullable value safely
    } else {
      print("Button not initialized correctly");
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    // Ensure _button1 is not null before accessing it
    if (_button1 != null && _button1!.isMounted) {
      // Ensure the button is positioned correctly at the center
      _button1!.position = size / 2;
    } else {
      print("Button is not mounted or not initialized properly");
    }
  }
}
