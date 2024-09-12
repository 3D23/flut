import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flut/interact_column.dart';
import 'package:flut/my_game.dart';
import 'package:flut/tile.dart';
import 'package:flut/tile_state.dart';
import 'package:flut/tile_state_generator.dart';

class TileGenerator extends PositionComponent 
  with Notifier, 
    HasGameRef<MyGame> {
  Sprite? sprite;
  final TileStateGenrator generator = TileStateGenrator();
  Tile? lastGeneratedTile;
  
  @override
  ComponentKey? get key => ComponentKey.named("tileGen");
  
  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(Flame.images.fromCache("generatorView.png"));
    _generate();
    
    // ignore: unused_local_variable
    final interactColumnNotifier = gameRef.componentsNotifier<InteractColumn>()
      ..addListener(() { 
        _generate();
        _removeTile();
      } );
    

  }

  @override
  void render(Canvas canvas) {
    sprite?.render(canvas, size: size);
    if (lastGeneratedTile != null) {
      add(lastGeneratedTile as Component);
      lastGeneratedTile = null;
    }
  }

  void _generate() {
    TileState state = generator.generate();
    Tile tile = createTile(state); 
    lastGeneratedTile = tile;
    notifyListeners();
  }

  Tile createTile(TileState state) {
    return Tile(state) 
      ..size = size * 0.93
      ..position = size / 2
      ..anchor = Anchor.center; 
  }

  void _removeTile() {
    if (children.isNotEmpty) {
      remove(children.first);
    }
  }
}