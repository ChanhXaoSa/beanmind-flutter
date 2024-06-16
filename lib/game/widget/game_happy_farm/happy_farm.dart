import 'dart:math';
import 'package:beanmind_flutter/game/class/animal/animal.dart';
import 'package:beanmind_flutter/game/class/animal/count_animal.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';

class HappyFarm extends FlameGame {
  late SpriteComponent background;

  double chickenIdleScaleFactor = 2.0;
  double duckIdleScaleFactor = 1.0;

  late SpriteAnimation chickenIdleAnimation;
  late SpriteAnimation duckIdleAnimation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Background
    background = SpriteComponent()
      ..sprite = await loadSprite('background/background_farm.png')
      ..size = size;
    add(background);

    // Load Images
    Image chickenIdleImage =
        await images.load('animal/chicken/chicken_idle.png');
    Image duckIdleImage = await images.load('animal/duck/duck_stand.png');

    // Load Animations
    chickenIdleAnimation = SpriteAnimation.fromFrameData(
      chickenIdleImage,
      SpriteAnimationData.sequenced(
        amount: 13,
        textureSize: Vector2(32, 34),
        stepTime: 0.05,
      ),
    );

    duckIdleAnimation = SpriteAnimation.fromFrameData(
      duckIdleImage,
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2(230 / 4, 70),
        stepTime: 0.2,
      ),
    );

    // Create Animals
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: chickenIdleScaleFactor,
      animation: chickenIdleAnimation,
      xRange: Range(0.05, 0.45),
      yPosition: size.y * 0.7,
      textureSize: Vector2(32, 34),
      type: 'chicken',
    );

    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: duckIdleScaleFactor,
      animation: duckIdleAnimation,
      xRange: Range(0.55, 0.95),
      yPosition: size.y * 0.7,
      textureSize: Vector2(230 / 4, 70),
      type: 'duck',
    );
  }

  void createAnimals({
    required int count,
    required double scaleFactor,
    required SpriteAnimation animation,
    required Range xRange,
    required double yPosition,
    required Vector2 textureSize,
    required String type,
  }) {
    double screenWidth = size.x;
    double xStart = screenWidth *
        (xRange.start + 0.05); // Starting x position with 5% border
    double xEnd =
        screenWidth * (xRange.end - 0.05); // Ending x position with 5% border

    // Ensure the gap accounts for the size of the animals and scaleFactor
    double gap = (xEnd - xStart) / (count - 1);
    double minGap = textureSize.x * scaleFactor;

    if (gap < minGap) {
      gap = minGap;
    }

    for (int i = 0; i < count; i++) {
      // Check if the animal exceeds the screen boundaries
      if (xStart >= 0 && xStart + textureSize.x * scaleFactor <= screenWidth) {
        bool flip = Random().nextBool();
        Animal animal = Animal(
          scaleFactor: scaleFactor,
          animation: animation,
          textureSize: textureSize,
          position: Vector2(xStart, yPosition),
          flipped: flip,
          type: type,
        );
        if (type == 'chicken') {
          globalChickenCount++;
        } else if (type == 'duck') {
          globalDuckCount++;
        }
        add(animal.createComponent());
      }
      xStart += gap;

      // Ensure xStart is within bounds
      if (xStart > xEnd) {
        break; // Exit the loop if the animals exceed the specified x-range
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}

class Range {
  final double start;
  final double end;

  Range(this.start, this.end);
}
