import 'package:flame/components.dart';
import 'package:flut/tile.dart';

class TileContainer extends PositionComponent {
  int number;
  Tile? currentTile;

  TileContainer(this.number);

  addTile(Tile tile) {
    currentTile = tile;
    add(currentTile!);
  }

  clear() {
    currentTile = null;
  }
}