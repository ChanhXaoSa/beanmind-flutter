import 'package:beanmind_flutter/controllers/game/game_chapter_controller.dart';
import 'package:beanmind_flutter/widgets/common/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart'; // Import mainGradient

class CoursePlayGameScreen extends GetView<GameChapterController> {
  static const String routeName = '/course_play_game/game_id=:game_id&course_id=:course_id';

  const CoursePlayGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.gameId.isEmpty) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
            decoration: BoxDecoration(gradient: mainGradient(context)),
            child: const CustomAppBar(
              title: '',
              quizAppBar: true,
              showAudioButton: true,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Không tìm thấy ID trò chơi.'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: const CustomAppBar(
            title: '',
            quizAppBar: true,
            showAudioButton: true,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: controller.buildGameWidget(controller.gameId),
          // child: Get.find<GameController>().buildGameWidget(controller.gameId),
        ),
      ),
    );
  }
}
