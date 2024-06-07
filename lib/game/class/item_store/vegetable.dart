import 'package:flame/components.dart';
import 'item_store.dart';

class Vegetable extends ItemStore {
  Vegetable({
    required double scaleFactor,
    required Sprite sprite,
    required Vector2 position,
    required bool flipped,
    required String name,
    required double price,
    required int quantity,
  }) : super(
          scaleFactor: scaleFactor,
          sprite: sprite,
          position: position,
          textureSize: Vector2(53, 56),
          flipped: flipped,
          name: name,
          price: price,
          quantity: quantity,
        );
}
