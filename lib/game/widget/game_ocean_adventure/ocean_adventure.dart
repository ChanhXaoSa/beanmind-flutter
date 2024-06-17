import 'dart:math';
import 'package:beanmind_flutter/game/class/animal/animal.dart';
import 'package:beanmind_flutter/game/class/animal/count_animal.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';

class GameOceanAdventure extends FlameGame {
  late SpriteComponent background;

  // Scale factor for animals
  double blueFishScaleFactor = 1.0;
  double moonFishScaleFactor = 1.0;
  double octopusScaleFactor = 1.0;
  double redFishScaleFactor = 1.0;
  double violetFishScaleFactor = 1.0;

  late SpriteAnimation blueFishAnimation;
  late SpriteAnimation moonFishAnimation;
  late SpriteAnimation octopusAnimation;
  late SpriteAnimation redFishAnimation;
  late SpriteAnimation violetFishAnimation;

  bool flipped = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Background
    background = SpriteComponent()
      ..sprite = await loadSprite('background/background_ocean.png')
      ..size = size;
    add(background);

    // Load Images
    Image blueFishImage =
        await images.load('animal/blue_fish/blue_fish_idle.png');
    Image moonFishImage =
        await images.load('animal/moon_fish/moon_fish_idle.png');
    Image octopusImage = await images.load('animal/octopus/octopus_idle.png');
    Image redFishImage = await images.load('animal/red_fish/red_fish_idle.png');
    Image violetFishImage =
        await images.load('animal/violet_fish/violent_fish_idle.png');

    // Load Animations
    blueFishAnimation = SpriteAnimation.fromFrameData(
      blueFishImage,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(420 / 6, 50),
        stepTime: 0.1,
      ),
    );

    moonFishAnimation = SpriteAnimation.fromFrameData(
      moonFishImage,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(480 / 6, 60),
        stepTime: 0.1,
      ),
    );

    octopusAnimation = SpriteAnimation.fromFrameData(
      octopusImage,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(725 / 6, 90),
        stepTime: 0.1,
      ),
    );

    redFishAnimation = SpriteAnimation.fromFrameData(
      redFishImage,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(450 / 6, 50),
        stepTime: 0.1,
      ),
    );

    violetFishAnimation = SpriteAnimation.fromFrameData(
      violetFishImage,
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(460 / 6, 50),
        stepTime: 0.1,
      ),
    );

    // Create Animals
    // blueFish
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: blueFishScaleFactor,
      animation: blueFishAnimation,
      xRange: Range(0.05, 0.95),
      yRange: Range(0.05, 0.95),
      textureSize: Vector2(420 / 6, 50),
      type: 'blueFish',
    );

    // moonFish
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: moonFishScaleFactor,
      animation: moonFishAnimation,
      xRange: Range(0.05, 0.95),
      yRange: Range(0.05, 0.95),
      textureSize: Vector2(480 / 6, 60),
      type: 'moonFish',
    );

    // octopus
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: octopusScaleFactor,
      animation: octopusAnimation,
      xRange: Range(0.05, 0.95),
      yRange: Range(0.05, 0.95),
      textureSize: Vector2(725 / 6, 90),
      type: 'octopus',
    );

    // redFish
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: redFishScaleFactor,
      animation: redFishAnimation,
      xRange: Range(0.05, 0.95),
      yRange: Range(0.05, 0.95),
      textureSize: Vector2(450 / 6, 50),
      type: 'redFish',
    );

    // violetFish
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: violetFishScaleFactor,
      animation: violetFishAnimation,
      xRange: Range(0.05, 0.95),
      yRange: Range(0.05, 0.95),
      textureSize: Vector2(460 / 6, 50),
      type: 'violetFish',
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
        if (type == 'blueFish') {
          globalBlueFishCount++;
        } else if (type == 'moonFish') {
          globalMoonFishCount++;
        } else if (type == 'octopus') {
          globalOctopusCount++;
        } else if (type == 'redFish') {
          globalRedFishCount++;
        } else if (type == 'violetFish') {
          globalVioletFishCount++;
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
