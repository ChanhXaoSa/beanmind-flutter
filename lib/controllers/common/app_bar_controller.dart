import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/controllers/course/course_controller.dart';
import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/screens/course/course_list_screen.dart';
import 'package:get/get.dart';

class AppBarController extends GetxController {
  var isLoggedIn = false.obs;
  var user = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    UserModel? sessionUser = await Get.find<AuthController>().getUserLocal();
    if (sessionUser != null) {
      user.value = sessionUser;
      isLoggedIn.value = true;
    }
  }

  void navigateToGameList() {
    Get.find<GameController>().navigateToGameList();
  }

  void navigateToHome() {
    Get.find<AuthController>().navigateToHome();
  }

  void navigateToCourseList() {
    Get.toNamed(CourseListScreen.routeName);
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {
    Get.find<AuthController>().navigateToLogin();
  }
}