import 'package:flame/components.dart';
import 'animal.dart';

class Octopus extends Animal {
  Octopus({
    required double scaleFactor,
    required SpriteAnimation animation,
    required Vector2 position,
    required bool flipped,
  }) : super(
          scaleFactor: scaleFactor,
          animation: animation,
          position: position,
          textureSize: Vector2(725 / 6, 90),
          flipped: flipped,
        );
}
