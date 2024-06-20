import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/game/class/animal/count_animal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameListScreen extends GetView<GameController> {
  const GameListScreen({Key? key}) : super(key: key);

  static const String routeName = '/game_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.selectedGame.value != null
            ? controller.getGameTitle(controller.selectedGame.value!)
            : 'Thư viện trò chơi')),
        leading: Obx(() => controller.selectedGame.value != null
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            controller.selectedGame.value = null;
          },
        )
            : Container()),
      ),
      body: Obx(() => controller.isLoading.value
          ? _buildLoadingIndicator()
          : controller.selectedGame.value != null
          ? controller.buildGameWidget(controller.selectedGame.value!)
          : _buildGameGrid()),
      backgroundColor: Colors.blue[100],
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildGameGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 16 / 9,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: controller.games.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controller.isLoading.value = true;
            controller.selectedGame.value = controller.games[index]['gameType'];
            // Simulate a delay for loading the game
            Future.delayed(Duration(seconds: 2), () {
              controller.isLoading.value = false;
              resetAnimal();
            });
          },
          child: GridTile(
            child: Image.asset(controller.gameThumbnailURL + controller.games[index]['image']!,
                fit: BoxFit.cover),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(controller.games[index]['title']!),
            ),
          ),
        );
      },
    );
  }
}