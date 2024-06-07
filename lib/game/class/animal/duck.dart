import 'package:flame/components.dart';
import 'animal.dart';

class Duck extends Animal {
  Duck({
    required double scaleFactor,
    required SpriteAnimation animation,
    required Vector2 position,
    required bool flipped,
  }) : super(
          scaleFactor: scaleFactor,
          animation: animation,
          position: position,
          textureSize: Vector2(230 / 4, 70),
          flipped: flipped,
        );
}
