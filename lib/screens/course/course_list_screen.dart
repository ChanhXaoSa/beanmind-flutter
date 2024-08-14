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
              FilterBar(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      color: Colors.grey[200],
                      child: Padding(
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
                              Obx(() => FilterExpansionTile(
                                title: 'Lớp',
                                options: controller.courseLevelItemList
                                    .map((item) => item.title ?? '')
                                    .toList(),
                                ids: controller.courseLevelItemList
                                    .map((item) => item.id ?? '00000000-0000-0000-0000-000000000000')
                                    .toList(),
                              )),
                              Obx(() => FilterExpansionTile(
                                title: 'Chương trình học',
                                options: controller.programTypeItemList
                                    .map((item) => item.title ?? '')
                                    .toList(),
                                ids: controller.programTypeItemList
                                    .map((item) => item.id ?? '')
                                    .toList(),
                              )),
                              Obx(() => FilterExpansionTile(
                                title: 'Môn học',
                                options: controller.subjectItemList
                                    .map((item) => item.title ?? '')
                                    .toList(),
                                ids: controller.subjectItemList
                                    .map((item) => item.id ?? '')
                                    .toList(),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
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

class FilterBar extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Text("Hiển thị ${controller.courseItemList.length} trên tổng số ${controller.courseItemList.length} khoá học");
          }),
          Spacer(),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return Wrap(
                  spacing: 8.0,
                  children: controller.selectedFilterTags.entries.map((entry) {
                    return FilterTag(
                      title: entry.key,
                      label: entry.value,
                      onRemove: () {
                        Get.find<HomeController>().removeFilterId(entry.key);
                      },
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}


class FilterTag extends StatelessWidget {
  final String label;
  final String title;
  final VoidCallback onRemove;

  const FilterTag({required this.label, required this.title, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      deleteIcon: Icon(Icons.close),
      onDeleted: () {
        final controller = Get.find<HomeController>();
        controller.removeFilterId(title);
        onRemove();
      },
    );
  }
}


class FilterExpansionTile extends StatefulWidget {
  final String title;
  final List<String> options;
  final List<String> ids;

  const FilterExpansionTile({
    required this.title,
    required this.options,
    required this.ids,
    super.key,
  });

  @override
  _FilterExpansionTileState createState() => _FilterExpansionTileState();
}

class _FilterExpansionTileState extends State<FilterExpansionTile> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return ExpansionTile(
      title: Text(widget.title),
      children: widget.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        final id = widget.ids[index];

        return Obx(() {
          String? selectedOptionId = controller.getFilterId(widget.title);
          return RadioListTile<String>(
            title: Text(option),
            value: id,
            groupValue: selectedOptionId,
            onChanged: (String? value) {
              if (value != null) {
                controller.addFilterId(widget.title, value, option);
                controller.applyFilters(); // Gọi API mỗi khi lựa chọn thay đổi
              }
            },
          );
        });
      }).toList(),
    );
  }
}






