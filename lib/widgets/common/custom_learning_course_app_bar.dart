import 'package:beanmind_flutter/controllers/common/app_bar_controller.dart';
import 'package:beanmind_flutter/controllers/course_learning/course_learning_controller.dart';
import 'package:beanmind_flutter/screens/course/course_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLearningCourseAppBar extends GetView<AppBarController> implements PreferredSizeWidget {
  const CustomLearningCourseAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final courseLearningController = Get.find<CourseLearningController>();

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.blue),
                  onPressed: () {
                    controller.navigateToHome();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.grid_view, color: Colors.blue),
                  onPressed: () {

                  },
                ),
              ],
            ),
            Row(
              children: [
                Obx(() {
                  final totalTopics = courseLearningController.topicListModel.length;
                  final completedTopics = courseLearningController.processionModelItemList
                      .where((processionItem) => courseLearningController.topicListModel
                      .any((topic) => topic.id == processionItem.topicId))
                      .length;

                  final percentage = totalTopics > 0 ? (completedTopics / totalTopics * 100).toStringAsFixed(0) : '0';

                  return TextButton.icon(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.emoji_events, color: Colors.blue),
                    label: Text('$percentage%', style: const TextStyle(color: Colors.black)),
                  );
                }),
                TextButton(
                  onPressed: () {
                    Get.toNamed(CourseDetailScreen.routeName.replaceFirst(':id', courseLearningController.courseId));
                  },
                  child: const Text('Thông tin khoá học', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
