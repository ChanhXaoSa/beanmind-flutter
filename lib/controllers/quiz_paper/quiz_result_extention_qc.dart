import 'dart:convert';

import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/services/notification/notification_service.dart';
import 'package:http/http.dart' as http;

extension QuizeResult on QuizController {
  int get correctQuestionCount => allQuestionsApi
      .where((question) => question.question!.selectedAnswer == question.question!.questionAnswers!.where((element) => element.isCorrect == true,).first)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount trên ${allQuestionsApi.length} câu trả lời đúng';
  }

  String get points {
    var points = ((correctQuestionCount / allQuestionsApi.length) *
        100 *
        (600 - remainSeconds) /
        600 *
        100).round();
    return points.toString();
  }

  Future<void> saveQuizResults() async {
    UserModel? user = await Get.find<AuthController>().getUserLocal();
    if (user == null) Get.find<AuthController>().signOut();
    String enrollId = Get.find<AuthController>().getEnrollmentId(courseId);
    String worksheetId = this.worksheetId;
    String completionDate = DateTime.now().toUtc().toIso8601String();

    List<Map<String, String>> workSheetAttemptAnswers = allQuestionsApi
        .where((question) => question.question!.selectedAnswer != null)
        .map((question) {
      return {
        "questionAnswerId": question.question!.selectedAnswer!.id!,
      };
    }).toList();

    var body = jsonEncode({
      "enrollmentId": enrollId,
      "worksheetId": worksheetId,
      "completionDate": completionDate,
      "status": 1,
      "score": points,
      "workSheetAttemptAnswers": workSheetAttemptAnswers
    });

    try {
      final response = await http.post(
        Uri.parse('$newBaseApiUrl/worksheet-attempts'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'ngrok-skip-browser-warning': 'true',
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Quiz results saved successfully');
        navigateToCourseLearning();
      } else {
        print('Failed to save quiz results: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    // Get.find<NotificationService>().showQuizCompletedNotification(
    //     id: 1,
    //     title: worksheetDetailModel.value!.data!.title,
    //     body:  'Bạn đạt được $points điểm cho bài kiểm tra ${worksheetDetailModel.value!.data!.title} -  Nhấn vào đây để xem bảng xếp hạng' ,
    //     // imageUrl: quizPaperModel.imageUrl,
    //     payload: json.encode(worksheetDetailModel.toJson()));
  }
}
