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
  late double countDown;
  TextComponent? _countdownTextComponent, _scoreTextComponent, _topScoreTextComponent;
  bool _countdownFinished = false;
  late int mistakeCount, score, topScore;

  double spawnTimer = 0;
  double nextSpawnTime = 0.1;
  bool isGameOver = false;

  @override
  void onMount() async {
    super.onMount();
    countDown = 3;
    mistakeCount = 0;
    score = 0;
    _countdownFinished = false;
    isGameOver = false;

    topScore = await ScoreManager.getTopScore();

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
      _scoreTextComponent = TextComponent(
        text: 'Score: $score',
        position: Vector2(game.size.x - 10, 50),
        anchor: Anchor.topRight,
      ),
      _topScoreTextComponent = TextComponent(
        text: 'Top Score: $topScore',
        position: Vector2(game.size.x - 10, 10),
        anchor: Anchor.topRight,
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isGameOver) return;

    if (!_countdownFinished) {
      countDown -= dt;
      _countdownTextComponent?.text = (countDown.toInt() + 1).toString();

      if (countDown < 0) {
        _countdownFinished = true;
        _countdownTextComponent?.removeFromParent();
      }
    } else {
      spawnTimer += dt;
      if (spawnTimer >= nextSpawnTime) {
        spawnTimer = 0;
        _spawnFruit();
        nextSpawnTime = 0.1 + random.nextDouble(); // 0.5 to 1.5 seconds
      }
    }
  }

  void _spawnFruit() {
    final gameSize = game.size;
    double posX = random.nextInt(gameSize.x.toInt()).toDouble();
    Vector2 fruitPosition = Vector2(posX, gameSize.y);
    Vector2 velocity = Vector2(0, game.maxVerticalVelocity);

    final randFruit = game.fruits.random();
    add(FruitComponent(
      this,
      fruitPosition,
      acceleration: AppConfig.acceleration,
      fruit: randFruit,
      size: AppConfig.shapeSize,
      image: game.images.fromCache(randFruit.image),
      pageSize: gameSize,
      velocity: velocity,
    ));
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    componentsAtPoint(event.canvasPosition).forEach((element) {
      if (element is FruitComponent) {
        element.touchAtPoint(event.canvasPosition);
      }
    });
  }

  void gameOver() async {
    isGameOver = true;
    await ScoreManager.saveTopScore(score);
    game.router.pushNamed('game-over');
  }

  void addScore() {
    score++;
    _scoreTextComponent?.text = 'Score: $score';

    if (score > topScore) {
      topScore = score;
      _topScoreTextComponent?.text = 'Top Score: $topScore';
    }
  }
}
