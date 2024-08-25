import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/home/home_controller.dart';
import 'package:beanmind_flutter/models/course_model.dart';
import 'package:beanmind_flutter/screens/course/course_learning_screen.dart';
import 'package:beanmind_flutter/utils/number_format.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EnrolledCourses extends GetView<HomeController> {
  const EnrolledCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Đã đăng ký',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle "See All" button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimayColorLT,
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              child: const Text('Xem tất cả', style: TextStyle(color: secondaryTextColorLT),),
            ),
          ],
        ),
      ),
      Obx(() {
        if (controller.courseModel.value == null) {
          // return Center(child: CircularProgressIndicator());
          return Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.4),
            highlightColor: Colors.blueGrey.withOpacity(0.1),
            child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                  ],
                )),
          );
        } else {
          final courses = controller.addCourseEnrolled();
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
              courses.map((course) => HomepageCourseCard(course)).toList(),
            ),
          );
        }
      }),
    ]);
  }
}

class FeaturedCourses extends GetView<HomeController> {
  const FeaturedCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Nổi bật',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle "See All" button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimayColorLT,
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              child: const Text('Xem tất cả', style: TextStyle(color: secondaryTextColorLT),),
            ),
          ],
        ),
      ),
      Obx(() {
        if (controller.hotCourseItemList.isEmpty) {
          // return Center(child: CircularProgressIndicator());
          return Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.4),
            highlightColor: Colors.blueGrey.withOpacity(0.1),
            child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                  ],
                )),
          );
        } else {
          final courses = controller.hotCourseItemList;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  courses.map((course) => HomepageCourseCard(course)).toList(),
            ),
          );
        }
      }),
    ]);
  }
}

class LastestCourses extends GetView<HomeController> {
  const LastestCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Mới nhất',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle "See All" button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimayColorLT,
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              child: const Text('Xem tất cả', style: TextStyle(color: secondaryTextColorLT),),
            ),
          ],
        ),
      ),
      Obx(() {
        if (controller.newestCourseItemList.isEmpty) {
          // return Center(child: CircularProgressIndicator());
          return Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.4),
            highlightColor: Colors.blueGrey.withOpacity(0.1),
            child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                  ],
                )),
          );
        } else {
          final courses = controller.newestCourseItemList;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  courses.map((course) => HomepageCourseCard(course)).toList(),
            ),
          );
        }
      }),
    ]);
  }
}

class BestRatedCourses extends GetView<HomeController> {
  const BestRatedCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Đánh giá cao',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle "See All" button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimayColorLT,
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              child: const Text('Xem tất cả', style: TextStyle(color: secondaryTextColorLT),),
            ),
          ],
        ),
      ),
      Obx(() {
        if (controller.courseModel.value == null) {
          // return Center(child: CircularProgressIndicator());
          return Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.4),
            highlightColor: Colors.blueGrey.withOpacity(0.1),
            child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                  ],
                )),
          );
        } else {
          final courses = controller.courseModel.value!.data?.items ?? [];
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  courses.map((course) => HomepageCourseCard(course)).toList(),
            ),
          );
        }
      }),
    ]);
  }
}

class HomepageCourseCard extends GetView<HomeController> {
  final CourseModelItem course;

  const HomepageCourseCard(this.course, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isEnrolled = controller.isCourseEnrolled(course.id!);
      var courseLevel = controller.courseLevelItemList
          .where((a) => a.id == course.courseLevelId)
          .firstOrNull;
      var programType = controller.programTypeItemList
          .where((a) => a.id == course.programTypeId)
          .firstOrNull;
      var subject = controller.subjectItemList
          .where((a) => a.id == course.subjectId)
          .firstOrNull;

      return Card(
        margin: const EdgeInsets.all(10),
        child: Container(
          width: 285,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  controller.navigateToCourseDetail(course.id!);
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/background/background.png',
                        image: course.imageUrl!,
                        fit: BoxFit.fill,
                        height: 200,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/background/background.png',
                            fit: BoxFit.fill,
                            height: 200,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          subject?.title ?? 'Unknown Subject',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => controller.navigateToCourseDetail(course.id!),
                child: SizedBox(
                  height: 80,
                  child: Text(
                    course.title!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: Text(
                  '${programType?.title ?? 'Unknown Program'} - ${courseLevel?.title ?? 'Unknown Level'}',
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: Text(
                  '${course.numberOfEnrollment ?? 'Unknown Program'} người đăng ký',
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: Text(
                  course.description!,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
              Row(children: [
                Text(formatPrice(course.price!)),
                const Spacer(),
                isEnrolled
                    ? ElevatedButton.icon(
                        onPressed: () {
                          Get.toNamed(CourseLearningScreen.routeName
                              .replaceFirst(':id', course.id!));
                        },
                        icon: const Icon(Icons.play_arrow,
                            color: Colors.white),
                        label: const Text('Học Ngay'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Colors.white,
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12),
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold),
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: null, // Nút bị disable
                        icon: const Icon(Icons.lock,
                            color: Colors.grey),
                        label: const Text('Chưa đăng ký'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.grey[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12),
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold),
                        ),
                      ),
              ])
            ],
          ),
        ),
      );
    });
  }
}

class ShimmerHomepageCourseCard extends StatelessWidget {
  const ShimmerHomepageCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        width: 285,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.grey,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: const Text(
                        'Mới',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 200,
                height: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 80,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 50,
                    height: 20,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 5),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 30,
                    height: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80,
                    height: 20,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 20),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 50,
                    height: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 100,
                height: 30,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
