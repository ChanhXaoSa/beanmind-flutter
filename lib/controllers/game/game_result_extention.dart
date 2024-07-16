import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/services/notification/notification_service.dart';

extension GameResult on GameController {
  Future<void> saveGameResults(String gameId, int points, int userPoint,
      int userProgress, int timeRecord) async {
    var batch = fi.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;
    batch
        .set(userFR.doc(_user.email).collection('myrecent_games').doc(gameId), {
      "points": points,
      "correct_count": '$userPoint/$userProgress',
      "paper_id": gameId,
      "time": timeRecord
    });
    batch.set(
        leaderBoardFR.doc(gameId).collection('game_scores').doc(_user.email), {
      "points": points,
      "correct_count": '$userPoint/$userProgress',
      "paper_id": gameId,
      "user_id": _user.email,
      "time": timeRecord
    });
    await batch.commit();

    // Notification

    // Get.find<NotificationService>().showQuizCompletedNotification(
    //     id: 1,
    //     title: quizPaperModel.title,
    //     body:
    //         'You have just got $points points for ${quizPaperModel.title} -  Tap here to view leaderboard',
    //     imageUrl: quizPaperModel.imageUrl,
    //     payload: json.encode(quizPaperModel.toJson()));
    // navigateToGameList();
  }
}
