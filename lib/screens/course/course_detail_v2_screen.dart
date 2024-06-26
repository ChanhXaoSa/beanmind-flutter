import 'package:flutter/material.dart';

class CourseDetailV2Screen extends StatefulWidget {
  //const CourseDetailV2Screen({super.key});

  CourseDetailV2Screen({
    super.key,
  });

  @override
  State<CourseDetailV2Screen> createState() => _CourseDetailV2ScreenState();
}

class _CourseDetailV2ScreenState extends State<CourseDetailV2Screen> {
  // Mock data
  final String courseTitle = 'Tên khoá học';
  final String instructor = 'Người tạo khoá học';
  final String courseImageUrl =
      'assets/images/background/course_background.png';
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
          padding: const EdgeInsets.all(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image Section
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), // Adjust opacity as needed
                        BlendMode.darken,
                      ),
                      child: Image.asset(
                        courseImageUrl,
                        height: 400,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(140), child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("TÊN KHOÁ HỌC", style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold)),
                          Text("Mô tả khoá học", style: TextStyle(fontSize: 30, color: Colors.white)),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Đăng ký ngay', style: TextStyle(fontSize: 20)),
                              ),
                              SizedBox(width: 20),  
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Xem thử', style: TextStyle(fontSize: 20)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),          
                ],
              ),
              SizedBox(height: 30),
              Container(
                // width 60% of screen to make it smaller
                width: MediaQuery.of(context).size.width * 0.75,
                alignment: Alignment.center,
                //border line
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // Display columns evenly
                  children: List.generate(
                      5,
                      (index) => Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                'Course Title $index', // Assuming different course titles for demo
                                style: const TextStyle(
                                  fontSize:
                                      20, // Adjusted font size to fit in the smaller container
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Instructor $index', // Assuming different instructors for demo
                                style: const TextStyle(
                                  fontSize:
                                      14, // Adjusted font size to fit in the smaller container
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          )                    
                          ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 140, right: 140),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
