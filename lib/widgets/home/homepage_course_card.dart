import 'package:beanmind_flutter/controllers/home/home_controller.dart';
import 'package:beanmind_flutter/models/course_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FeaturedCourses extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Courses',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // Handle "See All" button press
              },
              child: Text('See All'),
            ),
          ],
        ),
      ),
      Obx(() {
        if (controller.courseModel.value == null) {
          return Center(child: CircularProgressIndicator());
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
      })
    ]);
  }
}

class HomepageCourseCard extends StatelessWidget {
  final Item course;

  HomepageCourseCard(this.course);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        width: 285,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset('assets/images/background/background.png',
                    fit: BoxFit.cover),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'New',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              course.title!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 120,
              child: Text(
                course.description!,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 20),
                SizedBox(width: 5),
                Text('5.0'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('${course.totalSlot} tiết học'),
                SizedBox(width: 20),
                Text('4h 20p'),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('Enroll'),
            ),
          ],
        ),
      ),
    );
  }
}
