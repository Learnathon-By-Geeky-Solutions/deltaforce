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
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/routes/game_page.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/routes/home_page.dart';

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
class Game extends FlameGame{
   late RouterComponent router;

  @override
  void onLoad() async{
   await super.onLoad();

    addAll([ParallaxComponent(
       parallax: Parallax([await ParallaxLayer.load(ParallaxImageData('bg.png'))])
    ),
      router = RouterComponent(
        initialRoute: 'home',
        routes: {

          'home' : FlameRoute.Route(HomePage.new),
          'game-page': FlameRoute.Route(GamePage.new),
          // 'home': flame.ComponentRoute(()=>HomePage.new),
        }
      )


    ]);


  }

  // void onDragUpdate(DragUpdateEvent event) {
  //  super.onDragUpdate(event);
  //  componentsAtPoint(event.canvasPosition).forEach((element){
  //    if(element is RectangleTest){
  //      element.touchOnPoint(event.canvasPosition);
  //    }
  //  });
  // }

  late double maxVerticalVelocity;

  get flame => null;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    getMaxVerticalVelocity(size);
  }

  void getMaxVerticalVelocity(Vector2 size) {
    maxVerticalVelocity = sqrt(2 *
        (AppConfig.gravity.abs() + AppConfig.acceleration.abs()) *
        (size.y - AppConfig.objSize * 2));
  }
}
