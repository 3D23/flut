import 'dart:async';
import 'package:flame/components.dart';
import 'package:flut/grid_calculate_manager.dart';
import 'package:flut/my_game.dart';
import 'package:flut/tile.dart';
import 'package:flut/tile_generator.dart';
import 'package:flut/tile_state.dart';
import 'cell.dart';

class Grid extends PositionComponent with HasGameReference<MyGame> {
  int countCells;
  List<List<Cell>> cells = [];

  final GridManager _manager = GridManager();

  @override
  ComponentKey? get key => ComponentKey.named("grid");

  Grid(this.countCells);

  @override 
  FutureOr<void> onLoad() {
    _instanceCells(countCells);
  }

  void _instanceCells(int countCells) {
    for (var i = 0; i < countCells; i++) {
      cells.add([]);
      for (var j = 0; j < countCells; j++) {
        Cell cell = Cell(i, j, size / (countCells - 0.2).toDouble(), Vector2(i * (width / countCells), j * (height / countCells)));
        add(cell);
        cells[i].add(cell);
      }
    }
  }

  void pushTile(int numberOfColumn, Tile? tile) {
    Cell targetCell = _manager.findCorrectCell(cells[numberOfColumn]);
    targetCell.addTile(tile!);
    // _merge(_manager.getMergeInfo(cells, targetCell));
  }

  void _merge(Map<List<int>, TileState> mergeData) {
    mergeData.forEach((key, value) {
      if (value == TileState.none) {
        _manager.findCellByCoords(key, cells)!.clear();
      }
      else {
        Cell? targetCell = _manager.findCellByCoords(key, cells)!;
        targetCell.clear();
        targetCell.addTile((game
          .findByKeyName(ComponentKey.named('tileGen') as String) as TileGenerator)
          .createTile(value));
      }
    });
  }
}