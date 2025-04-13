import 'package:flame/game.dart';
import 'package:flame/components.dart';
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
        game: MyGame(), // Use a unique class name
      ),
    );
  }
}

// Extending FlameGame instead of the abstract Game class
class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Ensure size is initialized before positioning
    add(
      RectangleComponent(
        size: Vector2(50, 50), // Rectangle size
        position: Vector2(size.x / 2 - 25, size.y / 2 - 25), // Centering manually
        paint: Paint()..color = Colors.red, // Rectangle color
      ),
    );
  }
}
