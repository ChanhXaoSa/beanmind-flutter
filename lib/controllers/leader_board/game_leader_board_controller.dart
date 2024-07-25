import 'dart:convert';

import 'package:beanmind_flutter/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/firebase/loading_status.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/models/models.dart';
import 'package:beanmind_flutter/utils/logger.dart';
import 'package:http/http.dart' as http;

class GameLeaderBoardController extends GetxController {
  // game
  final gameloadingStatus = LoadingStatus.completed.obs;
  List<dynamic> gamesLeaderBoard = [];

  // leader board for game
  Future<void> getAllGame(String gameId) async {
    gameloadingStatus.value = LoadingStatus.loading;
    try {
      final String apiUrl =
          "http://bmapitest.somee.com/api/v1/game-histories/leaderboard?GameId=$gameId";
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final body = response.body;
        final decoded = jsonDecode(body);

        // Kiểm tra định dạng JSON và truy cập dữ liệu
        if (decoded is Map<String, dynamic> && decoded['data'] is Map<String, dynamic>) {
          final data = decoded['data'];
          final top10Leaderboard = data['top10Leaderboard'] as List<dynamic>;

          final allData = top10Leaderboard
              .map((item) => LeaderBoardGameData.fromJson(item))
              .toList();

          for (var data in allData) {
            final userSnapshot = await userFR.doc(data.studentId).get();
          }

          gamesLeaderBoard = allData;
          gameloadingStatus.value = LoadingStatus.completed;
        } else {
          throw Exception('Unexpected JSON format');
        }
      } else {
        gameloadingStatus.value = LoadingStatus.error;
        throw Exception(
            'Failed to fetch leaderboard. Status code: ${response.statusCode}');
      }
    } catch (e) {
      gameloadingStatus.value = LoadingStatus.error;
      AppLogger.e(e);
    }
  }

  // void getMyGameScores(String gameId) async {
  //   final user = Get.find<AuthController>().getUser();

  //   if (user == null) {
  //     return;
  //   }
  //   try {
  //     final DocumentSnapshot<Map<String, dynamic>> leaderBoardGameSnapShot =
  //         await getleaderBoardGame(paperId: gameId).doc(user.email).get();
  //     final myGameScores =
  //         LeaderBoardGameData.fromSnapShot(leaderBoardGameSnapShot);
  //     myGameScores.user =
  //         UserData(name: user.displayName!, image: user.photoURL);
  //     myGameScores.value = myGameScores;
  //   } catch (e) {
  //     AppLogger.e(e);
  //   }
  // }
}
