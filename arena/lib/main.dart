import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'arena.dart';

void main() async {
  Util flame = Util();
  WidgetsFlutterBinding.ensureInitialized();
  await flame.fullScreen();
  await flame.setOrientation(DeviceOrientation.portraitUp);

  Flame.images.loadAll(<String>[
    'bg/icy_bg.jpg',
    'pieces/penguin.png',
    'pieces/penguin2.png',
    'util/start.png',
    'util/arrow.png',
  ]);
  Arena game = Arena();
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flame.addGestureRecognizer(tapper);

  PanGestureRecognizer pan = PanGestureRecognizer();
  pan.onStart = game.onPanStart;
  pan.onUpdate = game.onDragUpdate;
  pan.onEnd = game.onPanEnd;
  flame.addGestureRecognizer(pan);
  /*
  DoubleTapGestureRecognizer doubleTap = DoubleTapGestureRecognizer();
  doubleTap.onDoubleTap = game.startPieces;
  flame.addGestureRecognizer(doubleTap);
  */
}
