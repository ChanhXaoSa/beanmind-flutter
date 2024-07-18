import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/configs/themes/app_colors.dart';
import 'package:beanmind_flutter/configs/themes/app_icons_icons.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/models/models.dart';
import 'package:beanmind_flutter/screens/game/game_leaderboard_screen.dart';
import 'package:beanmind_flutter/widgets/common/custom_app_bar.dart';
import 'package:beanmind_flutter/widgets/common/progress_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameListScreen extends GetView<GameController> {
  const GameListScreen({Key? key}) : super(key: key);
  static const String routeName = '/game_list';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.shouldReset.value) {
        controller.selectedGame.value = null;
        controller.shouldReset.value = false;
      }
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: Obx(() {
            return controller.selectedGame.value != null
                ? CustomAppBar(
                    title: (controller
                        .getGameTitle(controller.selectedGame.value!)),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        controller.selectedGame.value = null;
                      },
                    ),
                    showAudioButton: true,
                  )
                : CustomAppBar(
                    title: 'Thư viện trò chơi',
                    showAudioButton: true,
                  );
          }),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Obx(() => controller.isLoading.value
            ? _buildLoadingIndicator()
            : controller.selectedGame.value != null
                ? controller.buildGameWidget(controller.selectedGame.value!)
                : _buildGameGrid()),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: ProgressWidgets(),
    );
  }

  Widget _buildGameGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 16 / 9,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: controller.games.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controller.isLoading.value = true;
            controller.selectedGame.value = controller.games[index]['gameId'];
            // Simulate a delay for loading the game
            Future.delayed(Duration(seconds: 0), () {
              controller.isLoading.value = false;
            });
          },
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(
                controller.games[index]['title']!,
                style: TextStyle(fontSize: 20),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0), // Bo góc tại đây
              child: Stack(
                children: [
                  Image.network(
                    controller.games[index]['image']!,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
  top: 10,
  right: 10,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.deepPurple, backgroundColor: Colors.white, // Ripple color (on press)
      shape: CircleBorder(), // Circular shape
      elevation: 5, // Shadow elevation
      padding: EdgeInsets.all(20), // Button padding
    ),
    onPressed: () {
      // Your onTap functionality here
      Get.toNamed(GameLeaderboardScreen.routeName,
          arguments: GameModel(
              id: controller.games[index]['gameId'] ?? 'game001',
              name: controller.games[index]['title'] ?? ''));
    },
    child: Icon(AppIcons.trophyoutline, color: Colors.deepPurple), // Icon with deepPurple color
  ),
),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
