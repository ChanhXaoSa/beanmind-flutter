import 'package:beanmind_flutter/screens/screens.dart';
import 'package:beanmind_flutter/widgets/home/document_paper_card.dart';
import 'package:beanmind_flutter/widgets/home/video_learning_paper_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class CourseLearningScreen extends GetView<MyDrawerController> {
  const CourseLearningScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprController = Get.find();
    return Scaffold(
        body: GetBuilder<MyDrawerController>(
          builder: (_) => ZoomDrawer(
            controller: _.zoomDrawerController,
            borderRadius: 50.0,
            showShadow: true,
            angle: 0.0,
            style: DrawerStyle.defaultStyle,
            menuScreen: const CustomDrawer(),
            menuBackgroundColor: Colors.white.withOpacity(0.5),
            slideWidth: MediaQuery.of(context).size.width * 0.6,
            mainScreen: Container(
              decoration: BoxDecoration(gradient: mainGradient(context)),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kMobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: const Offset(-10, 0),
                            child: CircularButton(
                              child: const Icon(AppIcons.menuleft),
                              onTap: controller.toggleDrawer,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Icon(AppIcons.peace),
                                Builder(
                                  builder: (_) {
                                    late final AuthController _auth = Get.find();
                                    late final user = _auth.getUser();
                                    String _label = '  Hello mate';
                                    if (user != null) {
                                      _label = '  Hello ${user.displayName}';
                                    }
                                    return Text(_label,
                                        style: kDetailsTS.copyWith(
                                            color: kOnSurfaceTextColor));
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Text('What Do You Want To Improve Today ?',
                              style: kHeaderTS),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(
                                () => LiquidPullToRefresh(
                              height: 150,
                              springAnimationDurationInMilliseconds: 500,
                              //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                              color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                              onRefresh: () async {
                                _quizePprController.getAllPapers();
                              },
                              child: ListView.separated(
                                padding: UIParameters.screenPadding,
                                shrinkWrap: true,
                                itemCount: _quizePprController.allPapers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if(index == 0) {
                                    return DocumentPaperCard(
                                      model: _quizePprController.allPapers[index],
                                    );
                                  } else if(index == 1) {
                                    return VideoLearningPaperCard(
                                      model: _quizePprController.allPapers[index],
                                    );
                                  } else {
                                    return QuizPaperCard(
                                      model: _quizePprController.allPapers[index],
                                    );
                                  }
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
