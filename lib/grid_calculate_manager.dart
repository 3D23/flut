import 'package:flut/cell.dart';
import 'package:flut/tile.dart';
import 'package:flut/tile_state.dart';
import 'package:tuple_dart/tuple.dart';

class GridManager {
  Cell findMostDownCell(List<Cell> cells) {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i].isBusy == true) {
        return cells[i - 1];
      }
    }
    return cells.last;
  }

  Cell findMostDownCellForCell(Cell cell, List<Cell> cells) {
    var yCoord = cell.coordinates![1];
    for (int i = 0; i < cells.length; i++) {
      if (i > yCoord) {
        if (cells[i].isBusy == true) {
          return cells[i - 1];
        }
      }
    }
    return cells.last;
  }

  Tuple2<Map<List<int>, TileState>, bool> getMergeInfo(List<List<Cell>> cells, Cell cell) {
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
    for (var n in neigbours) {
      if (n?.currentTile?.state == currentTile.state) {
        typeIdx++;
        if (n == downNeighbour) {
          targetCoords = n!.coordinates!;
        }
        map[n!.coordinates!] = TileState.none;
      }
    }
    if (typeIdx != currentTile.state.index) {
      map[currentCoordinates] = TileState.none;
    }
    bool isMerged = false;
    if (map.length > 1) {
      isMerged = true;
    }

    map[targetCoords] = TileState.values.firstWhere((state) => state.index == typeIdx);
    return Tuple2(map, isMerged);
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
    for (var cellRow in cells) {
      for (var cell in cellRow) {
        if (cell.coordinates![0] == coords[0] && cell.coordinates![1] == coords[1]) {
          return cell;
        }
      }
    }
    return null;
  }
}