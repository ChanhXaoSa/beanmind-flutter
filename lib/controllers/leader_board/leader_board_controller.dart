import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/firebase/loading_status.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/models/models.dart';
import 'package:beanmind_flutter/utils/logger.dart';

class LeaderBoardController extends GetxController {
  final leaderBoard = <LeaderBoardData>[].obs;
  final leaderBoardGame = <LeaderBoardGameData>[].obs;
  final myScores = Rxn<LeaderBoardData>();
  final myGameScores = Rxn<LeaderBoardGameData>();
  final loadingStatus = LoadingStatus.completed.obs;
  final gameloadingStatus = LoadingStatus.completed.obs;

  void getAll(String paperId) async {
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> _leaderBoardSnapShot =
          await getleaderBoard(paperId: paperId)
              .orderBy("points", descending: true)
              .limit(50)
              .get();
      final allData = _leaderBoardSnapShot.docs
          .map((score) => LeaderBoardData.fromSnapShot(score))
          .toList();

      for (var data in allData) {
        final userSnapshot = await userFR.doc(data.userId).get();
        data.user = UserData.fromSnapShot(userSnapshot);
      }

      leaderBoard.assignAll(allData);
      loadingStatus.value = LoadingStatus.completed;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
      AppLogger.e(e);
    }
  }

  void getMyScores(String paperId) async {
    final user = Get.find<AuthController>().getUser();

    if (user == null) {
      return;
    }
    try {
      final DocumentSnapshot<Map<String, dynamic>> _leaderBoardSnapShot =
          await getleaderBoard(paperId: paperId).doc(user.email).get();
      final _myScores = LeaderBoardData.fromSnapShot(_leaderBoardSnapShot);
      _myScores.user = UserData(name: user.displayName!, image: user.photoURL);
      myScores.value = _myScores;
    } catch (e) {
      AppLogger.e(e);
    }
  }

  // leader board for game
  void getAllGame(String gameId) async {
    gameloadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> _leaderBoardSnapShot =
          await getleaderBoardGame(paperId: gameId)
              .orderBy("time", descending: true)
              .orderBy("points", descending: true)
              .limit(10)
              .get();
      final allData = _leaderBoardSnapShot.docs
          .map((score) => LeaderBoardGameData.fromSnapShot(score))
          .toList();

      for (var data in allData) {
        final userSnapshot = await userFR.doc(data.userId).get();
        data.user = UserData.fromSnapShot(userSnapshot);
      }

      leaderBoardGame.assignAll(allData);
      gameloadingStatus.value = LoadingStatus.completed;
    } catch (e) {
      gameloadingStatus.value = LoadingStatus.error;
      AppLogger.e(e);
    }
  }

  void getMyGameScores(String gameId) async {
    final user = Get.find<AuthController>().getUser();

    if (user == null) {
      return;
    }
    try {
      final DocumentSnapshot<Map<String, dynamic>> _leaderBoardGameSnapShot =
          await getleaderBoardGame(paperId: gameId).doc(user.email).get();
      final _myGameScores = LeaderBoardGameData.fromSnapShot(_leaderBoardGameSnapShot);
      _myGameScores.user = UserData(name: user.displayName!, image: user.photoURL);
      myGameScores.value = _myGameScores;
    } catch (e) {
      AppLogger.e(e);
    }
  }
}
