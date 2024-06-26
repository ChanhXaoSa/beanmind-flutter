import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatefulWidget {
  // final String courseTitle;
  // final String instructor;
  // final String courseDescription;
  // final String courseImageUrl;
  // final double rating;
  // final int numRatings;
  // final String duration;

  const CourseDetailsScreen({
    super.key,
    // required this.courseTitle,
    // required this.instructor,
    // required this.courseDescription,
    // required this.courseImageUrl,
    // required this.rating,
    // required this.numRatings,
    // required this.duration,
  });

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  // Mock data
  final String courseTitle = 'Tên khoá học';
  final String instructor = 'Người tạo khoá học';
  final String courseImageUrl = 'assets/images/background/background_store.png';
  final double rating = 4.5;
  final int numRatings = 100;
  final String duration = 'Thời lượng khoá học';
  final String courseDescription =
      'Mô tả chi tiết về khoá học';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  courseImageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Course Title
              Text(
                courseTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Instructor Name
              Text(
                'Người tạo khoá học: $instructor',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),

              // Rating and Number of Ratings
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '$rating ($numRatings đánh giá)',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Duration
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Course Description
              Text(
                courseDescription,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),

              // Start/Enroll Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle course enrollment or start action
                  },
                  child: const Text('Đăng ký khoá học'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
