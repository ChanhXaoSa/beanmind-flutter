import 'dart:convert';
import 'package:beanmind_flutter/firebase/loading_status.dart';
import 'package:beanmind_flutter/screens/game/game_shopping_screen.dart';
import 'package:beanmind_flutter/screens/game/happy_farm_screen.dart';
import 'package:beanmind_flutter/screens/game/ocean_adventure_screen.dart';
import 'package:beanmind_flutter/screens/game/odd_and_even_screen.dart';
import 'package:beanmind_flutter/screens/game/game_drag_and_drop_screen.dart';
import 'package:beanmind_flutter/models/game_model.dart';
import 'package:beanmind_flutter/screens/game/game_list_screen.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:beanmind_flutter/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GameController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  var isLoading = false.obs;
  var selectedGame = RxnString();
  var shouldReset = false.obs;
  List<dynamic> games = [];

  @override
  void onInit() async {
    super.onInit();
    await fetchGameList();
    await fetchDataGameAnimal();
    await fetchDataItem();  
    ever(selectedGame, (_) {
      if (selectedGame.value == null) {}
    });
  }

  void navigateToGameList() {
    Get.toNamed(GameListScreen.routeName);
  }

  Future<void> fetchGameList() async {
    loadingStatus.value = LoadingStatus.loading;
    try {
      final response = await http.get(
          Uri.parse('${newBaseApiUrl}/games?IsDeleted=1'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          });

      if (response.statusCode == 200) {
        final body = response.body;
        final decoded = jsonDecode(body);

        // Access the 'items' list inside the 'data' object
        if (decoded is Map<String, dynamic> &&
            decoded['data'] is Map<String, dynamic>) {
          games = decoded['data']['items'];
        } else {
          throw Exception('Unexpected JSON format');
        }

        // print(games);
        loadingStatus.value = LoadingStatus.completed;
      } else {
        loadingStatus.value = LoadingStatus.error;
        throw Exception('Failed to load game list');
      }
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
      AppLogger.e(e);
    }
  }

  Future<void> fetchDataGameAnimal() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('animal').get();
      // print json data
      // snapshot.docs.forEach((doc) {
      //   print(doc.data());
      // });
      List<GameAnimalModel> items = snapshot.docs
          .map((doc) => GameAnimalModel.fromSnapshot(doc))
          .toList();
      // print('Number of items fetched: ${items.length}');
      // items.forEach((item) {
      //   print('Item: ${item.id}, ImageUrl: ${item.imageurl}');
      // });

      animalslist = List<GameAnimalModel>.from(items);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> fetchDataItem() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('itemstore').get();

      List<ItemModel> items =
          snapshot.docs.map((doc) => ItemModel.fromSnapshot(doc)).toList();
      // print('Number of items fetched: ${items.length}');
      // items.forEach((item) {
      //   print(
      //       'Item: ${item.id}, Price: ${item.price}, ImageUrl: ${item.imageurl}');
      // });
      startLowerItemModel = items;
      lowerItemModel = List<ItemModel>.from(startLowerItemModel);
      // Update startLower and lower with the fetched items
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  String getGameTitle(String gameId) {
    switch (gameId) {
      case '3ae42c10-7dbe-4e71-a52c-c19c44e3c4a0':
        return 'Khám phá đại dương';
      case '49299e7c-fa16-45fd-84e4-1a725c118a9f':
        return 'Nông trại vui vẻ';
      case 'ead13199-827d-4c48-5d08-08dcafad932c':
        return 'Sắp xếp số';
      case 'c296495f-342e-4fd6-5d09-08dcafad932c':
        return 'Trò chơi mua sắm';
      case '59141c9e-7dd3-4c76-5d0a-08dcafad932c':
        return 'Số lẻ và số chẵn';
      default:
        return 'Game Gallery';
    }
  }

  Widget buildGameWidget(String gameId) {
    switch (gameId) {
      case '3ae42c10-7dbe-4e71-a52c-c19c44e3c4a0':
        return OceanAdventureScreen();
      case '49299e7c-fa16-45fd-84e4-1a725c118a9f':
        return HappyFarmScreen();
      case 'ead13199-827d-4c48-5d08-08dcafad932c':
        return MathDragAndDropScreen();
      case 'c296495f-342e-4fd6-5d09-08dcafad932c':
        return GameShoppingScreen();
      case '59141c9e-7dd3-4c76-5d0a-08dcafad932c':
        return GameOddAndEvenScreen();
      default:
        return GameListScreen();
    }
  }
}
