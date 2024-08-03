import 'dart:async';
import 'dart:convert';
import 'package:beanmind_flutter/models/worksheet_detail_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/firebase/firebase_configs.dart';
import 'package:beanmind_flutter/models/models.dart';
import 'package:beanmind_flutter/screens/screens.dart';
import 'package:beanmind_flutter/utils/logger.dart';
import 'package:beanmind_flutter/widgets/dialogs/dialogs.dart';
import 'package:http/http.dart' as http;

import 'quiz_papers_controller.dart';

class QuizController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final loadingStatusApi = LoadingStatus.loading.obs;
  final allQuestions = <Question>[];
  final allQuestionsApi = <QuestionContent>[];
  late QuizPaperModel quizPaperModel;
  var worksheetDetailModel = Rxn<WorksheetDetailModel>();
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00:00'.obs;

  @override
  void onReady() {
    // final _quizData = Get.arguments as WorksheetDetailModel;
    // loadDataApi(_quizData);
    final _quizePaprer = Get.arguments as QuizPaperModel;
    loadData(_quizePaprer);
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
          time.value = minutes.toString().padLeft(2,"0")+":"+seconds.toString().padLeft(2,"0");
         remainSeconds--;
        }
      },
    );
  }

  Future<void> fetchWorksheetDetail() async {
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/worksheets/89b67173-669d-443f-ba87-79b8791c6238'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final worksheetDetailModelBase = WorksheetDetailModel.fromJson(json.decode(response.body));
        worksheetDetailModel.value = worksheetDetailModelBase;
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
      // Assuming the API data is already in WorksheetDetailModel format
      worksheetDetailModel.value = quizData;

      if (worksheetDetailModel.value?.data?.worksheetQuestions != null) {
        allQuestionsApi.assignAll(worksheetDetailModel.value!.data!.worksheetQuestions!.map((q) => q.question!).toList());
        currentQuestion.value = allQuestions[0];
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

  void loadData(QuizPaperModel quizPaper) async {
    quizPaperModel = quizPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionsQuery =
          await quizePaperFR.doc(quizPaper.id).collection('questions').get();
      final questions = questionsQuery.docs
          .map((question) => Question.fromSnapshot(question))
          .toList();
      quizPaper.questions = questions;
      for (Question _question in quizPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await quizePaperFR
                .doc(quizPaper.id)
                .collection('questions')
                .doc(_question.id)
                .collection('answers')
                .get();
        final answers = answersQuery.docs
            .map((answer) => Answer.fromSnapshot(answer))
            .toList();
        _question.answers = answers;
      }
    } on Exception catch (e) {
      RegExp exp =  RegExp(r'permission-denied', caseSensitive: false, ); 
      if(e.toString().contains(exp)){
         AuthController _authController = Get.find();
         Get.back();
        _authController.showLoginAlertDialog();
      }
      AppLogger.e(e);
      loadingStatus.value = LoadingStatus.error;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
      AppLogger.e(e);
    }

    if (quizPaper.questions != null && quizPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(quizPaper.questions!);
      currentQuestion.value = quizPaper.questions![0];
      _startTimer(quizPaper.timeSeconds);
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.noReult;
    }
  }

  Rxn<Question> currentQuestion = Rxn<Question>();
  final questionIndex = 0.obs; //_curruntQuestionIndex

  bool get isFirstQuestion => questionIndex.value > 0;

  bool get islastQuestion => questionIndex.value >= allQuestions.length - 1;

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (questionIndex.value <= 0){
     return;
    } 
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }
  

  void jumpToQuestion(int index, {bool isGoBack = true}){
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if(isGoBack) {
      Get.back();
    }
  }

  void selectAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list', 'answers_review_list']);
  }

  String get completedQuiz{
    final answeredQuestionCount = allQuestions.where((question) => question.selectedAnswer != null).toList().length;
    return '$answeredQuestionCount out of ${allQuestions.length} answered';
  }

  void complete(){
     _timer!.cancel();
     Get.offAndToNamed(Resultcreen.routeName);
  }

  void tryAgain(){
     Get.find<QuizPaperController>().navigatoQuestions(paper: quizPaperModel, isTryAgain: true);
  }

  void navigateToHome(){
     _timer!.cancel();
     Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }
}