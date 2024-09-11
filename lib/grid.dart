import 'dart:async';
import 'package:flame/components.dart';
import 'cell.dart';

class Grid extends PositionComponent {
  int countCells;
  List<List<Cell>> cells = [];

  Grid(this.countCells);

  @override 
  FutureOr<void> onLoad() {
    _instanceCells(countCells);
  }

  void _instanceCells(int countCells) {
    for (var i = 0; i < countCells; i++) {
      cells.add([]);
      for (var j = 0; j < countCells; j++) {
        Cell cell = Cell(size / (countCells - 0.2).toDouble(), Vector2(i * (width / countCells), j * (height / countCells)));
        add(cell);
        cells[i].add(cell);
      }
    }
  }
}