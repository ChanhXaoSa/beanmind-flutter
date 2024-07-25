import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CourseListScreen(),
    );
  }
}

class CourseListScreen extends StatelessWidget {
  final List<Course> courses = [
    Course(name: "Course 1", registrationDate: "2023-07-01", isCompleted: true),
    Course(
        name: "Course 2", registrationDate: "2023-07-05", isCompleted: false),
    Course(name: "Course 3", registrationDate: "2023-07-10", isCompleted: true),
    Course(
        name: "Course 4", registrationDate: "2023-07-15", isCompleted: false),
    Course(name: "Course 5", registrationDate: "2023-07-20", isCompleted: true),
    Course(
        name: "Course 6", registrationDate: "2023-07-25", isCompleted: false),
    Course(name: "Course 7", registrationDate: "2023-07-30", isCompleted: true),
    Course(
        name: "Course 8", registrationDate: "2023-08-01", isCompleted: false),
    Course(name: "Course 1", registrationDate: "2023-07-01", isCompleted: true),
    Course(
        name: "Course 2", registrationDate: "2023-07-05", isCompleted: false),
    Course(name: "Course 3", registrationDate: "2023-07-10", isCompleted: true),
    Course(
        name: "Course 4", registrationDate: "2023-07-15", isCompleted: false),
    Course(name: "Course 5", registrationDate: "2023-07-20", isCompleted: true),
    Course(
        name: "Course 6", registrationDate: "2023-07-25", isCompleted: false),
    Course(name: "Course 7", registrationDate: "2023-07-30", isCompleted: true),
    Course(
        name: "Course 8", registrationDate: "2023-08-01", isCompleted: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - 32) /
                4; // Adjust the total padding and spacing
            final itemHeight =
                constraints.maxHeight / 4; // Adjust the height as needed

            return GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 items per row
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: itemWidth / itemHeight,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return CourseItem(
                    course: courses[index],
                    width: itemWidth,
                    height: itemHeight);
              },
            );
          },
        ),
      ),
    );
  }
}

class Course {
  final String name;
  final String registrationDate;
  final bool isCompleted;

  Course(
      {required this.name,
      required this.registrationDate,
      required this.isCompleted});
}

class CourseItem extends StatelessWidget {
  final Course course;
  final double width;
  final double height;

  const CourseItem(
      {required this.course, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the top left
        children: <Widget>[
          Image.network(
            "https://th.bing.com/th/id/OIP.hdTZOd3f6FNd6N2ocUVH_AAAAA?rs=1&pid=ImgDetMain",
            width: double.infinity,
            height: height * 0.4, // Adjust image height relative to item height
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Text(
            course.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Đăng kí: ${course.registrationDate}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            course.isCompleted ? "Hoàn thành" : "Chưa hoàn thành",
            style: TextStyle(
              fontSize: 14,
              color: course.isCompleted ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
