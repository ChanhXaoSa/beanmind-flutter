import 'dart:convert';

import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/models/course_level_model.dart';
import 'package:beanmind_flutter/models/course_model.dart';
import 'package:beanmind_flutter/models/enrollment_model.dart';
import 'package:beanmind_flutter/models/program_type_model.dart';
import 'package:beanmind_flutter/models/subject_model.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/screens/course/course_detail_screen.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var courseModel = Rxn<CourseModel>();
  var courseItemList = <CourseModelItem>[].obs;
  var enrollmentModel = Rxn<EnrollmentModel>();
  var courseLevelItemList = <CourseLevelModelItem>[].obs;
  var programTypeItemList = <ProgramTypeModelItem>[].obs;
  var subjectItemList = <SubjectModelItem>[].obs;
  var user = Rx<UserModel?>(null);

  var selectedFilterTags = <String, String>{}.obs;
  var filterSelections = <String, String?>{}.obs;
  var selectedFilterIds = <String, String?>{}.obs;

  @override
  void onInit() {
    fetchCourseLevel();
    fetchProgramType();
    fetchSubject();
    checkLoginStatus();
    fetchCourses();
    super.onInit();
  }

  Future<void> checkLoginStatus() async {
    UserModel? sessionUser = await Get.find<AuthController>().getUserLocal();
    if (sessionUser != null) {
      user.value = sessionUser;
      fetchEnrollments();
    }
  }

  Future<void> fetchSubject() async {
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/subjects'),
          headers: getHeaders(''),
      );
      if (response.statusCode == 200) {
        final modelBase = SubjectModel.fromJson(json.decode(response.body));
        subjectItemList.addAll(modelBase.data!.items!);
        if (kDebugMode) {
          print('fetch subject success, count = ${subjectItemList.length}');
        }
      } else {
        throw Exception('Failed to subject type');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }

  Future<void> fetchProgramType() async {
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/program-types'),
          headers: getHeaders(''),
      );
      if (response.statusCode == 200) {
        final modelBase = ProgramTypeModel.fromJson(json.decode(response.body));
        programTypeItemList.addAll(modelBase.data!.items!);
        if (kDebugMode) {
          print('fetch program type success, count = ${programTypeItemList.length}');
        }
      } else {
        throw Exception('Failed to fetch program type');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }

  Future<void> fetchCourseLevel() async {
    try {
      final response = await http.get(
          Uri.parse('$newBaseApiUrl/course-levels'),
          headers: getHeaders(''),
      );
      if (response.statusCode == 200) {
        final modelBase = CourseLevelModel.fromJson(json.decode(response.body));
        courseLevelItemList.addAll(modelBase.data!.items!);
        if (kDebugMode) {
          print('fetch course level success, count = ${courseLevelItemList.length}');
        }
      } else {
        throw Exception('Failed to fetch course level');
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
          headers: getHeaders(''),
      );
      if (response.statusCode == 200) {
        final enrollmentModelBase = EnrollmentModel.fromJson(json.decode(response.body));
        enrollmentModel.value = enrollmentModelBase;
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

  Future<void> fetchCourses() async {
    try {
      final courseResponse = await http.get(
        Uri.parse('$newBaseApiUrl/courses'),
        headers: getHeaders(''),
      );
      if (courseResponse.statusCode == 200) {
        final courseModelBase = CourseModel.fromJson(json.decode(courseResponse.body));
        courseModel.value = courseModelBase;
        courseItemList.addAll(courseModelBase.data!.items!);
        if (kDebugMode) {
          print(courseModel.value.toString());
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

  Future<void> fetchCoursesFiltered(String subjectId, String programTypeId, String courseLevelId) async {
    try {
      final courseResponse = await http.get(
          Uri.parse('$newBaseApiUrl/courses?SubjectId=$subjectId&ProgramTypeId=$programTypeId&CourseLevelId=$courseLevelId'),
          headers: getHeaders(''),
      );
      if (courseResponse.statusCode == 200) {
        final courseModelBase = CourseModel.fromJson(json.decode(courseResponse.body));
        courseModel.value = courseModelBase;
        courseItemList.assignAll(courseModelBase.data!.items!);
        if (kDebugMode) {
          print(courseModel.value.toString());
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

  void addFilterId(String title, String id, String displayName) {
    selectedFilterTags[title] = displayName;
    filterSelections[title] = id;
  }

  void removeFilterId(String title) {
    selectedFilterTags.remove(title);
    filterSelections[title] = null;
    applyFilters();
  }

  String? getFilterId(String title) {
    return filterSelections[title];
  }

  void applyFilters() {
    final subjectId = filterSelections['Môn học'] ?? '00000000-0000-0000-0000-000000000000';
    final programTypeId = filterSelections['Chương trình học'] ?? '00000000-0000-0000-0000-000000000000';
    final courseLevelId = filterSelections['Lớp'] ?? '00000000-0000-0000-0000-000000000000';

    fetchCoursesFiltered(subjectId, programTypeId, courseLevelId);
  }

  void addFilterTag(String title, String tag) {
    selectedFilterTags[title] = tag;
    filterSelections[title] = tag;
  }

  void removeFilterTag(String title) {
    selectedFilterTags.remove(title);
    filterSelections[title] = null;
  }

  String? getSelectedOption(String title) {
    return filterSelections[title];
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

  List<CourseModelItem> addCourseEnrolled() {
    if (user.value?.data?.enrollments == null) return [];
    List<CourseModelItem> list = [];
    for (var enrollment in user.value!.data!.enrollments!) {
      var course = courseItemList.where((c) => c.id == enrollment.courseId).first;
      list.add(course);
    }
    return list;
  }

  void navigateToCourseDetail(String id) {
    Get.toNamed(CourseDetailScreen.routeName.replaceFirst(':id', id));
  }
}