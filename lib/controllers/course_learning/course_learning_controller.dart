import 'dart:convert';

import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/course_detail_model.dart';
import 'package:beanmind_flutter/models/topic_detail_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:beanmind_flutter/models/worksheet_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
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
  var worksheetModel = Rxn<WorksheetModel>();
  var worksheetListModel = <WorksheetItem>[].obs;
  var expandedChapters = <String, bool>{}.obs;
  var topicDetailModel = Rxn<TopicDetailModel>();
  var topicDetailData = Rxn<TopicDetailData>();

  var selectedContent = 'Chọn nội dung bạn muốn học hôm nay'.obs;

  @override
  void onInit() {
    courseId = Get.parameters['id']!;
    fetchCourseDetail();
    fetchChapter();
    super.onInit();
  }

  Future<void> fetchTopicContent(String topicId) async {
    try {
      final response = await http.get(
          Uri.parse('${newBaseApiUrl}/topics/${topicId}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final topicDetailModelBase = TopicDetailModel.fromJson(json.decode(response.body));
        topicDetailModel.value = topicDetailModelBase;
        topicDetailData.value = topicDetailModelBase.data;
        // final content = json.decode(response.body)['message'];
        final content = 'Đang tải';
        selectedContent.value = content;
      } else {
        throw Exception('Failed to fetch topic content');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> fetchTopic(String chapterId) async {
    try {
      final topicResponse = await http.get(
          Uri.parse('${newBaseApiUrl}/topics?ChapterId=${chapterId}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (topicResponse.statusCode == 200) {
        final topicModelBase = TopicModel.fromJson(json.decode(topicResponse.body));
        topicModel.value = topicModelBase;
        if(topicModelBase.data?.items != null) {
          topicListModel.addAll(topicModelBase.data!.items!);
        }
        for (var topic in topicListModel) {
          print('Topic: ${topic.title}, ChapterId: ${topic.chapterId}');
        }
      } else {
        throw Exception('Failed to fetch topic');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> fetchChapter() async {
    try {
      final chapterResponse = await http.get(
          Uri.parse('${newBaseApiUrl}/chapters?CourseId=${courseId}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (chapterResponse.statusCode == 200) {
        final chapterModelBase = ChapterModel.fromJson(json.decode(chapterResponse.body));
        chapterModel.value = chapterModelBase;
        if(chapterModelBase.data?.items != null)  {
          chapterList.assignAll(chapterModelBase.data!.items!);
          for (var chapter in chapterList) {
            fetchTopic(chapter.id!);
            expandedChapters[chapter.id!] = false;
          }
        }
        // if(chapterModelBase.data?.items != null)  {
        //   for (var chapter in chapterModelBase.data!.items!) {
        //     fetchTopic(chapter.id!);
        //   }
        // }
        print('${chapterList.toString()}');
      } else {
        throw Exception('Failed to fetch chapter');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> fetchCourseDetail() async {
    try {
      final courseResponse = await http.get(
          Uri.parse('${newBaseApiUrl}/courses/${courseId}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (courseResponse.statusCode == 200) {
        final courseDetailModelBase = CourseDetailModel.fromJson(json.decode(courseResponse.body));
        courseDetailModel.value = courseDetailModelBase;
        courseDetailData.value = courseDetailModelBase.data;
        if(courseDetailData.value?.worksheetTemplates !=
            null) {
          fetchWorksheet(courseDetailData.value!.worksheetTemplates!.first.id!);
        }
        print(courseDetailModel.value.toString());
      } else {
        throw Exception('Failed to fetch course');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> fetchWorksheet(String worksheetTemplateId) async {
    try {
      final response = await http.get(
          Uri.parse('${newBaseApiUrl}/worksheets?WorksheetTemplateId=${worksheetTemplateId}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final worksheetDetailModelBase = WorksheetModel.fromJson(json.decode(response.body));
        worksheetModel.value = worksheetDetailModelBase;
        worksheetListModel.assignAll(worksheetDetailModelBase.data!.items!);
        print(worksheetListModel.value.toString());
      } else {
        throw Exception('Failed to fetch course');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  void toggleChapterExpansion(String chapterId) {
    expandedChapters[chapterId] = !(expandedChapters[chapterId] ?? false);
    update();
  }

  var selectedTopicId = ''.obs;

  void selectContent(String topicId) {
    selectedTopicId.value = topicId;  // Cập nhật biến này
    topicDetailModel.value = null;
    topicDetailData.value = null;
    fetchTopicContent(topicId);
  }
}