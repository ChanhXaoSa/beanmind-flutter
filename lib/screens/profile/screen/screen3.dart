import 'package:auto_size_text/auto_size_text.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/models/enrollment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const CourseListScreen(),
    );
  }
}

class CourseListScreen extends GetView<ProfileController> {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: AutoSizeText(
                    "DANH SÁCH KHOÁ HỌC",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Search bar
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm khóa học",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                if (controller.enrollmentModel.value?.data?.items == null ||
                    controller.enrollmentModel.value!.data!.items!.isEmpty) {
                  return const Center(child: Text("Không có khóa học nào."));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: controller.enrollmentModel.value!.data!.items!.length,
                  itemBuilder: (context, index) {
                    final enrollmentItem = controller.enrollmentModel.value!.data!.items![index];
                    final course = enrollmentItem;
                    return InkWell(
                      onTap: () {
                        controller.navigateToCourseDetail(course.course!.id!);
                      },
                      child: CourseItem(
                        course: course,
                        width: 200,
                        height: 200,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseItem extends StatelessWidget {
  final EnrollmentModelItem course;
  final double width;
  final double height;

  const CourseItem({super.key, required this.course, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    bool isCompleted = course.status == 2;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            course.course!.imageUrl ?? "https://th.bing.com/th/id/OIP.hdTZOd3f6FNd6N2ocUVH_AAAAA?rs=1&pid=ImgDetMain",
            width: double.infinity,
            height: height * 0.4,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Text(
            course.course!.title ?? "Không có tên",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Đăng kí: ${'N/A'}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            isCompleted ? "Hoàn thành" : "Chưa hoàn thành",
            style: TextStyle(
              fontSize: 14,
              color: isCompleted ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
