import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beanmind_flutter/configs/themes/app_colors.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Screen1 extends GetView<ProfileController> {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    // first 4 boxes in grid
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      width: double.infinity,
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[400],
                            gradient: mainGradient(context),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() {
                                return AutoSizeText(
                                  'Chào mừng bạn quay lại, ${controller.user.value?.data?.firstName ?? 'null'} ${controller.user.value?.data?.lastName ?? 'null'}',
                                  maxFontSize: 45,
                                  minFontSize: 30,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                              Obx(() {
                                final completedCourses = controller.enrollmentModel.value?.data?.items
                                    ?.where((item) => item.status == 2)
                                    .length ?? 0;
                                if(completedCourses == 0) {
                                  return const AutoSizeText(
                                    'Bạn hiện tại chưa hoàn thành khoá học nào, bạn muốn khám phá những khóa học khác không?',
                                    maxFontSize: 24,
                                    minFontSize: 16,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                }
                                return AutoSizeText(
                                  'Bạn đã hoàn thành $completedCourses khóa học, bạn muốn khám phá những khóa học khác không?',
                                  maxFontSize: 24,
                                  minFontSize: 16,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              Colors.green),
                                    ),
                                    child: const Text('Khám phá ngay',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25)),
                                  ),
                                  // const SizedBox(width: 20),
                                  // ElevatedButton(
                                  //   onPressed: () {},
                                  //   style: ButtonStyle(
                                  //     backgroundColor:
                                  //         WidgetStateProperty.all(
                                  //             Colors.blue),
                                  //   ),
                                  //   child: const Text('Xem lại khóa học',
                                  //       style: TextStyle(
                                  //           color: Colors.white, fontSize: 25)),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // text
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: const AutoSizeText('Tiến độ các khóa học bạn chưa hoàn thành',
                          maxFontSize: 24,
                          minFontSize: 24,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Obx(() {
                        if (controller.enrollmentModel.value?.data?.items == null || controller.enrollmentModel.value!.data!.items!.isEmpty) {
                          return const Center(
                              child: ShimmerCourseProgressItem1());
                        }
                        return ScrollConfiguration(
                          behavior: MyCustomScrollBehavior(),
                          child: Scrollbar(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: controller.enrollmentModel.value!.data!
                                  .items!.length,
                              itemBuilder: (context, index) {
                                final enrollmentItem = controller
                                    .enrollmentModel.value!.data!.items![index];
                                final course = enrollmentItem.course!;
                                return InkWell(
                                  onTap: () {
                                    controller.navigateToCourseLearning(course.id!);
                                  },
                                  child: buildProgressItem(
                                      context,
                                      course.title ?? '',
                                      course.totalSlot != null && course.totalSlot! > 0
                                          ? controller.participantModelItemList
                                          .where((a) => a.enrollment!.courseId == course.id)
                                          .length / course.totalSlot!
                                          : 0.0,
                                      '${controller.participantModelItemList
                                          .where((a) => a.enrollment!.courseId == course.id)
                                          .length}/${course
                                          .totalSlot ?? 0}',
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                      ),
                    ),
                    // text
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: const AutoSizeText('Khóa học bạn đã đăng kí gần đây',
                          maxFontSize: 24,
                          minFontSize: 24,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    // list of previous days
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Obx(() {
                        if (controller.enrollmentModel.value?.data?.items == null || controller.enrollmentModel.value!.data!.items!.isEmpty) {
                          return const Center(
                              child: ShimmerCourseProgressItem2());
                        }
                        return ScrollConfiguration(
                          behavior: MyCustomScrollBehavior(),
                          child: Scrollbar(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.enrollmentModel.value!.data!.items!.length,
                              itemBuilder: (context, index) {
                                final enrollmentItem = controller.enrollmentModel.value!.data!.items![index];
                                final course = enrollmentItem.course!;
                                // Giả sử `course` có thuộc tính `title`, `registrationDate`, và `imageUrl`.
                                return InkWell(
                                  onTap: () {
                                    controller.navigateToCourseLearning(course.id!);
                                  },
                                  child: buildCourseItem(
                                      context,
                                      course.title ?? '',
                                      course.imageUrl ?? '',
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override the drag devices to include a mouse.
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

Widget buildCourseItem(
    BuildContext context, String title, String imageUrl) {
  return Container(
    width: 200,
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/background/background.png',
            image:  imageUrl,
              height: MediaQuery.of(context).size.height * 0.09,
              width: double.infinity,
              fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/background/background.png',
                height: MediaQuery.of(context).size.height * 0.09,
                fit: BoxFit.fill,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // const SizedBox(height: 5),
              // Text(
              //   subtitle,
              //   style: TextStyle(
              //       fontSize: 14,
              //       overflow: TextOverflow.ellipsis,
              //       color: Colors.grey[600]),
              // ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildProgressItem(BuildContext context, String title, double progress,
    String slots) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,  
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(progress >= 1 ? Colors.green : Colors.blue),
        ),
        const SizedBox(height: 5),
        Text(
          'Đã học: $slots slot',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        // Text(
        //   'Thời gian đã học: $time',
        //   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        // ),
      ],
    ),
  );
}

class ShimmerCourseProgressItem1 extends StatelessWidget {
  const ShimmerCourseProgressItem1({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerCourseProgressItem2 extends StatelessWidget {
  const ShimmerCourseProgressItem2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: double.infinity,
                height: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
