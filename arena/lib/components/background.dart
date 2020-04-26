import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:arena/arena.dart';

class Background {
  final Arena game;
  Sprite bgSprite;
  Rect bgRect;

  Background(this.game) {
    bgSprite = Sprite('bg/icy_bg.jpg');
    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.pieceSize * 23),
      game.pieceSize * 9,
      game.pieceSize * 23,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}
