import 'package:flame/components.dart';
import 'animal.dart';

class RedFish extends Animal {
  RedFish({
    required double scaleFactor,
    required SpriteAnimation animation,
    required Vector2 position,
    required bool flipped,
  }) : super(
          scaleFactor: scaleFactor,
          animation: animation,
          position: position,
          textureSize: Vector2(450 / 6, 50),
          flipped: flipped,
        );
}
