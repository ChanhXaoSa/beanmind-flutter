import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:beanmind_flutter/controllers/course_learning/course_learning_controller.dart';
import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:beanmind_flutter/screens/quiz/quiz_attempt_screen.dart';
import 'package:beanmind_flutter/widgets/common/custom_learning_course_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart'; // Import package shimmer

class CourseLearningScreen extends GetView<CourseLearningController> {
  const CourseLearningScreen({super.key});

  static const String routeName = '/course_learning/course_id=:id';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomLearningCourseAppBar(),
      body: SingleChildScrollView(
        child: Column(
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
                          if (controller.chapterList.isEmpty) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Column(
                                children: List.generate(3, (index) {
                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    height: 50,
                                    color: Colors.white,
                                  );
                                }),
                              ),
                            );
                          }
                          return Accordion(
                            maxOpenSections: 1,
                            headerBackgroundColor:
                                const Color.fromARGB(90, 227, 227, 227),
                            contentBorderColor:
                                const Color.fromARGB(90, 227, 227, 227),
                            contentBackgroundColor:
                                const Color.fromARGB(90, 227, 227, 227),
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
                                  controller.expandedChapters[chapter.id] ??
                                      false;
                              return AccordionSection(
                                isOpen: isExpanded,
                                rightIcon: Icon(
                                  isExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: Colors.black, // Change icon color here
                                ),
                                header: Text(chapter.title!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                content: Obx(() {
                                  final topics = controller.topicListModel
                                      .where((topic) =>
                                          topic.chapterId == chapter.id)
                                      .toList();
                                  return Column(
                                    children:
                                        topics.map<Widget>((TopicItem topic) {
                                      final isSelected =
                                          controller.selectedTopicId.value ==
                                              topic.id;
                                      return ListTile(
                                        leading: Obx(() {
                                          final isChecked = controller
                                              .processionModelItemList
                                              .any(
                                            (processionItem) =>
                                                processionItem.topicId ==
                                                topic.id,
                                          );
                                          return Icon(
                                            isChecked
                                                ? Icons.check_box
                                                : Icons.check_box_outline_blank,
                                            color: isChecked
                                                ? Colors.green
                                                : Colors.grey,
                                          );
                                        }),
                                        title: Text(topic.title!,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isSelected
                                                  ? Colors.blue
                                                  : Colors.black,
                                            )),
                                        tileColor: isSelected
                                            ? Colors.blue[50]
                                            : Colors.white,
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
                        // Obx(() {
                        //   if (controller.worksheetAttemptModelItem != []) {
                        //     return Column(
                        //       children: controller.worksheetAttemptModelItem
                        //           .map((worksheetAttempt) {
                        //         return Padding(
                        //           padding:
                        //               const EdgeInsets.symmetric(vertical: 8.0),
                        //           child: Center(
                        //             child: ElevatedButton(
                        //               onPressed: () {
                        //                 final route = QuizAttemptScreen
                        //                     .routeName
                        //                     .replaceFirst(':course_id',
                        //                         controller.courseId)
                        //                     .replaceFirst(':worksheet_id',
                        //                         worksheetAttempt.worksheet!.id!)
                        //                     .replaceFirst(
                        //                         ':worksheet_attempt_id',
                        //                         worksheetAttempt.id!);
                        //                 Get.toNamed(route);
                        //               },
                        //               child: Text(
                        //                   '${worksheetAttempt.worksheet!.title}'),
                        //             ),
                        //           ),
                        //         );
                        //       }).toList(),
                        //     );
                        //   } else {
                        //     return Container();
                        //   }
                        // })
                        Obx(() {
                          if (controller.worksheetAttemptModelItem.isNotEmpty) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'Bài tập giáo viên giao:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: controller.worksheetAttemptModelItem.map((worksheetAttempt) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          leading: Icon(Icons.assignment, color: Colors.blue[700]),
                                          title: Text(
                                            worksheetAttempt.worksheet!.title!,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          // subtitle: Text(
                                          //   'Ngày giao: ${DateFormat('dd/MM/yyyy').format(worksheetAttempt.!)}',
                                          //   style: TextStyle(
                                          //     color: Colors.grey[600],
                                          //     fontSize: 14,
                                          //   ),
                                          // ),
                                          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
                                          onTap: () {
                                            final route = QuizAttemptScreen.routeName
                                                .replaceFirst(':course_id', controller.courseId)
                                                .replaceFirst(':worksheet_id', worksheetAttempt.worksheet!.id!)
                                                .replaceFirst(':worksheet_attempt_id', worksheetAttempt.id!);
                                            Get.toNamed(route);
                                          },
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
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
                    constraints: BoxConstraints(
                      minHeight: screenHeight,
                    ),
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
                            ],
                          ),
                        );
                      } else {
                        if (controller.selectedContent.value ==
                            'Chọn nội dung bạn muốn học hôm nay') {
                          return Center(
                              child: Text(controller.selectedContent.value));
                        }
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 24,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                height: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                height: 200,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
