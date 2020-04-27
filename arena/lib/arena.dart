import 'dart:math';
import 'dart:ui';
import 'package:flame/box2d/box2d_component.dart';
import 'package:flame/box2d/box2d_game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:vector_math/vector_math.dart';

import 'package:arena/components/background.dart';
import 'package:arena/components/piece.dart';
import 'package:arena/components/penguin.dart';
import 'package:arena/components/penguin2.dart';
import 'package:arena/components/run-btn.dart';
import 'package:arena/components/arrow.dart';

/*
  How the game currently works:
  Click to place penguins
  Drag from penguin to set it's trajectory
  Hit white button to simulate all penguins

  TODO:
  1. add arrow for trajectory
  2. increase frames/sec (possible that calculations are taking too long)
*/

class Arena extends Game {
  Size screenSize;
  double pieceSize;
  Background bg;
  List<Piece> pieces;
  Random rand;
  RunBtn button; //button to run simulation
  Piece dragged; //current piece being dragged
  Arrow arrow;
  Vector2 dragEndpoint;
  // Box2DComponent piece;
  // Box2DGame(Box2DComponent piece) {}

  Arena() {
    initialize();
  }

  void initialize() async {
    pieces = List<Piece>();
    rand = Random();
    resize(await Flame.util.initialDimensions());
    bg = Background(this);
    button = RunBtn(this, screenSize.width * 1 / 3, screenSize.height * 5 / 6);
    arrow = Arrow(this);
    //spawnPieces();
  }

  // void spawnPieces() {
  //   //currently random spawn
  //   //randomly spawn 3
  //   double x = rand.nextDouble() * (screenSize.width - pieceSize);
  //   double y = rand.nextDouble() * (screenSize.height - pieceSize);
  //   switch (rand.nextInt(2)) {
  //     case 0:
  //       pieces.add(Penguin(this, x, y));
  //       break;
  //     case 1:
  //       pieces.add(Penguin2(this, x, y));
  //       break;
  //   }
  //   // pieces.add(Piece(this, x, y));
  // }

  void render(Canvas canvas) {
    bg.render(canvas);
    button.render(canvas);
    pieces.forEach((Piece piece) => piece.render(canvas));

    arrow.render(canvas);
  }

  void update(double t) {
    pieces.forEach((Piece piece) => piece.update(t));

    pieces.forEach((Piece piece) {
      pieces.forEach((Piece otherPiece) {
        if (piece != otherPiece) {
          piece.handleCollision(otherPiece);
        }
      });
    });
  }

  void resize(Size size) {
    screenSize = size;
    pieceSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    //on button
    if (button.btnRect.contains(d.globalPosition)) {
      startPieces();
    } else {
      bool onPiece = false;
      for (Piece piece in pieces) {
        if (piece.pieceRect.contains(d.globalPosition)) {
          onPiece = true;
          break;
        }
      }
      if (!onPiece) {
        //new space
        addPiece(d.globalPosition.dx, d.globalPosition.dy);
      }
    }
  }

  void addPiece(x, y) {
    switch (rand.nextInt(2)) {
      case 0:
        pieces.add(Penguin(this, x, y));
        break;
      case 1:
        pieces.add(Penguin2(this, x, y));
        break;
    }
  }

  void onPanStart(DragStartDetails d) {
    for (Piece piece in pieces) {
      if (piece.pieceRect.contains(d.globalPosition)) {
        dragged = piece;
        break;
      }
    }
  }

  void onDragUpdate(DragUpdateDetails d) {
    if (dragged != null) {
      //double x = d.globalPosition.dx - dragged.pieceRect.left;
      //double y = d.globalPosition.dy - dragged.pieceRect.top;
      dragEndpoint = dragged.calcInitialVelocity(dragged.pieceRect.left,
          dragged.pieceRect.top, d.globalPosition.dx, d.globalPosition.dy);
    }
  }

  void onPanEnd(DragEndDetails d) {
    if (dragged != null) {
      //dragged.moving = true;
      dragged.setVelocity(dragEndpoint.x, dragEndpoint.y);

      dragged = null;
    }
  }

  void startPieces() {
    pieces.forEach((piece) => piece.moving = true);
  }
}
