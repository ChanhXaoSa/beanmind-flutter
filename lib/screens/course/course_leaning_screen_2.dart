import 'package:beanmind_flutter/controllers/course_learning/course_learning_controller.dart';
import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CourseLeaningScreen2 extends GetView<CourseLearningController> {
  const CourseLeaningScreen2({Key? key}) : super(key: key);

  static const String routeName = '/course_learning2/course_id=:id';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Learning Screen'),
      ),
      body: Row(
        children: [
          // Left Section: Chapters and Topics
          Container(
            width: 300,
            color: Colors.grey[200],
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() {
                    return ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        controller.toggleChapterExpansion(controller.chapterList[index].id!);
                      },
                      children: controller.chapterList.map<ExpansionPanel>((ChapterItem chapter) {
                        return ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(chapter.title!),
                            );
                          },
                          body: Obx(() {
                            final topics = controller.topicListModel.where((topic) => topic.chapterId == chapter.id).toList();
                            return Column(
                              children: topics.map<Widget>((TopicItem topic) {
                                return ListTile(
                                  title: Text(topic.title!),
                                  onTap: () =>
                                      controller.selectContent(
                                          topic.id!),
                                );
                              }).toList(),
                            );
                          }
                          ),
                          isExpanded: controller.expandedChapters[chapter.id] ?? false,
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
          ),
          // Right Section: Course Content
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Obx(() {
                return SingleChildScrollView(
                  child: Text(controller.selectedContent.value),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}