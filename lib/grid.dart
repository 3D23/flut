import 'dart:async';
import 'package:flame/components.dart';
import 'package:flut/grid_calculate_manager.dart';
import 'package:flut/my_game.dart';
import 'package:flut/tile.dart';
import 'package:flut/tile_generator.dart';
import 'package:flut/tile_state.dart';
import 'package:flutter/foundation.dart';
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

  @override
  void update(double dt) {
    _executeLoop();
  }

  void pushTile(int numberOfColumn, Tile? tile) {
    Cell targetCell = _manager.findMostDownCell(cells[numberOfColumn]);
    targetCell.addTile(tile!);
    _mergeForCurrentCell(targetCell);
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

  Cell? _merge(Map<List<int>, TileState> mergeData) {
    Cell? cell;
    mergeData.forEach((key, value) {
      if (value == TileState.none) {
        _manager.findCellByCoords(key, cells)!.clear();
      }
      else {
        Cell? targetCell = _manager.findCellByCoords(key, cells)!;
        targetCell.clear();
        targetCell.addTile((game
          .findByKey(ComponentKey.named('tileGen')) as TileGenerator)
          .createTile(value));
        cell = targetCell;
      }
    });
    debugPrint(cell?.coordinates.toString());
    return cell;
  }

  void _mergeForCurrentCell(Cell targetCell) {
    bool isRepeat = false;
    Cell mergeCell = targetCell;
    do {
      isRepeat = false;
      if (mergeCell.currentTile != null) {
        if (_manager.getMergeInfo(cells, mergeCell).item2 == true) {
          Cell? cell = _merge(_manager.getMergeInfo(cells, mergeCell).item1);
          if (cell != null) {
            isRepeat = true;
            mergeCell = cell;
          }
        }
      }
    } while (isRepeat);
  } 

  void _mergeForAllCell() {
    bool isRepeat = false;
    do {
      isRepeat = false;
      for (var cellRow in cells) {
        for (var cell in cellRow) {
          if (cell.currentTile != null) {
            var mergeInfo = _manager.getMergeInfo(cells, cell);
            if (mergeInfo.item2 == true) {
              isRepeat = true;
              _mergeForCurrentCell(cell);
            }
          }
        }
      }
    } while (isRepeat);
  }

  void _executeLoop() {
    _mergeForAllCell();
    _executeFallLoop();
  }

  void _executeFallLoop() {
    for (var i = 0; i < cells.length; i++) {
      var row = cells[i];
      for (var cell in row.reversed) {
        Cell mostDownCell = _manager.findMostDownCellForCell(cell, row);
        if (mostDownCell.coordinates![1] > cell.coordinates![1]) {
          if (cell.currentTile != null) {
            var tile = cell.currentTile;
            cell.clear();
            mostDownCell.addTile(tile!);
          }
        }
      }
    }
  }
}