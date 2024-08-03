import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CourseListHistoryScreen(),
    );
  }
}

class CourseListHistoryScreen extends StatelessWidget {
  final List<Course> courses = [
    Course(name: "Course 1", registrationDate: "2023-07-01", isCompleted: true),
    Course(
        name: "Course 2", registrationDate: "2023-07-05", isCompleted: false),
    Course(name: "Course 3", registrationDate: "2023-07-10", isCompleted: true),
    Course(
        name: "Course 4", registrationDate: "2023-07-15", isCompleted: false),
    Course(name: "Course 5", registrationDate: "2023-07-20", isCompleted: true),
    Course(
        name: "Course 6", registrationDate: "2023-07-25", isCompleted: false),
    Course(name: "Course 7", registrationDate: "2023-07-30", isCompleted: true),
    Course(
        name: "Course 8", registrationDate: "2023-08-01", isCompleted: false),
    Course(name: "Course 1", registrationDate: "2023-07-01", isCompleted: true),
    Course(
        name: "Course 2", registrationDate: "2023-07-05", isCompleted: false),
    Course(name: "Course 3", registrationDate: "2023-07-10", isCompleted: true),
    Course(
        name: "Course 4", registrationDate: "2023-07-15", isCompleted: false),
    Course(name: "Course 5", registrationDate: "2023-07-20", isCompleted: true),
    Course(
        name: "Course 6", registrationDate: "2023-07-25", isCompleted: false),
    Course(name: "Course 7", registrationDate: "2023-07-30", isCompleted: true),
    Course(
        name: "Course 8", registrationDate: "2023-08-01", isCompleted: false),
  ];

  static const headerStyle =
      TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
  static const contentStyleHeader =
      TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(
      color: Colors.black, fontSize: 25, fontWeight: FontWeight.normal);
  static const loremIpsum =
      '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';
  static const slogan =
      'Do not forget to play around with all sorts of colors, backgrounds, borders, etc.';

  CourseListHistoryScreen({super.key});

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
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "LỊCH SỬ HỌC TẬP",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //search bar
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm nội dung bạn đã học",
                        prefixIcon: Icon(Icons.search),
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
              child: Accordion(
                headerBorderColor: Colors.grey,
                headerBorderColorOpened: Colors.grey,
                // headerBorderWidth: 1,
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
                children: [
                  AccordionSection(
                    isOpen: false,
                    leftIcon: const Icon(Icons.book, color: Colors.black),
                    header: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tên khoá học 1',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        buildProgressItem(
                            context, 'Tiến độ học tập', 0.6, '6/10', '12 giờ'),
                      ],
                    ),
                    headerBackgroundColor: Colors.transparent,
                    headerBackgroundColorOpened: Colors.white,
                    headerBorderColor: Colors.black54,
                    headerBorderColorOpened: Colors.black54,
                    // headerBorderWidth: 1,
                    contentBackgroundColor: Colors.white,
                    contentBorderColor: Colors.white,
                    contentBorderWidth: 1,
                    contentVerticalPadding: 30,
                    content: const MyNestedAccordion(),
                  ),
                  AccordionSection(
                    isOpen: false,
                    leftIcon: const Icon(Icons.book, color: Colors.black),
                    header: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tên khoá học 2',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        buildProgressItem(
                            context, 'Tiến độ học tập', 0.9, '9/10', '10 giờ'),
                      ],
                    ),
                    headerBackgroundColor: Colors.transparent,
                    headerBackgroundColorOpened: Colors.white,
                    headerBorderColor: Colors.black54,
                    headerBorderColorOpened: Colors.black54,
                    // headerBorderWidth: 1,
                    contentBackgroundColor: Colors.white,
                    contentBorderColor: Colors.white,
                    contentBorderWidth: 1,
                    contentVerticalPadding: 30,
                    content: const MyNestedAccordion(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyNestedAccordion extends StatelessWidget //__
{
  const MyNestedAccordion({super.key});

  @override
  Widget build(context) //__
  {
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
                leftIcon:
                    const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: Colors.white,
                headerBackgroundColorOpened: Colors.white,
                header: const Text('Chủ đề 1',
                    style: CourseListHistoryScreen.headerStyle),
                contentBackgroundColor: Colors.white,
                contentBorderColor: Colors.white,
                content: Accordion(
                  leftIcon:
                      const Icon(Icons.insights_rounded, color: Colors.white),
                  headerBackgroundColor: Colors.black38,
                  headerBackgroundColorOpened: Colors.black54,
                  contentBackgroundColor: Colors.white,
                  contentBorderColor: Colors.white,
                  children: [
                    AccordionSection(
                      leftIcon: const Icon(Icons.insights_rounded,
                          color: Colors.white),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: const Text('Nội dung bài học #1',
                          style: CourseListHistoryScreen.headerStyle),
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.white,
                      content: Column(
                        children: [
                          Text(
                            CourseListHistoryScreen.loremIpsum,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                          Text(
                            CourseListHistoryScreen.slogan,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                        ],
                      ),
                    ),
                    AccordionSection(
                      leftIcon: const Icon(Icons.insights_rounded,
                          color: Colors.white),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: const Text('Nội dung bài học #2',
                          style: CourseListHistoryScreen.headerStyle),
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.white,
                      content: Column(
                        children: [
                          Text(
                            CourseListHistoryScreen.loremIpsum,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                          Text(
                            CourseListHistoryScreen.slogan,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                        ],
                      ),
                    ),
                    AccordionSection(
                      leftIcon: const Icon(Icons.insights_rounded,
                          color: Colors.white),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: const Text('Nội dung bài học #3',
                          style: CourseListHistoryScreen.headerStyle),
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.white,
                      content: Column(
                        children: [
                          Text(
                            CourseListHistoryScreen.loremIpsum,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                          Text(
                            CourseListHistoryScreen.slogan,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          contentBackgroundColor: Colors.white,
          contentBorderColor: Colors.white,
        ),
        AccordionSection(
          isOpen: false,
          leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: const Text('Chương 2',
              style: CourseListHistoryScreen.headerStyle),
          content: Accordion(
            leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            contentBackgroundColor: Colors.white,
            contentBorderColor: Colors.white,
            children: [
              AccordionSection(
                leftIcon:
                    const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: Colors.white,
                headerBackgroundColorOpened: Colors.white,
                header: const Text('Chủ đề 1',
                    style: CourseListHistoryScreen.headerStyle),
                contentBackgroundColor: Colors.white,
                contentBorderColor: Colors.white,
                content: Accordion(
                  leftIcon:
                      const Icon(Icons.insights_rounded, color: Colors.white),
                  headerBackgroundColor: Colors.black38,
                  headerBackgroundColorOpened: Colors.black54,
                  contentBackgroundColor: Colors.white,
                  contentBorderColor: Colors.white,
                  children: [
                    AccordionSection(
                      leftIcon: const Icon(Icons.insights_rounded,
                          color: Colors.white),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: const Text('Nội dung bài học #1',
                          style: CourseListHistoryScreen.headerStyle),
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.white,
                      content: Column(
                        children: [
                          Text(
                            CourseListHistoryScreen.loremIpsum,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                          Text(
                            CourseListHistoryScreen.slogan,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                        ],
                      ),
                    ),
                    AccordionSection(
                      leftIcon: const Icon(Icons.insights_rounded,
                          color: Colors.white),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: const Text('Nội dung bài học #2',
                          style: CourseListHistoryScreen.headerStyle),
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.white,
                      content: Column(
                        children: [
                          Text(
                            CourseListHistoryScreen.loremIpsum,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                          Text(
                            CourseListHistoryScreen.slogan,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                        ],
                      ),
                    ),
                    AccordionSection(
                      leftIcon: const Icon(Icons.insights_rounded,
                          color: Colors.white),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: const Text('Nội dung bài học #3',
                          style: CourseListHistoryScreen.headerStyle),
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.white,
                      content: Column(
                        children: [
                          Text(
                            CourseListHistoryScreen.loremIpsum,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                          Text(
                            CourseListHistoryScreen.slogan,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          contentBackgroundColor: Colors.white,
          contentBorderColor: Colors.white,
        ),
        AccordionSection(
          isOpen: false,
          leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
          headerBackgroundColor: Colors.white,
          headerBackgroundColorOpened: Colors.white,
          header: const Text('Chương 3',
              style: CourseListHistoryScreen.headerStyle),
          content: Accordion(
            leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
            headerBackgroundColor: Colors.white,
            headerBackgroundColorOpened: Colors.white,
            contentBackgroundColor: Colors.white,
            contentBorderColor: Colors.white,
            children: [
              AccordionSection(
                leftIcon:
                    const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: Colors.white,
                headerBackgroundColorOpened: Colors.white,
                header: const Text('Chủ đề 1',
                    style: CourseListHistoryScreen.headerStyle),
                contentBackgroundColor: Colors.white,
                contentBorderColor: Colors.white,
                content: Accordion(
                  leftIcon:
                      const Icon(Icons.insights_rounded, color: Colors.white),
                  headerBackgroundColor: Colors.black38,
                  headerBackgroundColorOpened: Colors.black54,
                  contentBackgroundColor: Colors.white,
                  contentBorderColor: Colors.white,
                  children: [
                    AccordionSection(
                      leftIcon: const Icon(Icons.insights_rounded,
                          color: Colors.white),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: const Text('Nội dung bài học #1',
                          style: CourseListHistoryScreen.headerStyle),
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.white,
                      content: Column(
                        children: [
                          Text(
                            CourseListHistoryScreen.loremIpsum,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                          Text(
                            CourseListHistoryScreen.slogan,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                        ],
                      ),
                    ),
                    AccordionSection(
                      leftIcon: const Icon(Icons.insights_rounded,
                          color: Colors.white),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: const Text('Nội dung bài học #2',
                          style: CourseListHistoryScreen.headerStyle),
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.white,
                      content: Column(
                        children: [
                          Text(
                            CourseListHistoryScreen.loremIpsum,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                          Text(
                            CourseListHistoryScreen.slogan,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                        ],
                      ),
                    ),
                    AccordionSection(
                      leftIcon: const Icon(Icons.insights_rounded,
                          color: Colors.white),
                      headerBackgroundColor: Colors.black38,
                      headerBackgroundColorOpened: Colors.black54,
                      header: const Text('Nội dung bài học #3',
                          style: CourseListHistoryScreen.headerStyle),
                      contentBackgroundColor: Colors.white,
                      contentBorderColor: Colors.white,
                      content: Column(
                        children: [
                          Text(
                            CourseListHistoryScreen.loremIpsum,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                          Text(
                            CourseListHistoryScreen.slogan,
                            style: CourseListHistoryScreen.contentStyle,
                          ),
                        ],
                      ),
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
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1 ? Colors.green : Colors.blue),
        ),
        SizedBox(height: 5),
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

class Course {
  final String name;
  final String registrationDate;
  final bool isCompleted;

  Course(
      {required this.name,
      required this.registrationDate,
      required this.isCompleted});
}

class CourseItem extends StatelessWidget {
  final Course course;
  final double width;
  final double height;

  const CourseItem(
      {required this.course, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the top left
        children: <Widget>[
          Image.network(
            "https://th.bing.com/th/id/OIP.hdTZOd3f6FNd6N2ocUVH_AAAAA?rs=1&pid=ImgDetMain",
            width: double.infinity,
            height: height * 0.4, // Adjust image height relative to item height
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Text(
            course.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Đăng kí: ${course.registrationDate}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            course.isCompleted ? "Hoàn thành" : "Chưa hoàn thành",
            style: TextStyle(
              fontSize: 14,
              color: course.isCompleted ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
