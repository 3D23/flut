import 'package:flut/cell.dart';
import 'package:flut/tile.dart';
import 'package:flut/tile_state.dart';

class GridManager {
  Cell findCorrectCell(List<Cell> cells) {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i].isBusy == true) {
        return cells[i - 1];
      }
    }
    return cells.last;
  }

  Map<List<int>, TileState> getMergeInfo(List<List<Cell>> cells, Cell cell) {
    Map<List<int>, TileState> map = {};
    Tile currentTile = cell.currentTile!;
    int typeIdx = currentTile.state.index;
    List<int> currentCoordinates = cell.coordinates!;
    List<int> targetCoords = currentCoordinates;
    Cell? leftNeighbour =
      findCellByCoords([currentCoordinates[0] - 1, currentCoordinates[1]], cells);
    Cell? rightNeighbour = 
      findCellByCoords([currentCoordinates[0] + 1, currentCoordinates[1]], cells);
    Cell? downNeighbour = 
      findCellByCoords([currentCoordinates[0], currentCoordinates[1] + 1], cells);
    List<Cell?> neigbours = [leftNeighbour, rightNeighbour, downNeighbour];
    map[currentCoordinates] = TileState.none;
    for (var n in neigbours) {
      if (n?.currentTile?.state == currentTile.state) {
        typeIdx++;
        if (n == downNeighbour) {
          targetCoords = n!.coordinates!;
        }
      }
      map[n!.coordinates!] = TileState.none;
    }
    map[targetCoords] = typeIdx as TileState;
    return map;
  }

  Cell? findCellByCoords(List<int> coords, List<List<Cell>> cells) {
    int maxX = cells.length - 1;
    int maxY = cells.first.length - 1;
    if (coords[0] < 0 || 
    coords[0] > maxX || 
    coords[1] < 0 || 
    coords[1] > maxY) {
      return null;
    }
    return List.from(cells)
    .firstWhere((c) => 
      (c as Cell).coordinates![0] == coords[0] && 
      c.coordinates![1] == coords[1]);
  }
}