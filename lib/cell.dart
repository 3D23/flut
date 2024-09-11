import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';

class Cell extends PositionComponent {
  Sprite? sprite;
  bool isBusy = false;

  Cell(size, position) {
    super.size = size;
    super.position = position;
  }

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(Flame.images.fromCache('cellPng.png'));
  }
  
  @override
  void render(Canvas canvas) {
    sprite?.render(canvas, size: super.size);
  }
}