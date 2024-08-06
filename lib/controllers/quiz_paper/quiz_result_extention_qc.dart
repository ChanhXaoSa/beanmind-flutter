import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/services/notification/notification_service.dart';

extension QuizeResult on QuizController {
  int get correctQuestionCount => allQuestionsApi
      .where((question) => question.question!.selectedAnswer == question.question!.questionAnswers!.where((element) => element.isCorrect == true,).first)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount out of ${allQuestionsApi.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestionsApi.length) *
        100 *
        (quizPaperModel.timeSeconds - remainSeconds) /
        quizPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveQuizResults() async {
    var batch = fi.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;
    batch.set(
        userFR
            .doc(_user.email)
            .collection('myrecent_quizes')
            .doc(quizPaperModel.id),
        {
          "points": points,
          "correct_count": '$correctQuestionCount/${allQuestionsApi.length}',
          "paper_id": quizPaperModel.id,
          "time": quizPaperModel.timeSeconds - remainSeconds
        });
    batch.set(
        leaderBoardFR
            .doc(quizPaperModel.id)
            .collection('scores')
            .doc(_user.email),
        {
          "points": double.parse(points),
          "correct_count": '$correctQuestionCount/${allQuestionsApi.length}',
          "paper_id": quizPaperModel.id,
          "user_id": _user.email,
          "time": quizPaperModel.timeSeconds - remainSeconds
        });
    await batch.commit();
    Get.find<NotificationService>().showQuizCompletedNotification(
        id: 1,
        title: quizPaperModel.title,
        body:  'You have just got $points points for ${quizPaperModel.title} -  Tap here to view leaderboard' ,
        imageUrl: quizPaperModel.imageUrl,
        payload: json.encode(quizPaperModel.toJson()));
    navigateToHome();
  }
}
