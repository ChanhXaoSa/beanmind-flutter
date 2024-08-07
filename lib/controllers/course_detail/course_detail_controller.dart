import 'dart:convert';
import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/course_detail_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CourseDetailController extends GetxController {
  var courseDetailModel = Rxn<CourseDetailModel>();
  var courseDetailData = Rxn<CourseDetailData>();
  var chapterModel = Rxn<ChapterModel>();
  var chapterList = <ChapterItem>[].obs;
  var topicModel = Rxn<TopicModel>();
  var topicListModel = <TopicItem>[].obs;
  var expandedChapters = <String, bool>{}.obs;
  var user = Rx<UserModel?>(null);
  late String courseId;

  @override
  void onInit() {
    checkLoginStatus();
    courseId = Get.parameters['id']!;
    fetchCourseDetail();
    fetchChapter();
    super.onInit();
  }

  Future<void> checkLoginStatus() async {
    UserModel? sessionUser = await Get.find<AuthController>().getUserLocal();
    if (sessionUser != null) {
      user.value = sessionUser;
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
        print(courseDetailModel.value.toString());
      } else {
        throw Exception('Failed to fetch course');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  bool isCourseEnrolled(String courseId) {
    if (user.value?.data?.enrollments == null) return false;
    for (var enrollment in user.value!.data!.enrollments!) {
      if (enrollment.courseId == courseId) {
        return true;
      }
    }
    return false;
  }

  void toggleChapterExpansion(String chapterId) {
    expandedChapters[chapterId] = !(expandedChapters[chapterId] ?? false);
    update();
  }
}