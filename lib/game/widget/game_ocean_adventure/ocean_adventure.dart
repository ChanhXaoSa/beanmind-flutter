import 'dart:math';
import 'package:beanmind_flutter/game/class/animal/animal.dart';
import 'package:beanmind_flutter/game/class/animal/blue_fish.dart';
import 'package:beanmind_flutter/game/class/animal/moon_fish.dart';
import 'package:beanmind_flutter/game/class/animal/octopus.dart';
import 'package:beanmind_flutter/game/class/animal/red_fish.dart';
import 'package:beanmind_flutter/game/class/animal/violet_fish.dart';
import 'package:beanmind_flutter/game/utils/count_animal.dart';
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
      textureSize: Vector2(420 / 6, 50),
      animalType: 'blueFish',
      createAnimal: (position, flipped) => BlueFish(
        scaleFactor: blueFishScaleFactor,
        animation: blueFishAnimation,
        position: position,
        flipped: flipped,
      ),
    );

    // moonFish
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: moonFishScaleFactor,
      animation: moonFishAnimation,
      textureSize: Vector2(480 / 6, 60),
      animalType: 'moonFish',
      createAnimal: (position, flipped) => MoonFish(
        scaleFactor: moonFishScaleFactor,
        animation: moonFishAnimation,
        position: position,
        flipped: flipped,
      ),
    );

    // octopus
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: octopusScaleFactor,
      animation: octopusAnimation,
      textureSize: Vector2(725 / 6, 90),
      animalType: 'octopus',
      createAnimal: (position, flipped) => Octopus(
        scaleFactor: octopusScaleFactor,
        animation: octopusAnimation,
        position: position,
        flipped: flipped,
      ),
    );

    // redFish
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: redFishScaleFactor,
      animation: redFishAnimation,
      textureSize: Vector2(450 / 6, 50),
      animalType: 'redFish',
      createAnimal: (position, flipped) => RedFish(
        scaleFactor: redFishScaleFactor,
        animation: redFishAnimation,
        position: position,
        flipped: flipped,
      ),
    );

    // violetFish
    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: violetFishScaleFactor,
      animation: violetFishAnimation,
      textureSize: Vector2(460 / 6, 60),
      animalType: 'violetFish',
      createAnimal: (position, flipped) => VioletFish(
        scaleFactor: violetFishScaleFactor,
        animation: violetFishAnimation,
        position: position,
        flipped: flipped,
      ),
    );
  }

  void createAnimals({
    required int count,
    required double scaleFactor,
    required SpriteAnimation animation,
    required Vector2 textureSize,
    required String animalType,
    required Animal Function(Vector2 position, bool flipped) createAnimal,
  }) {
    Random random = Random();
    double maxX = size.x - textureSize.x * scaleFactor;
    double maxY = size.y - textureSize.y * scaleFactor;

    double minX =
        textureSize.x * scaleFactor; // Đảm bảo không vượt quá mép trái màn hình
    double minY =
        textureSize.y * scaleFactor; // Đảm bảo không vượt quá mép trên màn hình

    for (int i = 0; i < count; i++) {
      double x = random.nextDouble() * (maxX - minX) +
          minX; // Giới hạn khu vực xung quanh
      double y = random.nextDouble() * (maxY - minY) +
          minY; // Giới hạn khu vực xung quanh
      bool flipped = random.nextBool();

      Animal animal = createAnimal(
        Vector2(x, y),
        flipped,
      );

      if (animalType == 'blueFish') {
        globalBlueFishCount++;
      } else if (animalType == 'moonFish') {
        globalMoonFishCount++;
      } else if (animalType == 'octopus') {
        globalOctopusCount++;
      } else if (animalType == 'redFish') {
        globalRedFishCount++;
      } else if (animalType == 'violetFish') {
        globalVioletFishCount++;
      }

      add(animal.createComponent());
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
