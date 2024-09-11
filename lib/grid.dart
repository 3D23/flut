import 'dart:async';
import 'package:flame/components.dart';
import 'package:flut/grid_calculate_manager.dart';
import 'package:flut/my_game.dart';
import 'package:flut/tile.dart';
import 'cell.dart';

class Grid extends PositionComponent with HasGameReference<MyGame> {
  int countCells;
  List<List<Cell>> cells = [];
  final GridCalculateManager _calculateManager = GridCalculateManager();

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
    Cell targetCell = _calculateManager.findCorrectCell(cells[numberOfColumn]);
    targetCell.addTile(tile!);
  }
}