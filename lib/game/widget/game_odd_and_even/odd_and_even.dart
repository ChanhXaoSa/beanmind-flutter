import 'dart:math';
import 'package:beanmind_flutter/game/class/animal/animal.dart';
import 'package:beanmind_flutter/game/class/animal/count_animal.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';

class GameOddAndEven extends FlameGame {
  late SpriteComponent background;

  // Scale factor for animals
  double blueBirdScaleFactor = 1.2;
  double redBirdScaleFactor = 1.2;

  late SpriteAnimation blueBirdAnimation;
  late SpriteAnimation redBirdAnimation;

  bool flipped = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Background
    background = SpriteComponent()
      ..sprite = await loadSprite('background/background_odd_and_even.png')
      ..size = size;
    add(background);

    // Load Images
    Image blueBirdIdleImage = await images.load('animal/blue_bird/blue_bird_ilde.png');
    Image redBirdIdleImage = await images.load('animal/red_bird/red_bird_idle.png');

    // Load Animations

    blueBirdAnimation = SpriteAnimation.fromFrameData(
      blueBirdIdleImage,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(470 / 6, 103),
        stepTime: 0.1,
      ),
    );

    redBirdAnimation = SpriteAnimation.fromFrameData(
      redBirdIdleImage,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(466 / 6, 100),
        stepTime: 0.1,
      ),
    );


    // Create Animals
    // blue bird
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: blueBirdScaleFactor,
      animation: blueBirdAnimation,
      xRange: Range(0.55, 0.95),
      yPosition: size.y * 0.5,
      textureSize: Vector2(470 / 6, 103),
      type: 'blueBird',
    );

    // red bird
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: redBirdScaleFactor,
      animation: redBirdAnimation,
      xRange: Range(0.05, 0.45),
      yPosition: size.y * 0.5,
      textureSize: Vector2(466 / 6, 100),
      type: 'redBird',
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
        if (type == 'blueBird') {
          globalBlueBirdCount++;
        } else if (type == 'redBird') {
          globalRedBirdCount++;
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
