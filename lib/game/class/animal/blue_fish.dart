import 'package:flame/components.dart';
import 'animal.dart';

class BlueFish extends Animal {
  BlueFish({
    required double scaleFactor,
    required SpriteAnimation animation,
    required Vector2 position,
    required bool flipped,
  }) : super(
          scaleFactor: scaleFactor,
          animation: animation,
          position: position,
          textureSize: Vector2(420/6, 50),
          flipped: flipped,
        );
}
