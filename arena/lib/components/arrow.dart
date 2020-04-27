import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:arena/arena.dart';

class Arrow {
  Sprite arrowSprite;
  Rect arrowRect;
  final Arena game;
  var arrowComponent;

  Arrow(this.game) {
    arrowSprite = Sprite('util/arrow.png');
    // arrowRect = Rect.fromLTWH(
    //   0,
    //   game.screenSize.height - (game.pieceSize * 23),
    //   game.pieceSize * 9,
    //   game.pieceSize * 23,
    // );
    arrowComponent = new SpriteComponent.fromSprite(game.pieceSize * 3,
        game.pieceSize * 9, arrowSprite); // width, height, sprite

    // screen coordinates
    arrowComponent.x = 200.0; // 0 by default
    arrowComponent.y = 200.0; // 0 by default
    arrowComponent.angle = 0.0; // 0 by default
  }

  void render(Canvas c) {
    arrowComponent.render(c);
  }

  void update(double t) {}
}
