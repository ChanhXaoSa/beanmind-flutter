import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:beanmind_flutter/controllers/course_learning/course_learning_controller.dart';
import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:beanmind_flutter/screens/quiz/quiz_attempt_screen.dart';
import 'package:beanmind_flutter/widgets/common/custom_learning_course_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseLeaningScreen2 extends GetView<CourseLearningController> {
  const CourseLeaningScreen2({super.key});

  static const String routeName = '/course_learning2/course_id=:id';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomLearningCourseAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Section: Chapters and Topics
              Container(
                width: 400,
                margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        return Accordion(
                          maxOpenSections: 1,
                          headerBackgroundColor: const Color.fromARGB(90, 227, 227, 227),
                          contentBorderColor: const Color.fromARGB(90, 227, 227, 227),
                          contentBackgroundColor: const Color.fromARGB(90, 227, 227, 227),
                          headerBackgroundColorOpened: Colors.blue[300],
                          headerPadding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 15),
                          sectionOpeningHapticFeedback:
                              SectionHapticFeedback.selection,
                          contentVerticalPadding: 10,
                          contentBorderRadius: 0,
                          headerBorderRadius: 3,
                          children: controller.chapterList
                              .map<AccordionSection>((ChapterItem chapter) {
                            final isExpanded =
                                controller.expandedChapters[chapter.id] ?? false;
                            return AccordionSection(
                              isOpen: isExpanded,
                              rightIcon: Icon(
                                isExpanded ? Icons.expand_less : Icons.expand_more,
                                color: Colors.black, // Change icon color here
                              ),
                              header: Text(chapter.title!,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              content: Obx(() {
                                final topics = controller.topicListModel
                                    .where((topic) => topic.chapterId == chapter.id)
                                    .toList();
                                return Column(
                                  children: topics.map<Widget>((TopicItem topic) {
                                    return ListTile(
                                      leading: const Icon(Icons.check_box,
                                          color: Colors
                                              .blue), // Add appropriate icons for lessons and quizzes
                                      title: Text(topic.title!,
                                          style: const TextStyle(fontSize: 14)),
                                      onTap: () =>
                                          controller.selectContent(topic.id!),
                                    );
                                  }).toList(),
                                );
                              }),
                            );
                          }).toList(),
                        );
                      }),
                      Obx(() {
                        if (controller.courseDetailData.value?.worksheetTemplates !=
                            null) {
                          return Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(QuizAttemptScreen.routeName);
                              },
                              child: const Text('Làm bài quiz cuối cùng'),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      })
                    ],
                  ),
                ),
              ),
              // Right Section: Course Content
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Obx(() {
                    final topicDetail = controller.topicDetailData.value;
                    if (topicDetail != null) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              topicDetail.title ?? 'No Title',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              topicDetail.description ?? 'No Description',
                              style: const TextStyle(fontSize: 16),
                            ),
                            // Add more custom widgets here using topicDetail data
                            const SizedBox(height: 16),
                            const Text(
                              'Additional Custom Data:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            if (topicDetail.questions != null &&
                                topicDetail.questions!.isNotEmpty)
                              ...topicDetail.questions!.map((question) =>
                                  Text('Question: ${question.content}')),
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
        ],
      ),
    );
  }
}
