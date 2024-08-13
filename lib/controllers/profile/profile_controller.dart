import 'dart:convert';

import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/course_detail_model.dart';
import 'package:beanmind_flutter/models/enrollment_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/screens/screens.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var user = Rx<UserModel?>(null);
  var enrollmentModel = Rxn<EnrollmentModel>();
  var courseDetailData = <CourseDetailData>[].obs;
  var chapterList = <ChapterItem>[].obs;
  var topicListModel = <TopicItem>[].obs;

  @override
  void onReady() {
    checkLoginStatus();
    super.onReady();
  }

  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Future<void> checkLoginStatus() async {
    UserModel? sessionUser = await Get.find<AuthController>().getUserLocal();
    if (sessionUser != null) {
      user.value = sessionUser;
      fetchEnrollments();
    }
  }

  Future<void> fetchEnrollments() async {
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/enrollments?ApplicationUserId=${user.value!.data!.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final enrollmentModelBase = EnrollmentModel.fromJson(json.decode(response.body));
        enrollmentModel.value = enrollmentModelBase;
        if(enrollmentModel.value?.data?.items != []) {
          for(var item in enrollmentModel.value!.data!.items!) {
            fetchCourseDetail(item.courseId!);
            fetchChapter(item.courseId!);
          }
        }
        if (kDebugMode) {
          print(enrollmentModel.value.toString());
        }
      } else {
        throw Exception('Failed to fetch enrollment');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }

  Future<void> fetchTopic(String chapterId) async {
    try {
      final topicResponse = await http.get(
          Uri.parse('$newBaseApiUrl/topics?ChapterId=$chapterId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (topicResponse.statusCode == 200) {
        final topicModelBase = TopicModel.fromJson(json.decode(topicResponse.body));
        if(topicModelBase.data?.items != null) {
          topicListModel.addAll(topicModelBase.data!.items!);
        }
        // for (var topic in topicListModel) {
        //   print('Topic: ${topic.title}, ChapterId: ${topic.chapterId}');
        // }
      } else {
        throw Exception('Failed to fetch topic');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> fetchChapter(String courseId) async {
    try {
      final chapterResponse = await http.get(
          Uri.parse('$newBaseApiUrl/chapters?CourseId=$courseId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (chapterResponse.statusCode == 200) {
        final chapterModelBase = ChapterModel.fromJson(json.decode(chapterResponse.body));
        if(chapterModelBase.data?.items != null)  {
          chapterList.assignAll(chapterModelBase.data!.items!);
          for (var chapter in chapterList) {
            fetchTopic(chapter.id!);
          }
        }
        // if(chapterModelBase.data?.items != null)  {
        //   for (var chapter in chapterModelBase.data!.items!) {
        //     fetchTopic(chapter.id!);
        //   }
        // }
        // print('${chapterList.toString()}');
      } else {
        throw Exception('Failed to fetch chapter');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> fetchCourseDetail(String courseId) async {
    try {
      final courseResponse = await http.get(
          Uri.parse('$newBaseApiUrl/courses/$courseId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (courseResponse.statusCode == 200) {
        final courseDetailModelBase = CourseDetailModel.fromJson(json.decode(courseResponse.body));
        courseDetailData.add(courseDetailModelBase.data!);
        print('add course detail success with id ${courseDetailModelBase.data!.id}');
      } else {
        throw Exception('Failed to fetch course detail');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }

  List<dynamic> gameHistories = [];

  void navigateToCourseDetail(String id) {
    Get.toNamed(CourseDetailScreen.routeName.replaceFirst(':id', id));
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }
}
