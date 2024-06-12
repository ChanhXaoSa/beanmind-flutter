import 'dart:math';
import 'package:beanmind_flutter/game/class/animal/animal.dart';
import 'package:beanmind_flutter/game/class/animal/blue_bird.dart';
import 'package:beanmind_flutter/game/class/animal/count_animal.dart';
import 'package:beanmind_flutter/game/class/animal/red_bird.dart';
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
      count: Random().nextInt(5) + 1,
      scaleFactor: blueBirdScaleFactor,
      animation: blueBirdAnimation,
      textureSize: Vector2(470 / 6, 103),
      animalType: 'blueBird',
      createAnimal: (position, flipped) => BlueBird(
        scaleFactor: blueBirdScaleFactor,
        animation: blueBirdAnimation,
        position: position,
        flipped: flipped,
      ),
    );

    // red bird
    createAnimals(
      count: Random().nextInt(5) + 1,
      scaleFactor: redBirdScaleFactor,
      animation: redBirdAnimation,
      textureSize: Vector2(466 / 6, 100),
      animalType: 'redBird',
      createAnimal: (position, flipped) => RedBird(
        scaleFactor: redBirdScaleFactor,
        animation: redBirdAnimation,
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
    double maxY = size.y - textureSize.y * scaleFactor - 200;

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

      if (animalType == 'blueBird') {
        globalBlueBirdCount++;
      } else if (animalType == 'redBird') {
        globalRedBirdCount++;
      }

      add(animal.createComponent());
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}