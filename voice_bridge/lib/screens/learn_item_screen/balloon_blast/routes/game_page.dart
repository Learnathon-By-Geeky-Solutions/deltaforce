import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/fruit_component.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/pause_button.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/back_button.dart'; // ✅ Added import
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/config/app_config.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/views/balloon_blast_screen.dart';

class GamePage extends Component
    with DragCallbacks, HasGameReference<BalloonBlastGame> {
  final Random random = Random();
  late List<double> fruitsTime;
  late double time, countDown;
  TextComponent? _countdownTextComponent;
  bool _countdownFinished = false;

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    fruitsTime = [];
    countDown = 3;
    time = 0;
    _countdownFinished = false;

    double initTime = 0;

    for (int i = 0; i < 40; i++) {
      if (i != 0) {
        initTime = fruitsTime.last;
      }
      final millySecondTime = random.nextInt(100) / 100;
      final componentTime = random.nextInt(1) + millySecondTime + initTime;
      fruitsTime.add(componentTime);
    }
    print("The fruits time is initiated ${fruitsTime}");

    addAll([
      GameBackButton(onPressed: () {
        removeAll(children);
        game.router.pop();
      }),
      PauseButton(),
      _countdownTextComponent = TextComponent(
        text: '${countDown.toInt() + 1}',
        size: Vector2.all(70),
        position: game.size / 2,
        anchor: Anchor.center,
      ),
    ]);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    if (!_countdownFinished) {
      countDown -= dt;
      _countdownTextComponent?.text = (countDown.toInt() + 1).toString();

      if (countDown < 0) {
        _countdownFinished = true;
      }
    } else {
      _countdownTextComponent?.removeFromParent();
      time += dt;
      fruitsTime.where((element) => element < time).toList().forEach((element) {
        final gameSize = game.size;
        double posX = random.nextInt(gameSize.x.toInt()).toDouble();
        Vector2 fruitPosition = Vector2(posX, gameSize.y);
        Vector2 velocity = Vector2(0, game.maxVerticalVelocity);

        final randFruit = game.fruits.random();
        add(FruitComponent(this, fruitPosition,
            acceleration: AppConfig.acceleration,
            fruit: randFruit,
            size: AppConfig.shapeSize,
            image: game.images.fromCache(randFruit.image),
            pageSize: gameSize,
            velocity: velocity,
        ));
        fruitsTime.remove(element);
      });
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onDragUpdate(DragUpdateEvent event){
    super.onDragUpdate(event);
    componentsAtPoint(event.canvasPosition).forEach((element){
      if(element is FruitComponent){
        element.touchAtPoint(event.canvasPosition);
      }
    });
  }

  void gameOver() {
    game.router.pushNamed('game-over');
  }
}
