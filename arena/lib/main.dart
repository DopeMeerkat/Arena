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

  Arena game = Arena();
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flame.addGestureRecognizer(tapper);

  PanGestureRecognizer pan = PanGestureRecognizer();
  //pan.onDown() = game.onDragDown();
  //pan.onEnd() = game.onDragEnd();

}
