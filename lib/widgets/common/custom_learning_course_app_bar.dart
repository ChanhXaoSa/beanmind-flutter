import 'package:beanmind_flutter/controllers/common/app_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomLearningCourseAppBar extends GetView<AppBarController> implements PreferredSizeWidget {
  const CustomLearningCourseAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
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
                TextButton.icon(
                  onPressed: () {

                  },
                  icon: const Icon(Icons.emoji_events, color: Colors.blue),
                  label: const Text('90%', style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {

                  },
                  child: const Text('Review', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
