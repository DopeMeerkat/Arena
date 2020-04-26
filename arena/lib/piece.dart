import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'arena.dart';
import 'package:vector_math/vector_math.dart';

class Piece {
  final Arena game;
  Rect pieceRect;
  Paint piecePaint;
  Vector2 direction;

  Piece(this.game, double x, double y) {
    pieceRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    piecePaint = Paint();
    piecePaint.color = Color(0xff6ab04c);

    direction = getRandDirection();
  }

  Vector2 getRandDirection() {
    Random rand = Random();
    double x = rand.nextDouble() - .5;
    double y = rand.nextDouble() - .5;
    Vector2 dir = Vector2(x, y);
    dir.normalize();
    return dir;
  }

  void set0() {
    direction = Vector2(0, 0);
  }

  void handleCollision(Rect otherRect) {
    if (pieceRect.overlaps(otherRect)) {
      direction = getRandDirection();
    }
  }

  void render(Canvas c) {
    c.drawRect(pieceRect, piecePaint);
  }

  void update(double t) {
    pieceRect = pieceRect.translate(direction.x, direction.y);
    if (pieceRect.top > game.screenSize.height || pieceRect.bottom < 0) {
      direction.y = -1 * direction.y;
    }
    if (pieceRect.left < 0 || pieceRect.right > game.screenSize.width) {
      direction.x = -1 * direction.x;
    }
  }
}