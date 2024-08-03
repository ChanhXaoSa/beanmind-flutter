import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/custom_text_styles.dart';

class CourseDetailChapterAndTopic extends GetView<CourseDetailController> {
  const CourseDetailChapterAndTopic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 6),
            blurRadius: 10,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Obx(() {
          return ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              controller.toggleChapterExpansion(controller.chapterList[index].id!);
            },
            children: controller.chapterList.map<ExpansionPanel>((ChapterItem chapter) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      chapter.title!,
                      style: kDetailsTS.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        height: 1.3,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  );
                },
                body: Obx(() {
                  final topics = controller.topicListModel.where((topic) => topic.chapterId == chapter.id).toList();
                  return Column(
                    children: topics.map<Widget>((TopicItem topic) {
                      return ListTile(
                        title: Text(
                          topic.title!,
                          style: kDetailsTS.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            height: 1.5,
                            color: const Color(0xE51B1B1B),
                          ),
                        ),
                        onTap: (() {

                        }),
                      );
                    }).toList(),
                  );
                }),
                isExpanded: controller.expandedChapters[chapter.id] ?? false,
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
