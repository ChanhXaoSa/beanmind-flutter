import 'package:beanmind_flutter/configs/themes/app_colors.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/widgets/common/custom_app_bar.dart';
import 'package:beanmind_flutter/widgets/common/progress_widgets.dart';
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
                  )
                : CustomAppBar(
                    title: 'Thư viện trò chơi',
                    showActionIcon: false, // or true based on your requirement
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
            controller.selectedGame.value = controller.games[index]['gameType'];
            // Simulate a delay for loading the game
            Future.delayed(Duration(seconds: 0), () {
              controller.isLoading.value = false;
            });
          },
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(controller.games[index]['title']!, style: TextStyle(fontSize: 20),),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0), // Bo góc tại đây
              child: Container(
                child: Image.asset(
                  controller.gameThumbnailURL +
                      controller.games[index]['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
