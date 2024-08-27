import 'dart:typed_data';
import 'dart:ui_web';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:beanmind_flutter/controllers/course_learning/course_learning_controller.dart';
import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/game_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:beanmind_flutter/screens/course/course_play_game_screen.dart';
import 'package:beanmind_flutter/screens/game/game_leaderboard_screen.dart';
import 'package:beanmind_flutter/screens/quiz/quiz_attempt_screen.dart';
import 'package:beanmind_flutter/widgets/common/custom_learning_course_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:js' as js;


class CourseLearningScreen extends GetView<CourseLearningController> {
  const CourseLearningScreen({super.key});

  static const String routeName = '/course_learning/course_id=:id';

  Future<Uint8List> fetchPdfFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load PDF');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    Get.find<GameController>();

    return Scaffold(
      appBar: const CustomLearningCourseAppBar(),
      body: Row(
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
                              margin: const EdgeInsets.symmetric(vertical: 8),
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
                            controller.expandedChapters[chapter.id] ?? false;
                        return AccordionSection(
                          isOpen: isExpanded,
                          rightIcon: Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more,
                            color: Colors.black,
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
                            List<Widget> topicWidgets =
                                topics.map<Widget>((TopicItem topic) {
                              // final isSelected =
                              //     controller.selectedTopicId.value == topic.id;
                              final isSelected =
                                  controller.selectedTopicId.value == '';
                              return ListTile(
                                leading: Obx(() {
                                  final isChecked =
                                      controller.processionModelItemList.any(
                                    (processionItem) =>
                                        processionItem.topicId == topic.id,
                                  );
                                  return Icon(
                                    isChecked
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color:
                                        isChecked ? Colors.green : Colors.grey,
                                  );
                                }),
                                title: Text(topic.title!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        // color: isSelected
                                        //     ? Colors.blue
                                        //     : Colors.black)),
                                        color : Colors.black)),
                                tileColor:
                                    isSelected ? Colors.blue[50] : Colors.white,
                                onTap: () =>
                                    controller.selectContent(topic.id!),
                              );
                            }).toList();

                            if (chapter.hasGame) {
                              final chapterGame = controller.chapterGameItemList
                                  .where((p0) => p0.chapterId == chapter.id);
                              for (var game in chapterGame) {
                                topicWidgets.add(ListTile(
                                  leading: const Icon(Icons.videogame_asset,
                                      color: Colors.blue),
                                  title: Text('${game.game!.name}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.leaderboard, color: Colors.green),
                                    onPressed: () {
                                      // const leaderboardRoute = GameLeaderboardScreen.routeName;
                                      Get.toNamed(GameLeaderboardScreen.routeName,
                                        arguments: GameModel(
                                          id: game.gameId!,
                                          title: game.game!.name!,
                                          imageUrl: game.game!.image ?? '',
                                          description: game.game!.description!,
                                        ),);
                                    },
                                  ),
                                  onTap: () {
                                    final route = CoursePlayGameScreen.routeName
                                        .replaceFirst(':game_id', game.gameId!)
                                    .replaceFirst(':course_id', controller.courseId);
                                    Get.toNamed(route);
                                  },
                                ));
                              }
                            }
                            return Column(children: topicWidgets);
                          }),
                        );
                      }).toList(),
                    );
                  }),
                  Obx(() {
                    if (controller.worksheetAttemptModelItem.isNotEmpty) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
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
                            children: controller.worksheetAttemptModelItem
                                .map((worksheetAttempt) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.assignment,
                                        color: Colors.blue[700]),
                                    title: Text(
                                      worksheetAttempt.worksheet!.title!,
                                      style: const TextStyle(
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
                                    trailing: Icon(Icons.arrow_forward_ios,
                                        size: 16, color: Colors.grey[600]),
                                    onTap: () {
                                      final route = QuizAttemptScreen.routeName
                                          .replaceFirst(
                                              ':course_id', controller.courseId)
                                          .replaceFirst(':worksheet_id',
                                              worksheetAttempt.worksheet!.id!)
                                          .replaceFirst(':worksheet_attempt_id',
                                              worksheetAttempt.id!);
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
          // Right Section: Course Content or Game
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
              constraints: BoxConstraints(minHeight: screenHeight),
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
                if (controller.courseDetailData.value == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.selectedContent.value == 'pdf' &&
                    controller.courseDetailData.value!.contentURL != null) {
                  String viewId = 'pdf-viewer-${UniqueKey()}';

                  platformViewRegistry.registerViewFactory(
                    viewId,
                        (int viewId) {
                      final element = html.IFrameElement();
                      element.src = '${controller.courseDetailData.value!.contentURL}';
                      element.style.border = 'none';
                      element.style.width = '100%';
                      element.style.height = '100%';
                      element.style.overflow = 'auto';
                      element.setAttribute('scrolling', 'yes');

                      js.context.callMethod('eval', [
                        '''
      (function() {
        var element = document.querySelector('iframe');
        if (element) {
          element.style.overflow = 'auto';
          element.style.webkitOverflowScrolling = 'touch';
        }
      })()
      '''
                      ]);

                      return element;
                    },
                  );

                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: HtmlElementView(viewType: viewId),
                  );

                  // return Expanded(
                  //   child: SfPdfViewer.network(
                  //     controller.courseDetailData.value!.contentURL!,
                  //     key: Key('pdf_viewer'),
                  //     canShowScrollHead: true,
                  //     canShowPaginationDialog: true,
                  //     initialZoomLevel: 1.0,
                  //   ),
                  // );
                } else {
                  final topicDetail = controller.topicDetailData.value;
                  if (topicDetail != null) {
                    final chapterDetail = controller.chapterList.firstWhere(
                      (chapter) => chapter.id == topicDetail.chapterId,
                      orElse: () => ChapterItem(id: '', title: 'No Chapter'),
                    );
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.courseDetailData.value!.title ??
                                'No Title',
                            style: const TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            controller.courseDetailData.value!.description ??
                                'No Description',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            chapterDetail.title ?? 'No Title',
                            style: const TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            chapterDetail.description ?? 'No Description',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 40),
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
                        ],
                      ),
                    );
                  } else {
                    if (controller.selectedContent.value == '') {
                      if (controller.courseDetailData.value == null) {
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
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.courseDetailData.value!.title ??
                                    'No Title',
                                style: const TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                controller
                                        .courseDetailData.value!.description ??
                                    'No Description',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      }
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
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
