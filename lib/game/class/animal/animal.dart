import 'package:flame/components.dart';

abstract class Animal {
  final double scaleFactor;
  final SpriteAnimation animation;
  final Vector2 position;
  final Vector2 textureSize;
  final bool flipped;

  Animal({
    required this.scaleFactor,
    required this.animation,
    required this.position,
    required this.textureSize,
    required this.flipped,
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
