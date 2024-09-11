import 'package:flame/game.dart';

//images
List<String> loadImages = [
  'cellPng.png', 
  'generatorView.png',
  'tilesSpriteAsset.png'
];

//tileSpriteAsset
Map<int, List<Vector2>> tilesSpriteAssetMap = {
  2: [Vector2(0, 0), Vector2.all(220)],
  4: [Vector2(236, 0), Vector2.all(220)],
  8: [Vector2(472, 0), Vector2.all(220)],
  16: [Vector2(708, 0), Vector2.all(220)],
  32: [Vector2(0, 240), Vector2.all(220)],
  64: [Vector2(236, 240), Vector2.all(220)],
  128: [Vector2(472, 240), Vector2.all(220)],
  256: [Vector2(708, 240), Vector2.all(220)],
  512: [Vector2(0, 480), Vector2.all(220)],
  1024: [Vector2(236, 480), Vector2.all(220)]
};