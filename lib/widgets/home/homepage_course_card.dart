import 'package:flutter/material.dart';

class FeaturedCourses extends StatelessWidget {
  final List<Course> courses = [
    Course('Course Name 1', 'Course Detail 1', '6 Lessons', '4h 20m', '\$80.00', '\$100.00', 'assets/images/background/background.png', 'Recorded', '0.0'),
    Course('Course Name 2', 'Course Detail 2', '0 Lessons', '2h 40m', 'Free', '', 'assets/images/background/background.png', 'Recorded', '0.0'),
    Course('Course Name 3', 'Course Detail 3', '0 Lessons', '0m', '\$100.00', '\$160.00', 'assets/images/background/background.png', 'Recorded', '0.0'),
    Course('Course Name 4', 'Course Detail 4', '0 Lessons', '6h', '\$120.00', '', 'assets/images/background/background.png', 'Recorded', '0.0'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: courses.map((course) => HomepageCourseCard(course)).toList(),
          ),
        ),
      ]
    );
  }
}

class LastestCourses extends StatelessWidget {
  final List<Course> courses = [
    Course('Course Name 1', 'Course Detail 1', '6 Lessons', '4h 20m', '\$80.00', '\$100.00', 'assets/images/background/background.png', 'Recorded', '0.0'),
    Course('Course Name 2', 'Course Detail 2', '0 Lessons', '2h 40m', 'Free', '', 'assets/images/background/background.png', 'Recorded', '0.0'),
    Course('Course Name 3', 'Course Detail 3', '0 Lessons', '0m', '\$100.00', '\$160.00', 'assets/images/background/background.png', 'Recorded', '0.0'),
    Course('Course Name 4', 'Course Detail 4', '0 Lessons', '6h', '\$120.00', '', 'assets/images/background/background.png', 'Recorded', '0.0'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lastest Courses',
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: courses.map((course) => HomepageCourseCard(course)).toList(),
            ),
          ),
        ]
    );
  }
}

class BestRatedCourses extends StatelessWidget {
  final List<Course> courses = [
    Course('Course Name 1', 'Course Detail 1', '6 Lessons', '4h 20m', '\$80.00', '\$100.00', 'assets/images/background/background.png', 'Recorded', '0.0'),
    Course('Course Name 2', 'Course Detail 2', '0 Lessons', '2h 40m', 'Free', '', 'assets/images/background/background.png', 'Recorded', '0.0'),
    Course('Course Name 3', 'Course Detail 3', '0 Lessons', '0m', '\$100.00', '\$160.00', 'assets/images/background/background.png', 'Recorded', '0.0'),
    Course('Course Name 4', 'Course Detail 4', '0 Lessons', '6h', '\$120.00', '', 'assets/images/background/background.png', 'Recorded', '0.0'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Best Rated Courses',
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: courses.map((course) => HomepageCourseCard(course)).toList(),
            ),
          ),
        ]
    );
  }
}

class Course {
  final String name;
  final String detail;
  final String lessons;
  final String duration;
  final String price;
  final String oldPrice;
  final String imagePath;
  final String tag;
  final String rating;

  Course(this.name, this.detail, this.lessons, this.duration, this.price, this.oldPrice, this.imagePath, this.tag, this.rating);
}

class HomepageCourseCard extends StatelessWidget {
  final Course course;

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
                Image.asset(course.imagePath, fit: BoxFit.cover),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      course.tag,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              course.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(course.detail),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 20),
                SizedBox(width: 5),
                Text(course.rating),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(course.lessons),
                SizedBox(width: 20),
                Text(course.duration),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                if (course.oldPrice.isNotEmpty)
                  Text(
                    course.oldPrice,
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red,
                    ),
                  ),
                SizedBox(width: 10),
                Text(
                  course.price,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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