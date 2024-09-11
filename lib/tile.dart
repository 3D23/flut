import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flut/game_data.dart';
import 'package:flut/my_game.dart';
import 'package:flut/tile_state.dart';

class Tile extends PositionComponent with HasGameReference<MyGame> {
  TileState state = TileState.none;
  Sprite? sprite;

  Tile(this.state) {
    var spriteData = tilesSpriteAssetMap[pow(2, state.index)];
    sprite = Sprite(
      Flame.images.fromCache('tilesSpriteAsset.png'),
      srcPosition: spriteData?[0],
      srcSize: spriteData?[1]
    );
  }

  @override
  void render(Canvas canvas) {
    sprite?.render(canvas, size: size);
  }
}