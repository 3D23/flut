import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flut/tile.dart';
import 'package:flutter/material.dart';

class Cell extends PositionComponent {
  Sprite? sprite;
  bool? _isBusy;
  List<int>? coordinates;
  Tile? currentTile;

  bool? get isBusy => _isBusy;

  Cell(int x, int y, size, position) {
    super.size = size;
    super.position = position;
    coordinates = [x, y];
    _isBusy = false;
  }

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(Flame.images.fromCache('cellPng.png'));
  }
  
  @override
  void render(Canvas canvas) {
    sprite?.render(canvas, size: super.size);
    if (children.isEmpty && currentTile != null) {
      add(currentTile! ..position = size / 2 ..anchor = Anchor.center);
    }
  }

  void addTile(Tile tile) {
    currentTile = tile;
    _isBusy = true;
  }

  void clear() {
    if (_isBusy == true) {
      currentTile = null;
      _isBusy = false;
      if (children.isNotEmpty && currentTile == null) {
        remove(children.first);
      }
    }
  }

  void d() {
    debugColor = Colors.black54;
    debugPrint(coordinates.toString());
  }
}