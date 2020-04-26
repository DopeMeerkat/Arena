import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'arena.dart';

class Piece {
  final Arena game;
  Rect pieceRect;
  Paint piecePaint;
  bool isMoving = false;

  Piece(this.game, double x, double y) {
    pieceRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    piecePaint = Paint();
    piecePaint.color = Color(0xff6ab04c);
  }

  void render(Canvas c) {
    c.drawRect(pieceRect, piecePaint);
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
        pieceRect = Rect.fromLTWH(pieceRect.left, 0, game.tileSize, game.tileSize);
      } else if (pieceRect.right > game.screenSize.width) {
        pieceRect = Rect.fromLTWH(0, pieceRect.top, game.tileSize, game.tileSize);
      } else if (pieceRect.bottom < 0) {
        pieceRect = Rect.fromLTWH(pieceRect.left, game.screenSize.height, game.tileSize, game.tileSize);
      } else if (pieceRect.left < 0) {
        pieceRect = Rect.fromLTWH(20, pieceRect.top, game.tileSize, game.tileSize);
      }
    }
  }

  void onTapDown() {
    isMoving = true;
    piecePaint.color = Color(0xffff4757);
    game.spawnPieces();
    game.spawnPieces();
  }
}