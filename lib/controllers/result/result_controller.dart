// import 'package:beanmind_flutter/models/worksheet_attempt_answer_model.dart';
// import 'package:get/get.dart';
// import 'package:beanmind_flutter/models/worksheet_attempt_model.dart';
//
// class ResultController extends GetxController {
//   final worksheetAttemptAnswerModelItem = <WorksheetAttemptAnswerModelItem>[].obs;
//   late WorksheetAttemptItem worksheetAttempt;
//   late String worksheetAttemptId;
//
//   @override
//   void onInit() {
//     worksheetAttemptId = Get.parameters['worksheet_attempt_id']!;
//     super.onInit();
//     worksheetAttempt = Get.arguments as WorksheetAttemptItem;
//   }
//
//   String get correctAnsweredQuestions {
//     int correctQuestionCount = worksheetAttempt.worksheet.where((question) => question.isCorrect).length;
//     return '$correctQuestionCount trên ${worksheetAttempt.questions.length} câu trả lời đúng';
//   }
//
//   String get points {
//     var correctQuestionCount = worksheetAttempt.questions.where((question) => question.isCorrect).length;
//     var points = ((correctQuestionCount / worksheetAttempt.questions.length) * 100).round();
//     return points.toString();
//   }
// }
