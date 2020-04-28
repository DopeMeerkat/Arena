import 'dart:math';
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:arena/arena.dart';
import 'package:arena/components/piece.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class Arrow {
  final Arena game;
  Piece piece;
  Paint arrowPaint;
  double targetx;
  double targety;

  Arrow(this.game, this.piece) {
    targetx = piece.pieceRect.left;
    targety = piece.pieceRect.top;
    arrowPaint = Paint();
    arrowPaint.color = Color(0xff6ab04c);
  }

  void render(Canvas c) {
    c.drawLine(Offset(piece.pieceRect.left, piece.pieceRect.top),
      Offset(targetx, targety), arrowPaint);
  }

  void setTarget(double x, double y) {
    targetx = x;
    targety = y;
  }

  void update(double t) {
  }
}
