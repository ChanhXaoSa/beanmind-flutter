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
          child: Column(
            children: [
              // Thanh điều hướng trên
              FilterBar(),
              // Phần nội dung chính
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Phần Filter bên trái
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      color: Colors.grey[200],
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                'Lọc khóa học',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              // Thêm các bộ lọc tùy chỉnh tại đây
                              FilterExpansionTile(
                                title: 'Categories',
                                options: [
                                  'Software Development',
                                  'Website Development',
                                  'Mobile Development',
                                  'Desktop Development',
                                  'Game Development',
                                ],
                              ),
                              FilterExpansionTile(
                                title: 'Instructor',
                                options: ['Instructor'],
                              ),
                              FilterExpansionTile(
                                title: 'Language',
                                options: ['English'],
                              ),
                              FilterExpansionTile(
                                title: 'Level',
                                options: [
                                  'Beginner',
                                  'Intermediate',
                                  'Advanced'
                                ],
                              ),
                              // Thêm các bộ lọc khác nếu cần
                            ],
                          ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Showing 1 of total 1 Courses"),
          Spacer(),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Các tag filter được chọn
              Wrap(
                spacing: 8.0,
                children: [
                  FilterTag(
                    label: "Instructor",
                    onRemove: () {
                      // Xử lý khi nhấn X để bỏ filter
                    },
                  ),
                  FilterTag(
                    label: "Website Development",
                    onRemove: () {
                      // Xử lý khi nhấn X để bỏ filter
                    },
                  ),
                ],
              ),
              // Các nút sắp xếp
              // Row(
              //   children: [
              //     SortButton(label: "Best Rated"),
              //     SortButton(label: "Most Popular"),
              //     SortButton(label: "Latest"),
              //     SortButton(label: "Highest Price"),
              //     SortButton(label: "Lowest Price"),
              //     IconButton(
              //       icon: Icon(Icons.grid_view, color: Colors.blue),
              //       onPressed: () {
              //         // Chuyển sang chế độ hiển thị dạng grid
              //       },
              //     ),
              //     IconButton(
              //       icon: Icon(Icons.list, color: Colors.grey),
              //       onPressed: () {
              //         // Chuyển sang chế độ hiển thị dạng list
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

// Định nghĩa FilterTag như trong mã trước
class FilterTag extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const FilterTag({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      deleteIcon: Icon(Icons.close),
      onDeleted: onRemove,
    );
  }
}

// Định nghĩa SortButton như trong mã trước
class SortButton extends StatelessWidget {
  final String label;

  const SortButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Xử lý khi nhấn vào nút sắp xếp
      },
      child: Text(label),
    );
  }
}

class FilterExpansionTile extends StatefulWidget {
  final String title;
  final List<String> options;

  const FilterExpansionTile({
    required this.title,
    required this.options,
    super.key,
  });

  @override
  _FilterExpansionTileState createState() => _FilterExpansionTileState();
}

class _FilterExpansionTileState extends State<FilterExpansionTile> {
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title),
      children: widget.options.map((option) {
        return CheckboxListTile(
          title: Text(option),
          value: selectedOptions.contains(option),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                // Thêm tùy chọn vào danh sách nếu được chọn
                selectedOptions.add(option);
              } else {
                // Loại bỏ tùy chọn khỏi danh sách nếu bỏ chọn
                selectedOptions.remove(option);
              }
            });
            // Handle option change (ví dụ, cập nhật danh sách filter bên ngoài)
          },
        );
      }).toList(),
    );
  }
}

