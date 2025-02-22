import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/config/app_config.dart';

class RectangleTest extends RectangleComponent{

  final Vector2 pageSize;
  Vector2 velocity;
  RectangleTest({
    required Vector2 size,
    required this.velocity,
    required this.pageSize,
  }) : super(
    size: AppConfig.shapeSize, // Rectangle size
    position: size / 2, // Position at the center
    paint: Paint()..color = Colors.white,
    anchor: Anchor.center
  );
  @override
  void update(double dt) { 
    super.update(dt);
    position += Vector2(0, -(velocity.y * dt - 0.5*AppConfig.gravity * dt*dt));

    velocity.y += (AppConfig.acceleration + AppConfig.gravity)*dt;
    if((position.y - AppConfig.objSize)>pageSize.y){
        removeFromParent();
    }
  }
}