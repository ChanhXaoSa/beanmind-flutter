import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/widgets/common/custom_home_app_bar.dart';
import 'package:beanmind_flutter/widgets/course_detail/course_detail_action.dart';
import 'package:beanmind_flutter/widgets/course_detail/course_detail_chapter_and_topic.dart';
import 'package:beanmind_flutter/widgets/course_detail/course_detail_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetailScreen extends GetView<CourseDetailController> {
  const CourseDetailScreen({super.key});

  static const String routeName = '/course_detail/course_id=:id';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHomeAppBar(),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0F000000),
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 1, 24),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    '${controller.courseDetailData.value?.imageUrl}',
                                  ),
                                ),
                              ),
                              width: double.infinity,
                              height: 449,
                            ),
                          ),
                          const Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: CourseDetailInformation(),
                              ),
                              Expanded(
                                flex: 2,
                                child: CourseDetailAction(),
                              ),
                            ],
                          ),
                          const CourseDetailChapterAndTopic(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
