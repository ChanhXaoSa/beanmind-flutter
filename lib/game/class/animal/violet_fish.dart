import 'package:flame/components.dart';
import 'animal.dart';

class VioletFish extends Animal {
  VioletFish({
    required double scaleFactor,
    required SpriteAnimation animation,
    required Vector2 position,
    required bool flipped,
  }) : super(
          scaleFactor: scaleFactor,
          animation: animation,
          position: position,
          textureSize: Vector2(460 / 6, 50),
          flipped: flipped,
        );
}
