import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/course_detail_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CourseLearningController extends GetxController {
  late String courseId;
  var courseDetailModel = Rxn<CourseDetailModel>();
  var courseDetailData = Rxn<CourseDetailData>();
  var chapterModel = Rxn<ChapterModel>();
  var chapterList = <ChapterItem>[].obs;
  var topicModel = Rxn<TopicModel>();
  var topicListModel = <TopicItem>[].obs;

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

  @override
  void onInit() {
    courseId = Get.parameters['id']!;
    super.onInit();
  }

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