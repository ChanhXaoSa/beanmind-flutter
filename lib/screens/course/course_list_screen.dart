import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/home/home_controller.dart';
import 'package:beanmind_flutter/widgets/common/custom_home_app_bar.dart';
import 'package:beanmind_flutter/widgets/home/homepage_course_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseListScreen extends GetView<HomeController> {
  const CourseListScreen({super.key});

  static const String routeName = '/course_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHomeAppBar(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            children: [
              // Phần Filter bên trái
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                color: Colors.grey[200],
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lọc khóa học',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
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
                    final courses =
                        controller.courseModel.value?.data?.items ?? [];
                    if (UIParameters.isDesktop(context)) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return HomepageCourseCard(courses[index]);
                        },
                      );
                    } else if (UIParameters.isTablet(context)) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return HomepageCourseCard(courses[index]);
                        },
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return HomepageCourseCard(courses[index]);
                        },
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterOption extends StatelessWidget {
  final String title;

  const FilterOption(this.title, {super.key});

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
