import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flut/grid.dart';
import 'package:flut/my_game.dart';
import 'package:flut/tile_container.dart';

class InteractColumn extends PositionComponent with HoverCallbacks, TapCallbacks, HasGameReference<MyGame>, Notifier {
  int columnNumber;
  Sprite? spriteCanBePushTileCache;
  Sprite? spriteNotCanBePushTileCache;
  Sprite? sprite;
  TileContainer? container;

  InteractColumn(this.columnNumber);

  @override
  FutureOr<void> onLoad() {
    spriteCanBePushTileCache = Sprite(Flame.images.fromCache('canBePushTile.png'));
    spriteNotCanBePushTileCache = Sprite(Flame.images.fromCache('notCanBePushTile.png'));
    container = game.children
      .query<TileContainer>()
      .firstWhere((c) => c.number == columnNumber) as TileContainer?;
  }
  
  @override
  void onTapDown(TapDownEvent event) {
    Grid? grid = game.findByKey(ComponentKey.named('grid'));
    grid?.pushTile(columnNumber, game.currentTile);
    notifyListeners();
  }

  @override
  void render(Canvas canvas) {
    if (sprite != null) {
      sprite!.render(canvas, size:size);
    }
    if (isHovered) {
      container?.addTile(game.currentTile!);
    }
  }

  @override
  void onHoverEnter() {
    sprite = spriteCanBePushTileCache;
  }

  @override
  void onHoverExit() {
    sprite = null;
  }
  
}