import 'dart:convert';

import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/course_detail_model.dart';
import 'package:beanmind_flutter/models/enrollment_model.dart';
import 'package:beanmind_flutter/models/participant_model.dart';
import 'package:beanmind_flutter/models/procession_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/models/worksheet_attempt_model.dart';
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
  var worksheetAttempt = <WorksheetAttemptItem>[].obs;
  var participantModelItemList = <ParticipantModelItem>[].obs;
  var processionModelItemList = <ProcessionModelItem>[].obs;

  @override
  void onInit() {
    checkLoginStatus();
    super.onInit();
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

  Future<void> fetchProcessions(String participantId) async {
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/processions?ParticipantId=$participantId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final processionModelBase = ProcessionModel.fromJson(json.decode(response.body));
        if(processionModelBase.data?.items != null) {
          processionModelItemList.addAll(processionModelBase.data!.items!);
        }
        if (kDebugMode) {
          print('${processionModelItemList.value}fetch procession thanh cong');
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

  Future<void> fetchParticipants(String enrollmentId) async {
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/participants?EnrollmentId=$enrollmentId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final participantModelBase = ParticipantModel.fromJson(json.decode(response.body));
        if(participantModelBase.data?.items != null) {
          participantModelItemList.addAll(participantModelBase.data!.items!);
        }
        if(participantModelItemList != []) {
          for(var item in participantModelItemList) {
            fetchProcessions(item.id!);
          }
        }
        if (kDebugMode) {
          print('${participantModelItemList.value}fetch participant thanh cong');
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

  Future<void> fetchEnrollments() async {
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/enrollments?ApplicationUserId=${user.value!.data!.id}&IsDeleted=1'),
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
            // fetchChapter(item.courseId!);
            fetchWorksheetAttempt(item.id!);
            fetchParticipants(item.id!);
          }
        }
        // if (kDebugMode) {
        //   print('enrollment id : ${enrollmentModel.value!.data!.items!.first.id}');
        // }
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

  Future<void> fetchWorksheetAttempt(String enrollmentId) async {
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/worksheet-attempts?EnrollmentId=$enrollmentId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final worksheetModelBase = WorksheetAttemptModel.fromJson(json.decode(response.body));
        if(worksheetModelBase.data?.items != null) {
          worksheetAttempt.addAll(worksheetModelBase.data!.items!.where((attempt) => attempt.status == 2));
        }
        // print('worksheet attempt for enroll ${worksheetAttempt.first.enrollmentId} id ${worksheetAttempt.first.id}');
      } else {
        throw Exception('Failed to fetch topic');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  List<ChapterItem> getChaptersByCourseId(String courseId) {
    return chapterList.where((chapter) => chapter.courseId == courseId).toList();
  }

  List<TopicItem> getTopicsByChapterId(String chapterId) {
    return topicListModel.where((topic) => topic.chapterId == chapterId).toList();
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
        fetchChapter(courseDetailModelBase.data!.id!);
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
