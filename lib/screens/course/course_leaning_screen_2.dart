import 'package:beanmind_flutter/controllers/course_learning/course_learning_controller.dart';
import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:beanmind_flutter/widgets/common/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CourseLeaningScreen2 extends GetView<CourseLearningController> {
  const CourseLeaningScreen2({Key? key}) : super(key: key);

  static const String routeName = '/course_learning2/course_id=:id';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Course Learning Screen',
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  Obx(() {
                    if(controller.courseDetailData.value?.worksheetTemplates != null) {
                      return Container(
                        child: Center(
                          child: Text('Làm bài quiz cuối cùng'),
                        ),
                      );
                    } else return Container();
                  })
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
                final topicDetail = controller.topicDetailData.value;
                if (topicDetail != null) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topicDetail.title ?? 'No Title',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Text(
                          topicDetail.description ?? 'No Description',
                          style: TextStyle(fontSize: 16),
                        ),
                        // Add more custom widgets here using topicDetail data
                        SizedBox(height: 16),
                        Text(
                          'Additional Custom Data:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (topicDetail.questions != null && topicDetail.questions!.isNotEmpty)
                          ...topicDetail.questions!.map((question) => Text('Question: ${question.content}')).toList(),
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text(controller.selectedContent.value));
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}