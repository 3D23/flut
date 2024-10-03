import 'package:flame/components.dart';
import 'package:flut/tile.dart';

class TileContainer extends PositionComponent {
  int number;
  Tile? currentTile;

  TileContainer(this.number);

  void addTile(Tile tile) {
    if (currentTile == null) {
      currentTile = tile;
      add(currentTile!);
    }
  }

  void clear() {
    if (currentTile != null) {
      currentTile = null;
    }
  }
}