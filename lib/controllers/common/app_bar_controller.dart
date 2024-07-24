import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/controllers/course/course_controller.dart';
import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:get/get.dart';

class AppBarController extends GetxController {

  void navigateToGameList() {
    Get.find<GameController>().navigateToGameList();
  }

  void navigateToCourseLeaning() {
    Get.find<CourseController>().navigateToCourseLeaning();
  }

  void navigateToHome() {
    Get.find<AuthController>().navigateToHome();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {
    Get.find<AuthController>().navigateToLogin();
  }
}