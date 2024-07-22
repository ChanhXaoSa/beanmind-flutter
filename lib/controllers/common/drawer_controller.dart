import 'package:beanmind_flutter/controllers/course/course_controller.dart';
import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  // Rxn<User?> user = Rxn();
  var user = <UserModel>[].obs;

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {
    Get.find<AuthController>().navigateToLogin();
  }

  void game() {
    Get.find<GameController>().navigateToGameList();
  }

  void courseLearning() {
    Get.find<CourseController>().navigateToCourseLeaning();
  }

  void github() {
    _launch('https://github.com/CodeFoxLk');
  }

  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'codefoxlk@gmail.com',
    );
    _launch(emailLaunchUri.toString());
  }

  void downloadSourceCode() {
    _launch('https://github.com/CodeFoxLk/quizzle_public.git');
  }

  @override
  Future<void> onReady() async {
    UserModel? sessionUser = await Get.find<AuthController>().getUserLocal();
    if (sessionUser != null) {
      user.value = [sessionUser];
    }
    super.onReady();
  }

  Future<void> _launch(String url) async {
    if (!await launch(
      url,
    )) {
      throw 'Could not launch $url';
    }
  }
}
