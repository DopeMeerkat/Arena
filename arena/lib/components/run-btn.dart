import 'dart:math';
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:arena/arena.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class RunBtn {
  final Arena game;
  Rect btnRect;
  Sprite btnSprite;

  RunBtn(this.game, double x, double y) {
    btnSprite = Sprite('util/start.png');
    btnRect = Rect.fromLTWH(x, y, game.pieceSize * 3, game.pieceSize);
  }

  void render(Canvas c) {
    btnSprite.renderRect(c, btnRect);
  }

  void update(double t) {}
}
