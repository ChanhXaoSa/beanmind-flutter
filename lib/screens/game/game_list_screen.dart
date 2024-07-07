import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/models/game_animal_model.dart';
import 'package:beanmind_flutter/widgets/common/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameListScreen extends GetView<GameController> {
  const GameListScreen({Key? key}) : super(key: key);

  static const String routeName = '/game_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Obx(() {
          return controller.selectedGame.value != null
              ? AppBar(
            title: Text(controller.getGameTitle(controller.selectedGame.value!)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                controller.selectedGame.value = null;
              },
            ),
          )
              : CustomAppBar(
            title: 'Thư viện trò chơi',
            showActionIcon: false, // or true based on your requirement
          );
        }),
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
            resetAnimal();
            // Simulate a delay for loading the game
            Future.delayed(Duration(seconds: 2), () {
              controller.isLoading.value = false;
            });
          },
          child: GridTile(
            child: Image.asset(
                controller.gameThumbnailURL + controller.games[index]['image']!,
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
