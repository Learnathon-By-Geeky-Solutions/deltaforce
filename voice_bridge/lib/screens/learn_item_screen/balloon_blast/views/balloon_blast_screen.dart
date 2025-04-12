import 'dart:async';
import 'dart:math';
import 'package:flame/src/components/router/route.dart' as FlameRoute;
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/rectangle_test.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/config/app_config.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/routes/game_over_page.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/routes/game_page.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/routes/home_page.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/routes/pause_game.dart';

class BalloonBlastScreen extends StatelessWidget {
  const BalloonBlastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Flame.device.fullScreen(),
      builder: (context, snapshot) {
        return Scaffold(
          body: GameWidget(
            game: BalloonBlastGame(), // Create an instance of your game
          ),
        );
      },
    );
  }
}

//Extending FlameGame instead of the abstract Game class
class BalloonBlastGame extends FlameGame {
  late RouterComponent router;
  late double maxVerticalVelocity;

  final List<String> fruits = [
    "apple.png",
    "banana.png",
    "bomb.png",
    "orange.png",
    "peach.png",
    "pipeapple.png",
    "strawberry.png",
  ];




  @override
  Future<void> onLoad() async {
    await super.onLoad();

    for (final fruit in fruits) {
      await images.load(fruit);
    }

    // Initialize router
    router = RouterComponent(
      initialRoute: 'home',
      routes: {
        'home': FlameRoute.Route(HomePage.new),
        'game-page': FlameRoute.Route(GamePage.new),
        'pause': PauseRoute(),
        'game-over':GameOverRoute(),
      },
    );

    // Load background parallax
    final parallax = await ParallaxComponent.load(
      [
        ParallaxImageData('bg.png'),
      ],
      baseVelocity: Vector2(0, 0),
    );

    addAll([
      parallax,
      router,
    ]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    getMaxVerticalVelocity(size);
  }

  void getMaxVerticalVelocity(Vector2 size) {
    maxVerticalVelocity = sqrt(
      2 * (AppConfig.gravity.abs() + AppConfig.acceleration.abs()) *
          (size.y - AppConfig.objSize * 2),
    );
  }
}
