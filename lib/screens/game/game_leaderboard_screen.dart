import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/firebase/firebase_configs.dart';
import 'package:beanmind_flutter/models/models.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class GameLeaderboardScreen extends GetView<GameLeaderBoardController> {
  GameLeaderboardScreen({super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((d) {
      final paper = Get.arguments as GameModel;
      controller.getAllGame(paper.id);
    });
  }

  static const String routeName = '/gameleaderboard';

  @override
  Widget build(BuildContext context) {
    final paper = Get.arguments as GameModel;
    String nameGame = paper.title ?? '';
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Bảng xếp hạng trò chơi $nameGame',
      ),
      body: Center(
        child: BackgroundDecoration(
          showGradient: true,
          child: Obx(
            () => controller.gameloadingStatus.value == LoadingStatus.loading
                ? const ContentArea(
                    addPadding: true,
                    child: LeaderBoardPlaceHolder(),
                  )
                : Center(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/background_images%2Fbackground_math_sort_3.png?alt=media&token=4ef2ebe9-0629-4016-b813-3aae768bfc7e'),
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          left: 400, right: 400, top: 50),
                      child: ListView.separated(
                        itemCount: controller.gamesLeaderBoard.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final data = controller.gamesLeaderBoard[index];
                          return GameLeaderBoardCard(
                            data: data,
                            index: index,
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class GameLeaderBoardCard extends StatelessWidget {
  const GameLeaderBoardCard({
    super.key,
    required this.data,
    required this.index,
  });

  final LeaderBoardGameData data;
  final int index;

  @override
  Widget build(BuildContext context) {
    var whiteTextStyle = const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);
    return ListTile(
      // leading: CircleAvatar(
      //   foregroundImage:
      //       data.user.image == null ? null : NetworkImage(data.user.image!),
      // ),
      title: Text(
        data.student.userName!,
        style: whiteTextStyle,
      ),
      subtitle: EasySeparatedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 12,
          );
        },
        children: [
          IconWithText(
            icon: Icon(
              Icons.timer,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            text: Text(
              '${data.duration!}',
              style: whiteTextStyle,
            ),
          ),
          IconWithText(
            icon: Icon(
              Icons.emoji_events_outlined,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            text: Text(
              '${data.score!}',
              style: whiteTextStyle,
            ),
          ),
        ],
      ),
      trailing: Text(
        '#${'${index + 1}'.padLeft(2, "0")}',
        style: whiteTextStyle,
      ),
    );
  }
}
