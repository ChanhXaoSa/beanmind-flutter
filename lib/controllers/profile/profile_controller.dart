import 'dart:convert';

import 'package:beanmind_flutter/models/enrollment_model.dart';
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
  List<dynamic> gameHistories = [];

  void navigateToCourseDetail(String id) {
    Get.toNamed(CourseDetailScreen.routeName.replaceFirst(':id', id));
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }
}
