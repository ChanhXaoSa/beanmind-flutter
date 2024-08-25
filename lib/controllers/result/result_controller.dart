import 'dart:convert';

import 'package:beanmind_flutter/firebase/firebase_configs.dart';
import 'package:beanmind_flutter/models/worksheet_detail_attempt_model.dart';
import 'package:beanmind_flutter/models/worksheet_detail_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:beanmind_flutter/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ResultController extends GetxController {
  late String courseId;
  late String worksheetId;
  late String worksheetAttemptId;
  final allQuestionsApi = <WorksheetQuestion>[].obs;
  final loadingStatusApi = LoadingStatus.loading.obs;
  var worksheetDetailModel = Rxn<WorksheetDetailModel>();
  var worksheetAttemptModel = Rxn<WorksheetAttemptDetailModel>();
  var questionAttempt = <WorksheetAttemptAnswer>[].obs;
  final questionIndexApi = 0.obs;
  Rxn<WorksheetQuestion> currentQuestionApi = Rxn<WorksheetQuestion>();

  final correctQuestionCount = 0.obs;
  final correctAnsweredQuestions = ''.obs;
  final points = '0'.obs;

  @override
  void onInit() {
    courseId = Get.parameters['course_id']!;
    worksheetId = Get.parameters['worksheet_id']!;
    worksheetAttemptId = Get.parameters['worksheet_attempt_id']!;
    fetchWorksheetDetail();
    super.onInit();
  }

  bool isReloaded = false;

  void setReloaded(bool value) {
    isReloaded = value;
  }

  Future<void> fetchWorksheetDetail() async {
    loadingStatusApi.value = LoadingStatus.loading;
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/worksheets/$worksheetId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final worksheetDetailModelBase = WorksheetDetailModel.fromJson(json.decode(response.body));
        worksheetDetailModel.value = worksheetDetailModelBase;

        // Tiếp tục fetch dữ liệu khác
        final attemptResponse = await http.get(
            Uri.parse('$newBaseApiUrl/worksheet-attempts/$worksheetAttemptId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=utf-8',
              'ngrok-skip-browser-warning': 'true',
            }
        );
        if (attemptResponse.statusCode == 200) {
          final modelBase = WorksheetAttemptDetailModel.fromJson(json.decode(attemptResponse.body));
          worksheetAttemptModel.value = modelBase;
          points.value = worksheetAttemptModel.value!.data!.score.toString();
          loadDataApi(worksheetDetailModel.value!, worksheetAttemptModel.value!);
          questionAttempt.assignAll(worksheetAttemptModel.value!.data!.worksheetAttemptAnswers!);
          updateQuizResults();
          loadingStatusApi.value = LoadingStatus.completed;
        } else {
          throw Exception('Failed to fetch attempt data');
        }
      } else {
        throw Exception('Failed to fetch worksheet detail');
      }
    } catch (e) {
      AppLogger.e(e);
      loadingStatusApi.value = LoadingStatus.error;
    }
  }

  QuestionAnswer? checkAnswer(List<QuestionAnswer> questionAnswers) {
    for(var question in questionAnswers) {
      for(var check in questionAttempt) {
        if(check.questionAnswerId == question.id) {
          return check.questionAnswer;
        }
      }
    }
    return null;
  }

  void updateQuizResults() {
    // correctQuestionCount.value = allQuestionsApi
    //     .where((question) =>
    // question.question!.selectedAnswer ==
    //     question.question!.questionAnswers!
    //         .firstWhere((element) => element.isCorrect == true))
    //     .length;
    correctQuestionCount.value = questionAttempt.where((q) => q.questionAnswer!.isCorrect! == true).length;

    correctAnsweredQuestions.value =
    '$correctQuestionCount trên ${allQuestionsApi.length} câu trả lời đúng';

    points.value = allQuestionsApi.isEmpty
        ? '0'
        : ((correctQuestionCount.value / allQuestionsApi.length) * 10)
        .round()
        .toString();
  }

  Future<void> loadDataApi(WorksheetDetailModel quizData, WorksheetAttemptDetailModel attemptData) async {
    worksheetDetailModel.value = quizData;
    worksheetAttemptModel.value = attemptData;
    loadingStatusApi.value = LoadingStatus.loading;
    try {
      worksheetDetailModel.value = quizData;

      if (worksheetDetailModel.value?.data?.worksheetQuestions != null) {
        allQuestionsApi.assignAll(worksheetDetailModel.value!.data!.worksheetQuestions!);
        for(var question in allQuestionsApi) {
          if(worksheetAttemptModel.value!.data!.worksheetAttemptAnswers!.isNotEmpty) {
            for(var attemptQuestion in worksheetAttemptModel.value!.data!.worksheetAttemptAnswers!) {
              if(question.question!.questionAnswers!.firstWhereOrNull((q) => q.id == attemptQuestion.questionAnswerId) != null) {
                question.question!.selectedAnswer = attemptQuestion.questionAnswer;
                update(['answers_list', 'answers_review_list']);
              }
            }
          }
        }
        currentQuestionApi.value = allQuestionsApi[0];
        if (kDebugMode) {
          print('${currentQuestionApi.value!.question!.content}');
        }
        if (kDebugMode) {
          print('${allQuestionsApi.length}');
        }
        loadingStatusApi.value = LoadingStatus.completed;
      } else {
        loadingStatusApi.value = LoadingStatus.noReult;
      }
    } on Exception catch (e) {
      AppLogger.e(e);
      loadingStatusApi.value = LoadingStatus.error;
    }
  }

  void selectAnswerApi(QuestionAnswer? answer) {
    currentQuestionApi.value!.question!.selectedAnswer = answer;
    update(['answers_list', 'answers_review_list']);
  }

  void jumpToQuestionApi(int index, {bool isGoBack = true}){
    questionIndexApi.value = index;
    currentQuestionApi.value = allQuestionsApi[index];
    if(isGoBack) {
      Get.back();
    }
  }

  void prevQuestionApi() {
    if (questionIndexApi.value <= 0){
      return;
    }
    questionIndexApi.value--;
    currentQuestionApi.value = allQuestionsApi[questionIndexApi.value];
  }

  void nextQuestionApi() {
    if (questionIndexApi.value >= allQuestionsApi.length - 1) return;
    questionIndexApi.value++;
    currentQuestionApi.value = allQuestionsApi[questionIndexApi.value];
    update(['answers_list']);
  }
}
