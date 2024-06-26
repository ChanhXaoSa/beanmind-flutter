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
  final String courseDescription = 'Mô tả chi tiết về khoá học';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  courseImageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              // Description and Instructor Info Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description Column
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Course Title
                          Text(
                            courseTitle,
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Mô tả khoá học',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            courseDescription,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Instructor Info Column
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 600,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              const Icon(Icons.star,
                                  color: Colors.orange, size: 20),
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

                          Row(
                            children: [
                              const Icon(Icons.account_circle,
                                  color: Colors.orange, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                'số lượng người đã đăng kí $numRatings',
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
                              const Icon(Icons.access_time,
                                  color: Colors.grey, size: 20),
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

                          // đẩy nút xuống dưới
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(                             
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle course enrollment or start action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,   
                                      color: Colors.white,                             
                                    ),
                                    minimumSize: const Size(double.infinity, 60),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Đăng ký khoá học'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Handle course enrollment or start action
              //     },
              //     child: const Text('Đăng ký khoá học'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
