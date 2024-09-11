import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flut/tile_state.dart';

class TileStateGenrator {

  static TileState generate() {
    int value = Random().nextInt(3) + 1;
    for (var state in TileState.values) {
      if (state.index == value) {
        return state;
      }
    }
    return TileState.none;
  }
}

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
}