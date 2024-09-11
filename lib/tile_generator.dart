import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flut/tile.dart';
import 'package:flut/tile_state.dart';
import 'package:flut/tile_state_generator.dart';

class TileGenerator extends PositionComponent {
  Sprite? sprite;
  
  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(Flame.images.fromCache("generatorView.png"));
  }

  @override
  void render(Canvas canvas) {
    sprite?.render(canvas, size: size);
  }

  void generate() {
    TileState state = TileStateGenrator.generate();
    Tile tile = Tile(state) 
      ..size = size * 0.9
     ..position = size / 2
      ..anchor = Anchor.center;
    add(tile);
  }
}