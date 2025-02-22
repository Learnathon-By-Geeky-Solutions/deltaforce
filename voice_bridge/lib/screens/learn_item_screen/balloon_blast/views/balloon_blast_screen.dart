import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/rectangle_test.dart';

class BalloonBlastScreen extends StatelessWidget {
  const BalloonBlastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Flame.device.fullScreen();
    //Flame.device.setLandscape();
    return Scaffold(
      body: GameWidget(
        game: Game(), // Create an instance of your game
      ),
    );
  }
}

//Extending FlameGame instead of the abstract Game class
class Game extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
      // Adding a RectangleComponent to the game at the center of the screen from rectangle_test.dart file
    add(RectangleTest(pageSize: size, velocity: Vector2(0, 20), size: size));

  }
}
