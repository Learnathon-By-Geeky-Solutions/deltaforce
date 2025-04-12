import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import '../views/balloon_blast_screen.dart';

class PauseRoute extends Route {
  PauseRoute() : super(PausePage.new, transparent: true);

  @override
  void onPush(Route? previousRoute) {
    previousRoute!
      ..stopTime()
      ..addRenderEffect(
        PaintDecorator.grayscale(opacity: 0.5)..addBlur(3.0),
      );
  }
}

class PausePage extends Component with TapCallbacks, HasGameReference<BalloonBlastGame> {
  late TextComponent _textComponent;

  @override
  Future<void> onLoad() async {
    print("Pause Load");
    final game = findGame();
    addAll([
      _textComponent = TextComponent(
        text: 'PAUSED',
        position: game!.canvasSize / 2,
        anchor: Anchor.center,
        children: [
          ScaleEffect.to(Vector2.all(1.1), EffectController(
            duration: 0.1,
            alternate: true,
            infinite: true,
          ))
        ],
      ),
    ]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _textComponent.position = size / 2;
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event){
    game.router.pop();
    print("Game Main Screen Is Working");
  }
}
