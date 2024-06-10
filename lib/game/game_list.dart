import 'package:beanmind_flutter/game/class/animal/count_animal.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/game_drag_and_drop_screen.dart';
import 'package:beanmind_flutter/game/widget/game_drag_and_drop_shoping/shopping_split_panels.dart';
import 'package:beanmind_flutter/game/widget/game_happy_farm/happy_farm_screen.dart';
import 'package:beanmind_flutter/game/widget/game_math/math_game.dart';
import 'package:beanmind_flutter/game/widget/game_ocean_adventure/ocean_adventure_screen.dart';
import 'package:flutter/material.dart';

class GameList extends StatefulWidget {
  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  bool isLoading = false;
  String? selectedGame;

  String gameThumbnailURL = '/images/game_thumbnail/';

  final List<Map<String, String>> games = [
    {
      'title': 'Ocean adventure',
      'image': 'ocean_adventure.png',
      'gameType': 'ocean'
    },
    {'title': 'Happy farm', 'image': 'happy_farm.png', 'gameType': 'space'},
    {'title': 'Game shopping', 'image': 'happy_farm.png', 'gameType': 'jungle'},
    {
      'title': 'Drag and Drop',
      'image': 'ocean_adventure.png',
      'gameType': 'desert'
    },
    {
      'title': 'Mountain Climb',
      'image': 'happy_farm.png',
      'gameType': 'mountain'
    },
    // Thêm các trò chơi khác ở đây
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedGame != null
            ? _getGameTitle(selectedGame!)
            : 'Game Gallery'),
        leading: selectedGame != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selectedGame = null;
                  });
                },
              )
            : null,
      ),
      body: isLoading
          ? _buildLoadingIndicator()
          : selectedGame != null
              ? _buildGameWidget(selectedGame!)
              : _buildGameGrid(),
      //body: ProductDragAndDrop(),
      backgroundColor: Colors.blue[100],
    );
  }

  String _getGameTitle(String gameType) {
    switch (gameType) {
      case 'ocean':
        return 'Ocean Adventure';
      case 'space':
        return 'Happy Farm';
      case 'jungle':
        return 'Math game 1v1';
      case 'desert':
        return 'Drag and Drop';
      case 'mountain':
        return 'Mountain Climb';
      default:
        return 'Game Gallery';
    }
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
        crossAxisCount: 5, // Số cột
        childAspectRatio: 16 / 9, // Tỷ lệ chiều rộng trên chiều cao
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: games.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              isLoading = true;
              selectedGame = games[index]['gameType'];
            });
            // Simulate a delay for loading the game
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                isLoading = false;
                resetGame();
              });
            });
          },
          child: GridTile(
            child: Image.asset(gameThumbnailURL + games[index]['image']!,
                fit: BoxFit.cover),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(games[index]['title']!),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGameWidget(String gameType) {
    switch (gameType) {
      case 'ocean':
        return OceanAdventureScreen();
      case 'space':
        return HappyFarmScreen();
      case 'jungle':
        return const MathGame();
      case 'desert':
        return MathDragAndDropScreen();
      case 'mountain':
        return const ShopingSplitPanels();
      default:
        return Container();
    }
  }
}