import 'package:flame/game.dart';
import 'package:flame/components.dart'; // Import components for creating entities like Rectangle
import 'package:flutter/material.dart';

class GameMain extends StatefulWidget {
  const GameMain({super.key});

  @override
  State<GameMain> createState() => _GameMainState();
}

class _GameMainState extends State<GameMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: Game(), // Create an instance of your game
      ),
    );
  }
}

// Extending FlameGame instead of the abstract Game class
class Game extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Adding a RectangleComponent to the game at the center of the screen
    add(RectangleComponent(
      size: Vector2(50, 50), // Rectangle size
      position: size / 2, // Position at the center
      paint: Paint()..color = Colors.red, // Rectangle color
    ));
  }
}
