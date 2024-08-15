import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/screens/course/course_learning_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../configs/themes/custom_text_styles.dart';

class CourseDetailAction extends GetView<CourseDetailController> {
  const CourseDetailAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.courseDetailData.value == null || controller.user.value == null) {
        return Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 60,
                      height: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 60,
                      height: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 60,
                      height: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
      bool isEnrolled = controller.isCourseEnrolled(controller.courseId);
      final courseDetailData = controller.courseDetailData.value!;
      return Container(
        // width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: Border.all(color: Color(0xFF9A9A9A), width: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isEnrolled
                    ? () {
                  Get.toNamed(CourseLearningScreen.routeName.replaceFirst(':id', courseDetailData.id!));
                }
                    : null,
                icon: Icon(
                  isEnrolled ? Icons.play_arrow : Icons.lock,
                  color: Colors.white,
                ),
                label: Text(
                  isEnrolled ? 'Học ngay' : 'Chưa đăng ký',
                  style: kDetailsTS.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 1.3,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEnrolled ? const Color(0xFF3DCBB1) : Colors.grey[400],
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.book, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  '${courseDetailData.totalSlot} Tiết học',
                  style: kDetailsTS.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5,
                    color: const Color(0xE51B1B1B),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.person, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  '${courseDetailData.teachables?.length} giảng viên',
                  style: kDetailsTS.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5,
                    color: const Color(0xE51B1B1B),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.watch_later, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  '${courseDetailData.enrollments?.length} đã học',
                  style: kDetailsTS.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5,
                    color: const Color(0xE51B1B1B),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.category, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  'Toán',
                  style: kDetailsTS.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    height: 1.5,
                    color: const Color(0xE51B1B1B),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
