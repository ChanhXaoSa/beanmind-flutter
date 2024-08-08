import 'dart:convert';

import 'package:beanmind_flutter/models/game_history_model.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/firebase/references.dart';
import 'package:beanmind_flutter/models/models.dart'
    show QuizPaperModel, RecentTest;
import 'package:beanmind_flutter/services/firebase/firebasestorage_service.dart';
import 'package:beanmind_flutter/utils/logger.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var user = Rx<UserModel?>(null);

  @override
  void onReady() {
    getMyRecentTests();
    checkLoginStatus();
    super.onReady();
  }

  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Future<void> checkLoginStatus() async {
    UserModel? sessionUser = await Get.find<AuthController>().getUserLocal();
    if (sessionUser != null) {
      user.value = sessionUser;
    }
  }

  final allRecentTest = <RecentTest>[].obs;
  List<dynamic> gameHistories = [];

  getMyRecentTests() async {
    try {
      User? user = Get.find<AuthController>().getUser();
      if (user == null) return;
      QuerySnapshot<Map<String, dynamic>> data =
          await recentQuizes(userId: user.email!).get();
      final tests =
          data.docs.map((paper) => RecentTest.fromSnapshot(paper)).toList();

      for (RecentTest test in tests) {
        DocumentSnapshot<Map<String, dynamic>> quizPaperSnaphot =
            await quizePaperFR.doc(test.paperId).get();
        final quizPaper = QuizPaperModel.fromSnapshot(quizPaperSnaphot);

        final url =
            await Get.find<FireBaseStorageService>().getImage(quizPaper.title);
        test.papername = quizPaper.title;
        test.paperimage = url;
      }

      allRecentTest.assignAll(tests);
    } catch (e) {
      AppLogger.e(e);
    }
  }
}
