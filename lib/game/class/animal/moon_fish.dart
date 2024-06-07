import 'package:flame/components.dart';
import 'animal.dart';

class MoonFish extends Animal {
  MoonFish({
    required double scaleFactor,
    required SpriteAnimation animation,
    required Vector2 position,
    required bool flipped,
  }) : super(
          scaleFactor: scaleFactor,
          animation: animation,
          position: position,
          textureSize: Vector2(480 / 6, 60),
          flipped: flipped,
        );
}
