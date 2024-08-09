import 'package:beanmind_flutter/controllers/home/home_controller.dart';
import 'package:beanmind_flutter/models/course_model.dart';
import 'package:beanmind_flutter/utils/number_format.dart';
import 'package:beanmind_flutter/widgets/common/custom_home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseListScreen extends GetView<HomeController> {
  const CourseListScreen({Key? key}) : super(key: key);

  static const String routeName = '/course_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeAppBar(),
      body: Row(
        children: [
          // Phần Filter bên trái
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lọc khóa học',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Thêm các bộ lọc tùy chỉnh tại đây
                  FilterOption('Lọc theo giá'),
                  FilterOption('Lọc theo đánh giá'),
                  FilterOption('Lọc theo thời gian'),
                  // Thêm các bộ lọc khác nếu cần
                ],
              ),
            ),
          ),
          // Phần Grid hiển thị các khóa học
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                final courses = controller.courseModel.value?.data?.items ?? [];

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return CourseGridCard(course: courses[index]);
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}


class CourseGridCard extends StatelessWidget {
  final CourseModelItem course;

  const CourseGridCard({required this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to course detail
      },
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image của khóa học
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/background/background.png',
                image: course.imageUrl!,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/background/background.png',
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            // Tên khóa học
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                course.title!,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            // Giá khóa học
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                formatPrice(course.price!),
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
            ),
            const Spacer(),
            // Nút hành động
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to course detail
                },
                child: const Text('Xem chi tiết'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget hiển thị từng tùy chọn lọc
class FilterOption extends StatelessWidget {
  final String title;

  const FilterOption(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Checkbox(
        value: false,
        onChanged: (value) {
          // Handle filter option change
        },
      ),
    );
  }
}
