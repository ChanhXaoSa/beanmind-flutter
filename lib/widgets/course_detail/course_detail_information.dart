import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../configs/themes/custom_text_styles.dart';

class CourseDetailInformation extends GetView<CourseDetailController> {
  const CourseDetailInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.courseDetailModel.value == null) {
        return Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 24,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 16,
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
                      width: 40,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 40,
                      height: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      }
      final courseDetail = controller.courseDetailModel.value!;
      return Container(
        // width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${courseDetail.data?.title}',
              style: kDetailsTS.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                height: 1.3,
                color: const Color(0xFF000000),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '${courseDetail.data?.subject?.title}',
              style: kDetailsTS.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 1.3,
                color: const Color(0xFF000000),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.account_circle, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  '2.3k',
                  style: kDetailsTS.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.3,
                    color: const Color(0x991B1B1B),
                  ),
                ),
                SizedBox(width: 16),
                Icon(Icons.error, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  '1.4k',
                  style: kDetailsTS.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.3,
                    color: const Color(0x991B1B1B),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Chi tiết khóa học',
              style: kDetailsTS.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 1.3,
                color: const Color(0xFF000000),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '${courseDetail.data?.description}',
              style: kDetailsTS.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.5,
                color: const Color(0x991B1B1B),
              ),
            ),
          ],
        ),
      );
    });
  }
}
