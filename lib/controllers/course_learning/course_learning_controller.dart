import 'dart:convert';

import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/models/chapter_model.dart';
import 'package:beanmind_flutter/models/course_detail_model.dart';
import 'package:beanmind_flutter/models/enrollment_model.dart';
import 'package:beanmind_flutter/models/participant_model.dart';
import 'package:beanmind_flutter/models/procession_model.dart';
import 'package:beanmind_flutter/models/topic_detail_model.dart';
import 'package:beanmind_flutter/models/topic_model.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/models/worksheet_attempt_model.dart';
import 'package:beanmind_flutter/models/worksheet_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:flutter/foundation.dart';
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
  var user = Rx<UserModel?>(null);
  var enrollmentModelItem = Rxn<EnrollmentModelItem>();
  var participantModelItemList = <ParticipantModelItem>[].obs;
  var processionModelItemList = <ProcessionModelItem>[].obs;
  var worksheetAttemptModelItem = <WorksheetAttemptItem>[].obs;

  var selectedContent = 'Chọn nội dung bạn muốn học hôm nay'.obs;

  @override
  void onInit() {
    courseId = Get.parameters['id']!;
    checkLoginStatus();
    fetchCourseDetail();
    fetchChapter();
    super.onInit();
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
          Uri.parse('$newBaseApiUrl/enrollments?ApplicationUserId=${user.value!.data!.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final enrollmentModelBase = EnrollmentModel.fromJson(json.decode(response.body));
        enrollmentModelItem.value = enrollmentModelBase.data!.items!.firstWhere((element) => element.courseId == courseId,);
        if(enrollmentModelItem.value != null) {
          fetchParticipants(enrollmentModelItem.value!.id!);
          fetchWorksheetAttempt(enrollmentModelItem.value!.id!);
        }
        if (kDebugMode) {
          print('${enrollmentModelItem.value}fetch enrollment thanh cong');
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

  Future<void> fetchTopicContent(String topicId) async {
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/topics/$topicId'),
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
        const content = 'Đang tải';
        selectedContent.value = content;
      } else {
        throw Exception('Failed to fetch topic content');
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
        topicModel.value = topicModelBase;
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
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }

  Future<void> fetchChapter() async {
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
        // print('${chapterList.toString()}');
      } else {
        throw Exception('Failed to fetch chapter');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }

  Future<void> fetchCourseDetail() async {
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
        courseDetailModel.value = courseDetailModelBase;
        courseDetailData.value = courseDetailModelBase.data;
        if(courseDetailData.value?.worksheetTemplates !=
            null) {
          for(var worksheet in courseDetailData.value!.worksheetTemplates!) {
            fetchWorksheet(worksheet.id!);
          }
          // fetchWorksheet(courseDetailData.value!.worksheetTemplates!.first.id!);
        }
        // print(courseDetailModel.value.toString());
      } else {
        throw Exception('Failed to fetch course');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }

  Future<void> fetchWorksheet(String worksheetTemplateId) async {
    try {
      if (kDebugMode) {
        print(worksheetTemplateId);
      }
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/worksheets?WorksheetTemplateId=$worksheetTemplateId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final worksheetDetailModelBase = WorksheetModel.fromJson(json.decode(response.body));
        worksheetModel.value = worksheetDetailModelBase;
        worksheetListModel.addAll(worksheetDetailModelBase.data!.items!);
        if (kDebugMode) {
          // print(worksheetListModel.value.toString());
        }
      } else {
        throw Exception('Failed to fetch course');
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
      if (kDebugMode) {
        print(enrollmentId);
      }
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/worksheet-attempts?EnrollmentId=$enrollmentId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'ngrok-skip-browser-warning': 'true',
          }
      );
      if (response.statusCode == 200) {
        final modelBase = WorksheetAttemptModel.fromJson(json.decode(response.body));
        worksheetAttemptModelItem.addAll(modelBase.data!.items!.where((attempt) => attempt.status == 1));
        if (kDebugMode) {
          print('${worksheetAttemptModelItem.value.toString()} danh sach attempt ne ');
        }
      } else {
        throw Exception('Failed to fetch course');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
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