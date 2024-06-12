import 'package:flame/components.dart';
import 'animal.dart';

class BlueBird extends Animal {
  BlueBird({
    required double scaleFactor,
    required SpriteAnimation animation,
    required Vector2 position,
    required bool flipped,
  }) : super(
          scaleFactor: scaleFactor,
          animation: animation,
          position: position,
          textureSize: Vector2(470/6, 103),
          flipped: flipped,
        );
}
