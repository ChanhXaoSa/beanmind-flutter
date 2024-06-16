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
      xRange: Range(0.05, 0.45),
      yPosition: size.y * 0.7,
      textureSize: Vector2(420 / 6, 50),
      type: 'blueFish',
    );

    // moonFish
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: moonFishScaleFactor,
      animation: moonFishAnimation,
      xRange: Range(0.55, 0.95),
      yPosition: size.y * 0.7,
      textureSize: Vector2(230 / 4, 70),
      type: 'moonFish',
    );

    // octopus
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: octopusScaleFactor,
      animation: octopusAnimation,
      xRange: Range(0.05, 0.45),
      yPosition: size.y * 0.5,
      textureSize: Vector2(725 / 6, 90),
      type: 'octopus',
    );

    // redFish
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: redFishScaleFactor,
      animation: redFishAnimation,
      xRange: Range(0.55, 0.95),
      yPosition: size.y * 0.5,
      textureSize: Vector2(450 / 6, 50),
      type: 'redFish',
    );

    // violetFish
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: violetFishScaleFactor,
      animation: violetFishAnimation,
      xRange: Range(0.05, 0.45),
      yPosition: size.y * 0.3,
      textureSize: Vector2(460 / 6, 50),
      type: 'violetFish',
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
