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
    final TextEditingController searchController = TextEditingController();
    final RxString searchQuery = ''.obs;

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
            return CustomAppBar(
              title: controller.selectedGame.value != null
                  ? controller.games.firstWhere((game) => game['id'] == controller.selectedGame.value)['name']
                  : 'Thư viện trò chơi',
              leading: controller.selectedGame.value != null
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        controller.selectedGame.value = null;
                      },
                    )
                  : null,
              showAudioButton: true,
            );
          }),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: LoadingWidgets());
          }
          if (controller.selectedGame.value != null) {
            return controller.buildGameWidget(controller.selectedGame.value!);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 12),
                width: MediaQuery.of(context).size.width*0.3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm trò chơi',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    onChanged: (value) {
                      searchQuery.value = value;
                    },
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  final filteredGames = controller.games.where((game) {
                    final gameName = game['name']?.toLowerCase() ?? '';
                    final query = searchQuery.value.toLowerCase();
                    return gameName.contains(query);
                  }).toList();
                  return _buildGameGrid(filteredGames);
                }),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildGameGrid(List<dynamic> games) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 16 / 9,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return GestureDetector(
          onTap: () {
            controller.isLoading.value = true;
            controller.selectedGame.value = game['id'];
            Future.delayed(Duration.zero, () {
              controller.isLoading.value = false;
            });
          },
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(
                game['name'] ?? '',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Stack(
                children: [
                  Image.network(
                    game['image'] ?? '',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.deepPurple,
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        elevation: 5,
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: () {
                        Get.toNamed(
                          GameLeaderboardScreen.routeName,
                          arguments: GameModel(
                            id: game['id']!,
                            title: game['name']!,
                            imageUrl: game['image'] ?? '',
                            description: game['description'] ?? '',
                          ),
                        );
                      },
                      child: const Icon(AppIcons.trophyoutline, color: Colors.deepPurple),
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
