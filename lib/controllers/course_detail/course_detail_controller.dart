import 'dart:convert';

import 'package:beanmind_flutter/models/course_detail_model.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CourseDetailController extends GetxController {
  var courseDetailModel = Rxn<CourseDetailModel>();
  late String courseId;

  @override
  void onInit() {
    courseId = Get.parameters['id']!;
    fetchCourseDetail();
    super.onInit();
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
        print(courseDetailModel.value.toString());
      } else {
        throw Exception('Failed to fetch course');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}