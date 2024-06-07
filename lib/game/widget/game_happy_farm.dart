import 'dart:math';
import 'package:beanmind_flutter/game/class/animal/animal.dart';
import 'package:beanmind_flutter/game/class/animal/chicken.dart';
import 'package:beanmind_flutter/game/class/animal/duck.dart';
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
    Image chickenIdleImage = await images.load('animal/chicken/chicken_idle.png');
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
      yPosition: 600,
      textureSize: Vector2(32, 34),
      createAnimal: (position, flipped) => Chicken(
        scaleFactor: chickenIdleScaleFactor,
        animation: chickenIdleAnimation,
        position: position,
        flipped: flipped,
      ),
    );

    createAnimals(
      count: Random().nextInt(10) + 1,
      scaleFactor: duckIdleScaleFactor,
      animation: duckIdleAnimation,
      yPosition: 600,
      textureSize: Vector2(230 / 4, 70),
      createAnimal: (position, flipped) => Duck(
        scaleFactor: duckIdleScaleFactor,
        animation: duckIdleAnimation,
        position: position,
        flipped: flipped,
      ),
    );
  }

  void createAnimals({
    required int count,
    required double scaleFactor,
    required SpriteAnimation animation,
    required double yPosition,
    required Vector2 textureSize,
    required Animal Function(Vector2 position, bool flipped) createAnimal,
  }) {
    double chickenXPosition = 100; // Starting x position for chickens
    double duckXPosition = 100; // Starting x position for ducks
    double gap = 80; // Fixed gap between animals of the same species

    for (int i = 0; i < count; i++) {
      bool flip = Random().nextBool();
      Animal animal;

      if (animation == chickenIdleAnimation) {
        animal = createAnimal(Vector2(chickenXPosition, yPosition), flip);
        chickenXPosition += gap;
      } else {
        animal = createAnimal(Vector2(duckXPosition+ 800, yPosition), flip);
        duckXPosition += gap;
      }

      add(animal.createComponent());
      
      // Ensure xPosition is within bounds
      if (chickenXPosition > 1000) {
        chickenXPosition = 1000;
      }
      if (duckXPosition > 1000) {
        duckXPosition = 1000;
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
