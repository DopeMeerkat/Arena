import 'dart:math';
import 'dart:ui';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

import 'package:arena/components/background.dart';
import 'package:arena/components/piece.dart';
import 'package:arena/components/penguin.dart';
import 'package:arena/components/penguin2.dart';

class Arena extends Game {
  Size screenSize;
  double tileSize;
  Background bg;
  List<Piece> pieces;
  Random rand;
  // Box2DComponent piece;
  // Box2DGame(Box2DComponent piece) {}
  Arena() {
    initialize();
  }

  void initialize() async {
    pieces = List<Piece>();
    rand = Random();
    resize(await Flame.util.initialDimensions());

    //spawnPieces();
  }
  /*
  void spawnPieces() {
    //currently random spawn
    double x = rand.nextDouble() * (screenSize.width - tileSize);
    double y = rand.nextDouble() * (screenSize.height - tileSize);
    switch (rand.nextInt(2)) {
      case 0:
        pieces.add(Penguin(this, x, y));
        break;
      case 1:
        pieces.add(Penguin2(this, x, y));
        break;
    }
    // pieces.add(Piece(this, x, y));
  }
  */

  void render(Canvas canvas) {
    bg.render(canvas);
    // Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    // Paint bgPaint = Paint();
    // bgPaint.color = Color(0xff576574);
    // canvas.drawRect(bgRect, bgPaint);

    pieces.forEach((Piece piece) => piece.render(canvas));
  }

  void update(double t) {
    pieces.forEach((Piece piece) => piece.update(t));

    pieces.forEach((Piece piece) {
      pieces.forEach((Piece otherPiece) {
        if (piece != otherPiece) {
          piece.handleCollision(otherPiece.pieceRect);
        }
      });
    });
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    bool onPiece = false;
    pieces.forEach((Piece piece) {
      if (piece.pieceRect.contains(d.globalPosition)) {
        piece.set0();
        piece.piecePaint.color = Color(0xffff4757);
        onPiece = true;
      }
    });
    if (!onPiece) {
      addPiece(d.globalPosition.dx, d.globalPosition.dy);
    }
  }

  void addPiece(x, y) {
    pieces.add(Piece(this, x, y));
  }
}
