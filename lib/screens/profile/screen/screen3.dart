import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/models/course_detail_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:beanmind_flutter/screens/profile/result_worksheet_attempt_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const CourseListRegisteredScreen(),
    );
  }
}

class CourseListRegisteredScreen extends GetView<ProfileController> {
  static const headerStyle = TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
  static const contentStyleHeader = TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.normal);

  const CourseListRegisteredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "CÁC KHOÁ HỌC ĐÃ ĐĂNG KÝ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Search bar
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm nội dung bạn đã học",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                if (controller.courseDetailData.isEmpty) {
                  return const Center(child: Text('Không có khóa học nào.'));
                }
                return Accordion(
                  headerBorderColor: Colors.grey,
                  headerBackgroundColor: const Color.fromARGB(90, 227, 227, 227),
                  contentBorderColor: const Color.fromARGB(90, 227, 227, 227),
                  contentBackgroundColor: const Color.fromARGB(90, 227, 227, 227),
                  headerBackgroundColorOpened: Colors.blue[300],
                  contentBorderWidth: 3,
                  contentHorizontalPadding: 20,
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,
                  headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.light,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  children: controller.courseDetailData
                      .map((courseDetail) {
                    return AccordionSection(
                      isOpen: false,
                      header: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courseDetail.title ?? 'Không có tên',
                            style: const TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(() {
                            final totalSlots = courseDetail.totalSlot ?? 0;
                            final completedSlots = controller.participantModelItemList
                                .where((a) => a.enrollment!.courseId == courseDetail.id && a.isPresent == true)
                                .length;
                            final progress = totalSlots > 0 ? completedSlots / totalSlots : 0.0;

                            return buildProgressItem(
                              context,
                              'Thông tin khóa học',
                                progress,
                              '$completedSlots/$totalSlots',
                            );
                          }),
                        ],
                      ),
                      headerBackgroundColor: Colors.transparent,
                      headerBackgroundColorOpened: Colors.white,
                      headerBorderColor: Colors.black54,
                      headerBorderColorOpened: Colors.black54,
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.white,
                      contentBorderWidth: 1,
                      contentVerticalPadding: 30,
                      content: MyNestedAccordion(course: courseDetail),
                    );
                  }).toList(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class MyNestedAccordion extends GetView<ProfileController> {
  final CourseDetailData course;

  const MyNestedAccordion({required this.course, super.key});

  @override
  Widget build(context) {
    return Obx(() {
      // final chapters = controller.getChaptersByCourseId(course.id!);
      // final chapters = course.chapters ?? [];
      final chapters = controller.chapterList
          .where((chapter) => chapter.courseId == course.id)
          .toList();
      final worksheetAttempts = controller.worksheetAttempt
          .where((attempt) => attempt.enrollment?.courseId == course.id)
          .toList();

      if (controller.chapterList.isEmpty && controller.topicListModel.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (chapters.isEmpty) {
        return const Center(child: Text('Chưa có chương nào được tải.'));
      }

      return Accordion(
        paddingListTop: 0,
        paddingListBottom: 0,
        maxOpenSections: 1,
        headerBackgroundColorOpened: Colors.black54,
        children: [
          ...chapters.map((chapter) {
            return AccordionSection(
              isOpen: false,
              leftIcon: const Icon(Icons.insights_rounded, color: Colors.black),
              headerBackgroundColor: Colors.white,
              headerBackgroundColorOpened: Colors.white,
              header: Text(chapter.title ?? 'Không có tên chương',
                  style: CourseListRegisteredScreen.contentStyle),
              content: Obx(() {
                // final topics = controller.getTopicsByChapterId(chapter.id!);
                final topics = controller.topicListModel
                    .where((topic) => topic.chapterId == chapter.id)
                    .toList();
                if (topics.isEmpty) {
                  return const Center(child: Text('Chưa có chủ đề nào được tải.'));
                }

                return Column(
                  children: topics.map<Widget>((TopicItem topic) {
                    return ListTile(
                      leading: Obx(() {
                        final isChecked = controller.processionModelItemList.any(
                              (processionItem) => processionItem.topicId == topic.id,
                        );
                        return Icon(
                          isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                          color: isChecked ? Colors.green : Colors.grey,
                        );
                      }),
                      title: Text(topic.title!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )),
                      tileColor: Colors.white,
                      onTap: () => {},
                    );
                  }).toList(),
                );
              }),
              contentBackgroundColor: Colors.white,
              contentBorderColor: Colors.white,
            );
          }),
          if (worksheetAttempts.isNotEmpty)
            AccordionSection(
              isOpen: false,
              leftIcon: const Icon(Icons.history, color: Colors.black),
              headerBackgroundColor: Colors.white,
              headerBackgroundColorOpened: Colors.grey[200],
              header: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFAEE7AE),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.history, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Lịch sử làm bài',
                      style: CourseListRegisteredScreen.contentStyle,
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ],
                ),
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: worksheetAttempts.map((attempt) {
                  return InkWell(
                    onTap: () {
                      final route = ResultWorksheetAttemptScreen.routeName
                          .replaceFirst(':course_id', course.id!)
                          .replaceFirst(':worksheet_id', attempt.worksheet!.id!)
                          .replaceFirst(':worksheet_attempt_id', attempt.id!);
                      Get.toNamed(route);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Bài: ${attempt.worksheet?.title ?? 'Không có tiêu đề'}',
                                  style: CourseListRegisteredScreen.headerStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                child: Text(
                                  'Điểm: ${attempt.score != null ? (attempt.score!).toString() : 'N/A'}',
                                  style: CourseListRegisteredScreen.contentStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                child: Text(
                                  'Thời gian: ${attempt.completionDate != null ? DateFormat('dd-MM-yyyy, HH:mm:ss').format(attempt.completionDate!.toLocal()) : 'N/A'}',
                                  style: CourseListRegisteredScreen.contentStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Nhấn vào để xem kết quả',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              contentBackgroundColor: Colors.white,
              contentBorderColor: Colors.grey[200],
            ),
        ],
      );
    });
  }
}

Widget buildProgressItem(BuildContext context, String title, double progress,
    String slots) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1 ? Colors.green : Colors.blue),
        ),
        const SizedBox(height: 5),
        Text(
          'Đã học: $slots slot',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}
