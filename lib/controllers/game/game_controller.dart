import 'dart:convert';
import 'package:beanmind_flutter/firebase/loading_status.dart';
import 'package:beanmind_flutter/screens/game/game_shopping_screen.dart';
import 'package:beanmind_flutter/screens/game/happy_farm_screen.dart';
import 'package:beanmind_flutter/screens/game/ocean_adventure_screen.dart';
import 'package:beanmind_flutter/screens/game/odd_and_even_screen.dart';
import 'package:beanmind_flutter/screens/game/game_drag_and_drop_screen.dart';
import 'package:beanmind_flutter/models/game_model.dart';
import 'package:beanmind_flutter/screens/game/game_list_screen.dart';
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
        Uri.parse(
            'http://bmapitest.somee.com/api/v1/games?PageIndex=1&PageSize=9999'),
      );

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

        print(games);
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
      snapshot.docs.forEach((doc) {
        print(doc.data());
      });
      List<GameAnimalModel> items = snapshot.docs
          .map((doc) => GameAnimalModel.fromSnapshot(doc))
          .toList();
      print('Number of items fetched: ${items.length}');
      items.forEach((item) {
        print('Item: ${item.id}, ImageUrl: ${item.imageurl}');
      });

      animalslist = List<GameAnimalModel>.from(items);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

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
}
