import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/game/widget/game_drag_and_drop_shoping/game_shopping_screen.dart';
import 'package:beanmind_flutter/game/widget/game_happy_farm/happy_farm_screen.dart';
import 'package:beanmind_flutter/game/widget/game_ocean_adventure/ocean_adventure_screen.dart';
import 'package:beanmind_flutter/game/widget/game_odd_and_even/odd_and_even_screen.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/game_drag_and_drop_screen.dart';
import 'package:beanmind_flutter/models/game_model.dart';
import 'package:beanmind_flutter/screens/game/game_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  var isLoading = false.obs;
  var selectedGame = RxnString();
  var shouldReset = false.obs;

  String gameThumbnailURL = '/images/game_thumbnail/';

  final List<Map<String, String>> games = [
    {
      'title': 'Khám phá đại dương',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Focean_adventure.png?alt=media&token=d9ada505-0862-4a8b-afe6-6a11358561bc',
      'gameId': 'game001'
    },
    {
      'title': 'Nông trại vui vẻ',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fhappy_farm.png?alt=media&token=ed307113-421f-4d74-bea2-e4d45fd18b8f',
      'gameId': 'game002'
    },
    {
      'title': 'Sắp xếp số',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fnumber_sort.png?alt=media&token=5b46e912-4162-4c8d-9c08-0b195d087964',
      'gameId': 'game003'
    },
    {
      'title': 'Trò chơi mua sắm',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fshopping.png?alt=media&token=2816621f-4247-4f1c-ac61-8baa7f0420f0',
      'gameId': 'game004'
    },
    {
      'title': 'Số lẻ và số chẵn',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/thumbnail_game_images%2Fodd_and_even.png?alt=media&token=30686705-4ae5-433a-8af7-16a30938461c',
      'gameId': 'game005'
    }
  ];

  String getGameTitle(String gameId) {
    switch (gameId) {
      case 'game001':
        return 'Khám phá đại dương';
      case 'game002':
        return 'Nông trại vui vẻ';
      case 'game003':
        return 'Sắp xếp số';
      case 'game004':
        return 'Trò chơi mua sắm';
      case 'game005':
        return 'Số lẻ và số chẵn';
      default:
        return 'Game Gallery';
    }
  }

  Widget buildGameWidget(String gameId) {
    switch (gameId) {
      case 'game001':
        return OceanAdventureScreen();
      case 'game002':
        return HappyFarmScreen();
      case 'game003':
        return MathDragAndDropScreen();
      case 'game004':
        return GameShoppingScreen();
      case 'game005':
        return GameOddAndEvenScreen();
      default:
        return GameListScreen();
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

  @override
  void onInit() {
    super.onInit();
    ever(selectedGame, (_) {
      if (selectedGame.value == null) {}
    }); 
  }

  void navigateToGameList() {
    Get.toNamed(GameListScreen.routeName);
  }
}
