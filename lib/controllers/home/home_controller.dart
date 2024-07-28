import 'dart:convert';

import 'package:beanmind_flutter/models/course_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var courseModel = Rxn<CourseModel>();

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
  }

  Future<void> fetchCourses() async {
    try {
      final courseResponse = await http.get(
        Uri.parse('${newBaseApiUrl}/courses'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'ngrok-skip-browser-warning': 'true',
        }
      );
      if (courseResponse.statusCode == 200) {
        final courseModelBase = CourseModel.fromJson(json.decode(courseResponse.body));
        courseModel.value = courseModelBase;
        print(courseModel.value.toString());
      } else {
        throw Exception('Failed to fetch course');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}