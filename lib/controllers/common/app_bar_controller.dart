import 'dart:convert';

import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/controllers/game/game_controller.dart';
import 'package:beanmind_flutter/models/course_model.dart';
import 'package:beanmind_flutter/models/user_model.dart';
import 'package:beanmind_flutter/screens/course/course_list_screen.dart';
import 'package:beanmind_flutter/screens/screens.dart';
import 'package:beanmind_flutter/utils/api_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppBarController extends GetxController {
  var isLoggedIn = false.obs;
  var user = Rx<UserModel?>(null);
  var courseItemList = <CourseModelItem>[].obs;
  var searchQuery = ''.obs;
  var filteredCourses = <CourseModelItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    fetchCourses();
  }

  Future<void> checkLoginStatus() async {
    UserModel? sessionUser = await Get.find<AuthController>().getUserLocal();
    if (sessionUser != null) {
      user.value = sessionUser;
      isLoggedIn.value = true;
    }
  }

  void searchCourses(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredCourses.clear();
      return;
    }

    filteredCourses.value = courseItemList
        .where((course) => course.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> fetchCourses() async {
    try {
      final courseResponse = await http.get(
        Uri.parse('$newBaseApiUrl/courses?PageSize=9999'),
        headers: getHeaders(''),
      );
      if (courseResponse.statusCode == 200) {
        final courseModelBase = CourseModel.fromJson(json.decode(courseResponse.body));
        courseItemList.addAll(courseModelBase.data!.items!);
        if (kDebugMode) {
          // print(courseItemList.value.toString());
        }
      } else {
        throw Exception('Failed to fetch course app bar');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      rethrow;
    }
  }

  void navigateToGameList() {
    Get.find<GameController>().navigateToGameList();
  }

  void navigateToHome() {
    Get.find<AuthController>().navigateToHome();
  }

  void navigateToCourseList() {
    Get.toNamed(CourseListScreen.routeName);
  }

  void navigateToCourseDetail(String id) {
    Get.toNamed(CourseDetailScreen.routeName.replaceFirst(':id', id));
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {
    Get.find<AuthController>().navigateToLogin();
  }
}

class SearchOverlay {
  static final SearchOverlay _singleton = SearchOverlay._internal();
  factory SearchOverlay() => _singleton;
  SearchOverlay._internal();

  OverlayEntry? _overlayEntry;

  void showSearch(BuildContext context, Widget searchResults) {
    if (_overlayEntry != null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy + size.height,
        left: position.dx,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200.0,
            ),
            child: searchResults,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void removeSearch() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
