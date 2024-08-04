import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/screens/course/course_leaning_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/custom_text_styles.dart';

class CourseDetailAction extends GetView<CourseDetailController> {
  const CourseDetailAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if(controller.courseDetailData.value == null) {
        return const Center(child: CircularProgressIndicator(),);
      }
      final courseDetailData = controller.courseDetailData.value!;
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 6),
              blurRadius: 10,
            ),
          ],
        ),
        constraints: const BoxConstraints(
          minHeight: 450,
          minWidth: 400,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 46),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(CourseLeaningScreen2.routeName.replaceFirst(':id', courseDetailData.id!));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3DCBB1),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Học ngay',
                      style: kDetailsTS.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        height: 1.3,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                const EdgeInsets.fromLTRB(3, 0, 3, 14),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(
                            0, 3, 19, 3),
                        width: 24,
                        height: 24,
                        child: const SizedBox(
                          width: 18,
                          height: 18,
                          child: Icon(Icons.book, color: Colors.black,),
                        ),
                      ),
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
                ),
              ),
              Container(
                margin:
                const EdgeInsets.fromLTRB(1, 0, 1, 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(
                            0, 3.5, 17, 3.5),
                        width: 24,
                        height: 24,
                        child: const SizedBox(
                          width: 22,
                          height: 17,
                          child: Icon(Icons.person, color: Colors.black,),
                        ),
                      ),
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
                ),
              ),
              Container(
                margin:
                const EdgeInsets.fromLTRB(1, 0, 1, 13),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(
                            0, 1.1, 17, 3.1),
                        width: 24,
                        height: 24,
                        child: const SizedBox(
                          width: 22,
                          height: 19.8,
                          child: Icon(Icons.watch_later, color: Colors.black,),
                        ),
                      ),
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
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(
                            0, 3.5, 19, 3.5),
                        width: 24,
                        height: 24,
                        child: const SizedBox(
                          width: 18,
                          height: 16.9,
                          child: Icon(Icons.category, color: Colors.black,),
                        ),
                      ),
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
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}