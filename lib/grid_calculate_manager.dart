import 'package:flut/cell.dart';

class GridManager {
  Cell findCorrectCell(List<Cell> cells) {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i].isBusy == true) {
        return cells[i - 1];
      }
    }
    return cells.last;
  }

  void mergeCells(List<List<Cell>> cells, Cell cell){

  }
}