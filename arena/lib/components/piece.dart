import 'dart:math';
import 'dart:ui';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:arena/arena.dart';
import 'package:arena/components/arrow.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class Piece {
  final Arena game;
  Sprite pieceSprite;
  Rect pieceRect;
  Paint piecePaint;
  Vector2 velocity;
  final decelleration = 3.0;
  bool moving;
  Arrow arrow;
  double angle;

  Piece(this.game, double x, double y) {
    pieceRect = Rect.fromLTWH(x, y, game.pieceSize, game.pieceSize);
    piecePaint = Paint();
    piecePaint.color = Color(0xff6ab04c);
    moving = false;
    velocity = Vector2(0, 0);
    arrow = Arrow(game);
    //velocity = getRandDirection();
  }

  Vector2 getRandDirection() {
    Random rand = Random();
    double x = rand.nextDouble() - .5;
    double y = rand.nextDouble() - .5;
    Vector2 dir = Vector2(x, y);
    dir.normalize();
    return dir;
  }

  void setMoving(b) {
    moving = b;
  }

  void setVelocity(x, y) {
    velocity = Vector2(x, y);
  }

  void handleCollision(Piece otherPiece) {
    if (pieceRect.overlaps(otherPiece.pieceRect)) {
      //velocity = getRandDirection();
      moving = true;
      velocity.negate();
    }
  }

  void render(Canvas c) {
    arrow.render(c); //add vector
    pieceSprite.renderRect(c, pieceRect.inflate(2));
    // pieceSprite.renderCentered(c, Position(pieceRect.left, pieceRect.top));
    // arrow.render(c); //add vector
  }

  void update(double t) {
    if (moving) {
      updateVelocity(t);
      pieceRect = pieceRect.translate(velocity.x, velocity.y);

      if (pieceRect.top > game.screenSize.height || pieceRect.bottom < 0) {
        velocity.y = -1 * velocity.y;
      }
      if (pieceRect.left < 0 || pieceRect.right > game.screenSize.width) {
        velocity.x = -1 * velocity.x;
      }
    }
  }

  //calculates velocity so it will end at the end of the arrow
  Vector calcInitialVelocity(
      double startx, double starty, double endx, double endy) {
    Vector2 direction = Vector2(endx - startx, endy - starty);
    double distance = direction.length;
    direction.normalize(); //make unit
    direction.scale(sqrt(2 * decelleration * distance));
    return direction;
  }

  void updateVelocity(t) {
    //make it so calculation involves time later
    double newMagnitude = velocity.length - (decelleration);
    // print(velocity.length);
    if (newMagnitude > 0) {
      velocity.normalize();
      velocity.scale(newMagnitude);
    } else {
      velocity = Vector2(0, 0);
      moving = false;
    }
  }
}
