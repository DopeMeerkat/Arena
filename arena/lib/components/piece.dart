import 'dart:math';
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:arena/arena.dart';

class Piece {
  final Arena game;
  Sprite pieceSprite;
  Rect pieceRect;
  bool isMoving = false;

  Piece(this.game, double x, double y) {
    pieceSprite = Sprite('pieces/penguin.png');
    pieceRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
  }

  void render(Canvas c) {
    pieceSprite.renderRect(c, pieceRect.inflate(2));
  }

  void update(double t) {
    if (isMoving) {
      Random rand = Random();
      int xdistance = rand.nextInt(10);
      int ydistance = rand.nextInt(10);
      double dx = rand.nextInt(xdistance) - (xdistance / 2) + 0.0;
      double dy = rand.nextInt(ydistance) - (ydistance / 2) + 0.0;
      pieceRect = pieceRect.translate(dx, dy);

      if (pieceRect.top > game.screenSize.height) {
        pieceRect =
            Rect.fromLTWH(pieceRect.left, 0, game.tileSize, game.tileSize);
      } else if (pieceRect.right > game.screenSize.width) {
        pieceRect =
            Rect.fromLTWH(0, pieceRect.top, game.tileSize, game.tileSize);
      } else if (pieceRect.bottom < 0) {
        pieceRect = Rect.fromLTWH(pieceRect.left, game.screenSize.height,
            game.tileSize, game.tileSize);
      } else if (pieceRect.left < 0) {
        pieceRect =
            Rect.fromLTWH(20, pieceRect.top, game.tileSize, game.tileSize);
      }
    }
  }

  void onTapDown() {
    isMoving = true;
    game.spawnPieces();
    game.spawnPieces();
  }
}
