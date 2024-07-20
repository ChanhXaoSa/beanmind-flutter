import 'package:beanmind_flutter/screens/course/course_detail_screen.dart';
import 'package:beanmind_flutter/screens/course/course_learning_screen.dart';
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

  void navigateToCourseLeaning() {
    Get.toNamed(CourseLearningScreen.routeName);
  }

  void navigateToCourseDetail() {
    Get.toNamed(CourseDetailScreen.routeName);
  }
}
