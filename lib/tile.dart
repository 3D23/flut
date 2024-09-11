import 'package:flame/components.dart';
import 'package:flut/my_game.dart';
import 'package:flut/tile_state.dart';

class Tile extends PositionComponent with HasGameReference<MyGame> {
  TileState state = TileState.none;

  Tile(this.state);
}