import 'package:flame/game.dart';
import 'package:flut/my_game.dart';
import 'package:flutter/widgets.dart';

void main() {
  final game = MyGame();
  runApp(GameWidget(game: game));
}