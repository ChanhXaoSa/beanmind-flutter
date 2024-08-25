import 'dart:convert';
import 'dart:ui';

import 'package:beanmind_flutter/controllers/result/result_controller.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:http/http.dart' as http;

extension ResultExtention on ResultController {
  int get correctQuestionCount => allQuestionsApi
      .where((question) => question.question!.selectedAnswer == question.question!.questionAnswers!.where((element) => element.isCorrect == true,).first)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount trên ${allQuestionsApi.length} câu trả lời đúng';
  }

  String get points {
    if (allQuestionsApi.isEmpty) {
      return '0';
    }
    var points = ((correctQuestionCount / allQuestionsApi.length) * 100).round();
    return points.toString();
  }

  Future<void> saveQuizResults() async {
    UserModel? user = await Get.find<AuthController>().getUserLocal();
    if (user == null) Get.find<AuthController>().signOut();
    String enrollId = Get.find<AuthController>().getEnrollmentId(courseId);
    String worksheetId = this.worksheetId;
    String worksheetAttemptId = this.worksheetAttemptId;
    String completionDate = DateTime.now().toUtc().toIso8601String();

    List<Map<String, String>> workSheetAttemptAnswers = allQuestionsApi
        .where((question) => question.question!.selectedAnswer != null)
        .map((question) {
      return {
        "questionAnswerId": question.question!.selectedAnswer!.id!,
      };
    }).toList();

    var body = jsonEncode({
      "id": worksheetAttemptId,
      "enrollmentId": enrollId,
      "worksheetId": worksheetId,
      "completionDate": completionDate,
      "status": 2,
      "score": points,
      "workSheetAttemptAnswers": workSheetAttemptAnswers
    });

    try {
      String? accessToken = await Get.find<AuthController>().getAccessToken();
      if(accessToken != null) {
        final response = await http.put(
          Uri.parse('$newBaseApiUrl/worksheet-attempts'),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
            'Authorization' : 'Bearer $accessToken'
          },
          body: body,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Quiz results saved successfully');
          // navigateToCourseLearning();
        } else {
          print('Failed to save quiz results: ${response.statusCode}');
        }
      } else {
        Get.snackbar(
          'Error',
          'Token không tồn tại',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFFC6B6B),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
