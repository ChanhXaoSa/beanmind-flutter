import 'package:beanmind_flutter/screens/video_learning/video_learning_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/models/models.dart' show QuizPaperModel;
import 'package:beanmind_flutter/screens/screens.dart' show QuizeScreen;
import 'package:beanmind_flutter/services/firebase/firebasestorage_service.dart';
import 'package:beanmind_flutter/utils/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class QuizPaperController extends GetxController {
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  final allPapers = <QuizPaperModel>[].obs;
  final allPaperImages = <String>[].obs;

  Future<void> getAllPapers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await quizePaperFR.get();
      final paperList =
          data.docs.map((paper) => QuizPaperModel.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imageUrl =
            await Get.find<FireBaseStorageService>().getImage(paper.title);
        paper.imageUrl = imageUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  void navigatoQuestions(
      {required QuizPaperModel paper, bool isTryAgain = false}) {
    AuthController _authController = Get.find();

    if (_authController.isLogedIn()) {
      if (isTryAgain) {
        Get.back();
        Get.offNamed(QuizeScreen.routeName,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuizeScreen.routeName, arguments: paper);
      }
    } else {
      _authController.showLoginAlertDialog();
    }
  }

  void navigateToVideo() {
    Get.toNamed(VideoLearningScreen.routeName);
  }

  void navigateToDocument(String url) {
    _launch(url);
  }

  Future<void> _launch(String url) async {
    if (!await launch(
      url,
    )) {
      throw 'Could not launch $url';
    }
  }
}
