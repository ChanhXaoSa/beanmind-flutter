import 'package:beanmind_flutter/widgets/common/custom_home_app_bar.dart';
import 'package:beanmind_flutter/widgets/course/course_card.dart';
import 'package:beanmind_flutter/widgets/home/document_paper_card.dart';
import 'package:beanmind_flutter/widgets/home/video_learning_paper_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

import 'custom_drawer.dart';

class HomeScreen extends GetView<MyDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprController = Get.find();
    return Scaffold(
      appBar: CustomHomeAppBar(),
        body: Container(
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
                      Row(
                        children: [
                          Transform.translate(
                            offset: const Offset(-10, 0),
                            child: CircularButton(
                              child: const Icon(AppIcons.menuleft),
                              onTap: controller.toggleDrawer,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Tìm kiếm khóa học',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.filter_list),
                            onPressed: () {
                              // TODO: Implement filter functionality
                            },
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.notifications),
                            onPressed: () {
                            },
                          ),
                        ],
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
                                String _label = '  Chào mate';
                                if (user != null) {
                                  _label = '  Chào ${user.displayName}';
                                }
                                return Text(_label,
                                    style: kDetailsTS.copyWith(
                                        color: kOnSurfaceTextColor));
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 10),

                        ],
                      ),
                      // const Text('Bạn muốn học gì hôm nay ?',
                      //     style: kHeaderTS),
                      // const SizedBox(height: 15),
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
                          child: GridView.builder(
                            padding: UIParameters.screenPadding,
                            shrinkWrap: true,
                            itemCount: _quizePprController.allPapers.length*5,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.6,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return CourseCard(
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
    ));
  }
}
