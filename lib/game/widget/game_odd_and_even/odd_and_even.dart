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
    Image blueBirdIdleImage =
        await images.load('animal/blue_bird/blue_bird_ilde.png');
    Image redBirdIdleImage =
        await images.load('animal/red_bird/red_bird_idle.png');

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
      xRange: Range(0.05, 0.95),
      yRange: Range(0.05, 0.95),
      textureSize: Vector2(470 / 6, 103),
      type: 'blueBird',
    );

    // red bird
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: redBirdScaleFactor,
      animation: redBirdAnimation,
      xRange: Range(0.05, 0.95),
      yRange: Range(0.05, 0.95),
      textureSize: Vector2(466 / 6, 100),
      type: 'redBird',
    );
  }

  void createAnimals({
    required int count,
    required double scaleFactor,
    required SpriteAnimation animation,
    required Range xRange,
    required Range yRange,
    required Vector2 textureSize,
    required String type,
  }) {
    double screenWidth = size.x;
    double screenHeight = size.y;
    double minGap = 60.0; // Minimum gap between animals

    List<Vector2> positions = [];

    for (int i = 0; i < count; i++) {
      Vector2 position;
      bool validPosition;

      // Find a valid random position for the current animal
      do {
        validPosition = true;

        // Generate random position within the specified ranges
        double x =
            Random().nextDouble() * (xRange.end - xRange.start) + xRange.start;
        double y =
            Random().nextDouble() * (yRange.end - yRange.start) + yRange.start;

        // Adjust position to screen dimensions and scale
        double xPosition = screenWidth * x;
        double yPosition = screenHeight * y;

        position = Vector2(xPosition, yPosition);

        // Check if the new position is at least minGap away from existing positions
        for (Vector2 existingPosition in positions) {
          if ((position - existingPosition).length < minGap) {
            validPosition = false;
            break;
          }
        }
      } while (!validPosition);

      positions.add(position);

      // Check if the animal exceeds the screen boundaries
      if (position.x >= 0 &&
          position.x + textureSize.x * scaleFactor <= screenWidth &&
          position.y >= 0 &&
          position.y + textureSize.y * scaleFactor <= screenHeight) {
        bool flip = Random().nextBool();
        Animal animal = Animal(
          scaleFactor: scaleFactor,
          animation: animation,
          textureSize: textureSize,
          position: position,
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
