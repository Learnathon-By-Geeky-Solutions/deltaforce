import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/fruit_component.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/pause_button.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/components/back_button.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/config/app_config.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/views/balloon_blast_screen.dart';

import '../config/score_manager.dart';


class GamePage extends Component
    with DragCallbacks, HasGameReference<BalloonBlastGame> {
  final Random random = Random();
  late List<double> fruitsTime;
  late double time, countDown;
  TextComponent? _countdownTextComponent, _mistakeTextComponent, _scoreTextComponent, _topScoreTextComponent;
  bool _countdownFinished = false;
  late int mistakeCount, score, topScore;

  @override
  void onMount() async {
    super.onMount();
    fruitsTime = [];
    countDown = 3;
    mistakeCount = 0;
    score = 0;
    time = 0;
    _countdownFinished = false;

    topScore = await ScoreManager.getTopScore();

    double initTime = 0;

    for (var i = 0;i<1000000000 ; i++) {
      if (i != 0) {
        initTime = fruitsTime.last;
      }
      final millySecondTime = random.nextInt(100) / 100;
      final componentTime = random.nextInt(1) + millySecondTime + initTime;
      fruitsTime.add(componentTime);
    }

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
      _mistakeTextComponent = TextComponent(
        text: 'Mistake: $mistakeCount',
        position: Vector2(game.size.x - 10, 10),
        anchor: Anchor.topRight,
      ),
      _scoreTextComponent = TextComponent(
        text: 'Score: $score',
        position: Vector2(game.size.x - 10 , 50),
        anchor: Anchor.topRight,
      ),
      _topScoreTextComponent = TextComponent(
        text: 'Top Score: $topScore',
        position: Vector2(game.size.x - 10, 10),
        anchor: Anchor.topRight,
      )


    ]);
  }

  @override
  void update(double dt) {
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

  void gameOver() async {
    await ScoreManager.saveTopScore(score);
    game.router.pushNamed('game-over');
  }

  void addScore(){
    score++;
    _scoreTextComponent?.text = 'Score: $score';

    if (score > topScore) {
      topScore = score;
      _topScoreTextComponent?.text = 'Top Score: $topScore';
    }
  }

  // void addMistake(){
  //   mistakeCount++;
  //   _mistakeTextComponent?.text = 'Mistake: $mistakeCount';
  //   if(mistakeCount >= 3){
  //     gameOver();
  //   }
  // }
}
