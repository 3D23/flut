import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flut/grid.dart';
import 'package:flut/interact_column.dart';
import 'package:flut/game_data.dart';
import 'package:flut/tile.dart';
import 'package:flut/tile_state_generator.dart';

class MyGame extends FlameGame {
  static const int countColumn = 5;
  List<InteractColumn> interactColumns = [];
  Tile? currentTile;
@override
  bool get debugMode => true;

  final _grid = Grid(countColumn)
  ..size = Vector2(600, 600)
  ..position = Vector2(100, 200);

  TileGenerator? _generator; 

  @override
  FutureOr<void> onLoad() async {
    await Flame.images.loadAll(loadImages);
    add(_grid);
    for (var i = 0; i < countColumn; i++){
      var interactColumn = InteractColumn(i)
      ..size = Vector2(600 / countColumn, size.y)
      ..position = Vector2(100 + ((600 / countColumn) * i), 0);

      interactColumns.add(interactColumn);
      add(interactColumn);
    }
    _generator = TileGenerator()
    ..position = Vector2(100 + (600 / (countColumn / 2)), 50)
    ..size = _grid.size / (countColumn).toDouble();

    add(_generator as Component);
    currentTile = Tile(TileStateGenrator.generate());
  }

  @override
  Color backgroundColor() => const Color.fromARGB(255, 179, 190, 187);
}