import 'package:beanmind_flutter/game/widget/game_drag_and_drop_shoping/game_shopping_screen.dart';
import 'package:beanmind_flutter/game/widget/game_happy_farm/happy_farm_screen.dart';
import 'package:beanmind_flutter/game/widget/game_math/math_game.dart';
import 'package:beanmind_flutter/game/widget/game_ocean_adventure/ocean_adventure_screen.dart';
import 'package:beanmind_flutter/game/widget/game_odd_and_even/odd_and_even_screen.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/game_drag_and_drop_screen.dart';
import 'package:beanmind_flutter/screens/game/game_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController{
  var isLoading = false.obs;
  var selectedGame = RxnString();

  String gameThumbnailURL = '/images/game_thumbnail/';

  final List<Map<String, String>> games = [
    {
      'title': 'Khám phá đại dương',
      'image': 'ocean_adventure.png',
      'gameType': 'ocean'
    },
    {
      'title': 'Nông trại vui vẻ',
      'image': 'happy_farm.png',
      'gameType': 'space'
    },
    {
      'title': 'Sắp xếp số',
      'image': 'number_sort.png',
      'gameType': 'desert'
    },
    {
      'title': 'Trò chơi mua sắm',
      'image': 'shopping.png',
      'gameType': 'mountain'
    },
    {
      'title': 'Số lẻ và số chẵn',
      'image': 'odd_and_even.png',
      'gameType': 'odd_even'
    }
  ];

  String getGameTitle(String gameType) {
    switch (gameType) {
      case 'ocean':
        return 'Khám phá đại dương';
      case 'space':
        return 'Nông trại vui vẻ';
      case 'desert':
        return 'Sắp xếp số';
      case 'mountain':
        return 'Trò chơi mua sắm';
      case 'odd_even':
        return 'Số lẻ và số chẵn';
      default:
        return 'Game Gallery';
    }
  }

  Widget buildGameWidget(String gameType) {
    switch (gameType) {
      case 'ocean':
        return OceanAdventureScreen();
      case 'space':
        return HappyFarmScreen();
      case 'desert':
        return MathDragAndDropScreen();
      case 'mountain':
        return GameShoppingScreen();
      case 'odd_even':
        return GameOddAndEvenScreen();
      default:
        return Container();
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void navigateToGameList() {
    Get.toNamed(GameListScreen.routeName);
  }
}