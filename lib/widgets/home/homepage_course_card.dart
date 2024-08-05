import 'package:beanmind_flutter/controllers/home/home_controller.dart';
import 'package:beanmind_flutter/models/course_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
              'Các khóa học nổi bật',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Handle "See All" button press
              },
              child: const Text('Xem tất cả'),
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                    ShimmerHomepageCourseCard(),
                  ],
                )
            ),
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
  final Item course;

  HomepageCourseCard(this.course, {super.key});

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
                Image.network(course.imageURL!,
                    fit: BoxFit.cover, height: 200,),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: const Text(
                      'Mới',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              course.title!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 120,
              child: Text(
                course.description!,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 20),
                SizedBox(width: 5),
                Text('5.0'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('${course.totalSlot} tiết học'),
                const SizedBox(width: 20),
                const Text('4h 20p'),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                controller.navigateToCourseDetail(course.id!);
              },
              child: const Text('Xem thêm'),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerHomepageCourseCard extends StatelessWidget {
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
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
