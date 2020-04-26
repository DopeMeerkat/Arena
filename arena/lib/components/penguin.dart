import 'package:flame/sprite.dart';
import 'package:arena/components/piece.dart';
import 'package:arena/arena.dart';

class Penguin extends Piece {
  Penguin(Arena game, double x, double y) : super(game, x, y) {
    pieceSprite = Sprite('pieces/penguin.png');
  }
}
