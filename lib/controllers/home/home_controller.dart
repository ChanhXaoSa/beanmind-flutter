import 'dart:convert';

import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/models/course_model.dart';
import 'package:beanmind_flutter/models/enrollment_model.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/screens/course/course_detail_screen.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var courseModel = Rxn<CourseModel>();
  var enrollmentModel = Rxn<EnrollmentModel>();
  var user = Rx<UserModel?>(null);

  var selectedCategories = <String>[].obs;
  var selectedInstructors = <String>[].obs;
  var selectedLanguages = <String>[].obs;
  var selectedLevels = <String>[].obs;

  @override
  void onInit() {
    checkLoginStatus();
    fetchCourses();
    super.onInit();
  }

  // Các phương thức cập nhật filter
  void updateCategories(List<String> categories) {
    selectedCategories.assignAll(categories);
  }

  void updateInstructors(List<String> instructors) {
    selectedInstructors.assignAll(instructors);
  }

  void updateLanguages(List<String> languages) {
    selectedLanguages.assignAll(languages);
  }

  void updateLevels(List<String> levels) {
    selectedLevels.assignAll(levels);
  }

  // Phương thức xóa tag
  void removeTag(String tag, String filterType) {
    if (filterType == 'category') {
      selectedCategories.remove(tag);
    } else if (filterType == 'instructor') {
      selectedInstructors.remove(tag);
    } else if (filterType == 'language') {
      selectedLanguages.remove(tag);
    } else if (filterType == 'level') {
      selectedLevels.remove(tag);
    }
  }

  void requestRemoveTag(String tag, String filterType) {
    Future.microtask(() {
      removeTag(tag, filterType);
    });
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
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'ngrok-skip-browser-warning': 'true',
        }
      );
      if (courseResponse.statusCode == 200) {
        final courseModelBase = CourseModel.fromJson(json.decode(courseResponse.body));
        courseModel.value = courseModelBase;
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

  bool isCourseEnrolled(String courseId) {
    if (user.value?.data?.enrollments == null) return false;
    for (var enrollment in user.value!.data!.enrollments!) {
      if (enrollment.courseId == courseId) {
        return true;
      }
    }
    return false;
  }

  void navigateToCourseDetail(String id) {
    Get.toNamed(CourseDetailScreen.routeName.replaceFirst(':id', id));
  }
}