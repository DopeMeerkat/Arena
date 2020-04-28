import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:arena/arena.dart';

class Arrow {
  Sprite arrowSprite;
  Rect arrowRect;
  final Arena game;
  var arrowComponent;
  bool visible;
  double height;
  double x, y, angle, mag;
  Arrow(this.game) {
    // visible = false;
    visible = true;
    arrowSprite = Sprite('util/arrow.png');
    height = game.pieceSize * 9;
    arrowComponent = new SpriteComponent.fromSprite(
        game.pieceSize * 3, height, arrowSprite); // width, height, sprite
  }

  void render(Canvas c) {
    if (visible) {
      arrowComponent.render(c);
    }
  }

  void updateArrow(double x, y, angle, mag) {
    arrowComponent.x = x;
    arrowComponent.y = y;
    arrowComponent.angle = angle;
    arrowComponent.height = mag;
  }

  void update(double t) {
    arrowComponent.x = x;
    arrowComponent.y = y;
    arrowComponent.angle = angle;
    arrowComponent.height = mag;
  }
}
