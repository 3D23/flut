import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flut/grid.dart';
import 'package:flut/my_game.dart';

class InteractColumn extends PositionComponent with TapCallbacks, HasGameReference<MyGame> {
  int columnNumber;

  InteractColumn(this.columnNumber);
  
  @override
  void onTapDown(TapDownEvent event) {
    Grid? grid = game.findByKey(ComponentKey.named('grid'));
    if (grid == null) {
      return;
    }
  }
}