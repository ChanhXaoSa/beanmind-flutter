import 'package:flame/components.dart';

class Animal {
  final double scaleFactor;
  final SpriteAnimation animation;
  final Vector2 position;
  final Vector2 textureSize;
  final bool flipped;
  final String type;

  Animal({
    required this.scaleFactor,
    required this.animation,
    required this.position,
    required this.textureSize,
    required this.flipped,
    required this.type,
  });

  SpriteAnimationComponent createComponent() {
    SpriteAnimationComponent component = SpriteAnimationComponent()
      ..animation = animation
      ..size = textureSize * scaleFactor
      ..position = position;

    if (flipped) {
      component.flipHorizontally();
    }
    return component;
  }
}
