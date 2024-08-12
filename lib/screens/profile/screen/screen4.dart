import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:beanmind_flutter/models/enrollment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const CourseListHistoryScreen(),
    );
  }
}

class CourseListHistoryScreen extends GetView<ProfileController> {
  static const headerStyle = TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
  static const contentStyleHeader = TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.normal);

  const CourseListHistoryScreen({super.key});

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
                    "LỊCH SỬ HỌC TẬP",
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
                if (controller.enrollmentModel.value?.data?.items == null ||
                    controller.enrollmentModel.value!.data!.items!.isEmpty) {
                  return const Center(child: Text('Không có khóa học nào.'));
                }

                return Accordion(
                  headerBorderColor: Colors.grey,
                  headerBorderColorOpened: Colors.grey,
                  headerBackgroundColorOpened: Colors.grey[200],
                  contentBackgroundColor: Colors.grey[200],
                  contentBorderColor: Colors.grey[200],
                  contentBorderWidth: 3,
                  contentHorizontalPadding: 20,
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,
                  headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.light,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  children: controller.enrollmentModel.value!.data!.items!
                      .map((enrollmentItem) {
                    final course = enrollmentItem;
                    return AccordionSection(
                      isOpen: false,
                      leftIcon: const Icon(Icons.book, color: Colors.black),
                      header: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.course!.title ?? 'Không có tên',
                            style: const TextStyle(color: Colors.black, fontSize: 30),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          buildProgressItem(
                            context,
                            'Tiến độ học tập',
                            enrollmentItem.status == 2 ? 1 : 0,
                            '${course.course!.totalSlot ?? 0}/${course.course!.totalSlot ?? 0}',
                            'N/A',
                          ),
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
                      content: MyNestedAccordion(course: course),
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

class MyNestedAccordion extends StatelessWidget {
  final EnrollmentModelItem course;

  const MyNestedAccordion({required this.course, super.key});

  @override
  Widget build(context) {
    // Giả sử course có một danh sách chương (chapters)
    // Bạn cần cấu trúc này dựa trên mô hình thực tế của bạn.
    return Accordion(
      paddingListTop: 0,
      paddingListBottom: 0,
      maxOpenSections: 1,
      headerBackgroundColorOpened: Colors.black54,
      children: [
        AccordionSection(
          isOpen: false,
          leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: const Text('Chương 1',
              style: CourseListHistoryScreen.headerStyle),
          content: Accordion(
            leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            contentBackgroundColor: Colors.white,
            contentBorderColor: Colors.white,
            children: [
              AccordionSection(
                leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: Colors.white,
                headerBackgroundColorOpened: Colors.white,
                header: const Text('Chủ đề 1',
                    style: CourseListHistoryScreen.headerStyle),
                contentBackgroundColor: Colors.white,
                contentBorderColor: Colors.white,
                content: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nội dung bài học #1',
                      style: CourseListHistoryScreen.headerStyle,
                    ),
                    Text(
                      'CourseListHistoryScreen.loremIpsum',
                      style: CourseListHistoryScreen.contentStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          contentBackgroundColor: Colors.white,
          contentBorderColor: Colors.white,
        ),
      ],
    );
  }
}

Widget buildProgressItem(BuildContext context, String title, double progress,
    String slots, String time) {
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
        Text(
          'Thời gian đã học: $time',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}
