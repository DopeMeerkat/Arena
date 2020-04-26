import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'piece.dart';

class Arena extends Game {
  Size screenSize;
  double tileSize;
  List<Piece> pieces;
  Random rand;

  Arena() {
    initialize();
  }

  void initialize() async {
    pieces = List<Piece>();
    rand = Random();
    resize(await Flame.util.initialDimensions());

    spawnPieces();
  }

  void spawnPieces() {
    double x = rand.nextDouble() * (screenSize.width - tileSize);
    double y = rand.nextDouble() * (screenSize.height - tileSize);
    pieces.add(Piece(this, x, y));
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);

    pieces.forEach((Piece piece) => piece.render(canvas));
  }

  void update(double t) {
    pieces.forEach((Piece piece) => piece.update(t));
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 30;
  }

  void onTapDown(TapDownDetails d) {
    pieces.forEach((Piece piece) {
      if (piece.pieceRect.contains(d.globalPosition)) {
        piece.onTapDown();
      }
    });
  }
}