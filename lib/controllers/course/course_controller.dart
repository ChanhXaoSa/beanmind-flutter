import 'package:beanmind_flutter/screens/course/course_learning_screen.dart';
import 'package:beanmind_flutter/screens/course/course_screen.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void navigateToCourse() {
    Get.toNamed(CourseScreen.routeName);
  }

  void navigateToCourseLeaning() {
    Get.toNamed(CourseLearningScreen.routeName);
  }
}
