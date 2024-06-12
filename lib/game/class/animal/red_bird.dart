import 'package:flame/components.dart';
import 'animal.dart';

class RedBird extends Animal {
  RedBird({
    required double scaleFactor,
    required SpriteAnimation animation,
    required Vector2 position,
    required bool flipped,
  }) : super(
          scaleFactor: scaleFactor,
          animation: animation,
          position: position,
          textureSize: Vector2(466/6, 100),
          flipped: flipped,
        );
}
