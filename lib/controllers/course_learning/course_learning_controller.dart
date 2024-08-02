import 'package:get/get.dart';

class CourseLearningController extends GetxController {
  var selectedContent = 'Select a topic to see the content'.obs;
  var sections = <Section>[
    Section(
      title: 'Section 1',
      topics: ['Lesson 1', 'Quiz 1'],
    ),
    Section(
      title: 'Section 2',
      topics: ['Lesson 2', 'Quiz 2'],
    ),
  ].obs;

  void selectContent(String content) {
    selectedContent.value = content;
  }

  void togglePanel(int index) {
    sections[index].isExpanded = !sections[index].isExpanded;
    sections.refresh();
  }
}

class Section {
  final String title;
  final List<String> topics;
  bool isExpanded;

  Section({
    required this.title,
    required this.topics,
    this.isExpanded = false,
  });
}