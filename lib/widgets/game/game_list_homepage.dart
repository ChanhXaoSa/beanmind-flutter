import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../home/homepage_course_card.dart';

class GameListHomepage extends GetView<GameController> {
  const GameListHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.shouldReset.value) {
        controller.selectedGame.value = null;
        controller.shouldReset.value = false;
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Danh sách trò chơi',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  controller.navigateToGameList();
                },
                child: const Text('Xem tất cả'),
              ),
            ],
          ),
        ),
        Obx(() {
          if (controller.isLoading.value) {
            return Shimmer.fromColors(
              baseColor: Colors.white.withOpacity(0.4),
              highlightColor: Colors.blueGrey.withOpacity(0.1),
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                  ],
                ),
              ),
            );
          } else if (controller.games.isEmpty) {
            return const Center(child: Text("Không có trò chơi nào."));
          } else {
            final games = controller.games;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: games.map((game) => GameCardWidget(game, controller: controller,)).toList(),
              ),
            );
          }
        }),
      ],
    );
  }
}

class GameCardWidget extends StatelessWidget {
  final dynamic game;
  final GameController controller;

  const GameCardWidget(this.game, {required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        width: 285,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                controller.selectedGame.value = game['id'];
                Get.to(() => controller.buildGameWidget(game['id']));
              },
              child: Stack(
                children: [
                  ClipRRect(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/background/background.png',
                      image: game['image']!,
                      fit: BoxFit.cover,
                      height: 200,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/background/background.png',
                          fit: BoxFit.cover,
                          height: 200,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        game['name'] ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                controller.selectedGame.value = game['id'];
                Get.to(() => controller.buildGameWidget(game['id']));
              },
              child: Container(
                height: 60,
                child: Text(
                  game['name'] ?? '',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: Text(
                game['description'] ?? '',
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


