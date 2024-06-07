import 'package:flame/components.dart';

class ItemStore {
  final double scaleFactor;
  final Sprite sprite;
  final Vector2 position;
  final Vector2 textureSize;
  final bool flipped;
  final String name;
  final double price;
  int quantity;

  ItemStore({
    required this.scaleFactor,
    required this.sprite,
    required this.position,
    required this.textureSize,
    required this.flipped,
    required this.name,
    required this.price,
    required this.quantity,
  });

  SpriteComponent createComponent() {
    SpriteComponent component = SpriteComponent()
      ..sprite = sprite
      ..size = textureSize * scaleFactor
      ..position = position;

    if (flipped) {
      component.flipHorizontally();
    }

    return component;
  }
}
