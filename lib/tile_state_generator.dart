import 'dart:math';
import 'package:flut/tile_state.dart';

class TileStateGenrator {

  static TileState generate() {
    int value = Random().nextInt(3) + 1;
    for (var state in TileState.values) {
      if (state.index == value) {
        return state;
      }
    }
    return TileState.none;
  }
}