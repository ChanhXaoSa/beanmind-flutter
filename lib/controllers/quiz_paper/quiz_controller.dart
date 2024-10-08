import 'dart:async';
import 'dart:convert';
import 'package:beanmind_flutter/models/worksheet_detail_model.dart';
import 'package:beanmind_flutter/screens/course/course_learning_screen.dart';
import 'package:beanmind_flutter/screens/quiz/quiz_attempt_screen.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/firebase/firebase_configs.dart';
import 'package:beanmind_flutter/screens/screens.dart';
import 'package:beanmind_flutter/utils/logger.dart';
import 'package:beanmind_flutter/widgets/dialogs/dialogs.dart';
import 'package:http/http.dart' as http;


class QuizController extends GetxController {
  late String courseId;
  late String worksheetId;
  late String worksheetAttemptId;
  final loadingStatusApi = LoadingStatus.loading.obs;
  final allQuestionsApi = <WorksheetQuestion>[];
  var worksheetDetailModel = Rxn<WorksheetDetailModel>();
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00:00'.obs;

  @override
  void onReady() {
    courseId = Get.parameters['course_id']!;
    worksheetId = Get.parameters['worksheet_id']!;
    worksheetAttemptId = Get.parameters['worksheet_attempt_id']!;
    // final _quizData = Get.arguments as WorksheetDetailModel;
    // loadDataApi(_quizData);
    // final _quizePaprer = Get.arguments as QuizPaperModel;
    // loadData(_quizePaprer);
    fetchWorksheetDetail();
    super.onReady();
  }

  @override
  void onClose() {
    if(_timer != null){
      _timer!.cancel();
    }
    super.onClose();
  }

  Future<bool> onExitOfQuiz() async{
    return Dialogs.quizEndDialog( );
  }

  void _startTimer(int seconds) {
    const duration =   Duration(seconds: 1);
    remainSeconds = seconds;
    _timer =  Timer.periodic(
      duration,
      (Timer timer) {
        if (remainSeconds == 0) {
          timer.cancel();
        } else {
          int minutes = remainSeconds~/60;
          int seconds = (remainSeconds%60);
          time.value = "${minutes.toString().padLeft(2,"0")}:${seconds.toString().padLeft(2,"0")}";
         remainSeconds--;
        }
      },
    );
  }

  Future<void> fetchWorksheetDetail() async {
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
        loadDataApi(worksheetDetailModel.value!);
        if (kDebugMode) {
          print(worksheetDetailModel.value.toString());
        }
      } else {
        throw Exception('Failed to fetch course');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }

  Future<void> loadDataApi(WorksheetDetailModel quizData) async {
    worksheetDetailModel.value = quizData;
    loadingStatusApi.value = LoadingStatus.loading;
    try {
      worksheetDetailModel.value = quizData;

      if (worksheetDetailModel.value?.data?.worksheetQuestions != null) {
        allQuestionsApi.assignAll(worksheetDetailModel.value!.data!.worksheetQuestions!);
        currentQuestionApi.value = allQuestionsApi[0];
        if (kDebugMode) {
          print('${currentQuestionApi.value!.question!.content}');
        }
        if (kDebugMode) {
          print('${allQuestionsApi.length}');
        }
        _startTimer(600);
        loadingStatusApi.value = LoadingStatus.completed;
      } else {
        loadingStatusApi.value = LoadingStatus.noReult;
      }
    } on Exception catch (e) {
      AppLogger.e(e);
      loadingStatusApi.value = LoadingStatus.error;
    }
  }

  Rxn<WorksheetQuestion> currentQuestionApi = Rxn<WorksheetQuestion>();
  final questionIndexApi = 0.obs;
  bool get isFirstQuestionApi => questionIndexApi.value > 0;
  bool get islastQuestionApi => questionIndexApi.value >= allQuestionsApi.length - 1;

  void nextQuestionApi() {
    if (questionIndexApi.value >= allQuestionsApi.length - 1) return;
    questionIndexApi.value++;
    currentQuestionApi.value = allQuestionsApi[questionIndexApi.value];
    update(['answers_list']);
  }

  void prevQuestionApi() {
    if (questionIndexApi.value <= 0){
      return;
    }
    questionIndexApi.value--;
    currentQuestionApi.value = allQuestionsApi[questionIndexApi.value];
  }

  void jumpToQuestionApi(int index, {bool isGoBack = true}){
    questionIndexApi.value = index;
    currentQuestionApi.value = allQuestionsApi[index];
    if(isGoBack) {
      Get.back();
    }
  }

  void selectAnswerApi(QuestionAnswer? answer) {
    currentQuestionApi.value!.question!.selectedAnswer = answer;
    update(['answers_list', 'answers_review_list']);
  }

  String get completedQuizApi{
    final answeredQuestionCount = allQuestionsApi.where((question) => question.question!.selectedAnswer != null).toList().length;
    return '$answeredQuestionCount trên ${allQuestionsApi.length} câu đã trả lời';
  }

  void completeApi(){
    _timer!.cancel();
    Get.offAndToNamed(Resultcreen.routeName);
  }

  void tryAgainApi(){
    // Get.find<QuizPaperController>().navigatoQuestions(paper: quizPaperModel, isTryAgain: true);
    Get.offAndToNamed(QuizAttemptScreen.routeName);
  }

  void navigateToHome(){
     _timer!.cancel();
     Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }

  void navigateToCourseLearning(){
    _timer!.cancel();
    Get.offNamedUntil(CourseLearningScreen.routeName.replaceFirst(':id', courseId), (route) => false,);
  }
}