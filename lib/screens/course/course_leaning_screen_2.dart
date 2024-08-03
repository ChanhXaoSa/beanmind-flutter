import 'package:beanmind_flutter/controllers/course_learning/course_learning_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CourseLeaningScreen2 extends GetView<CourseLearningController> {
  const CourseLeaningScreen2({Key? key}) : super(key: key);

  static const String routeName = '/course_learning2/course_id=:id';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Learning Screen'),
      ),
      body: Row(
        children: [
          // Left Section: Chapters and Topics
          Container(
            width: 300,
            color: Colors.grey[200],
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() {
                    return ExpansionPanelList(
                      expandedHeaderPadding: EdgeInsets.all(0),
                      expansionCallback: (int index, bool isExpanded) {
                        controller.togglePanel(index);
                      },
                      children: controller.sections.map<ExpansionPanel>((Section section) {
                        return ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(section.title),
                            );
                          },
                          body: Column(
                            children: section.topics.map<ListTile>((String topic) {
                              return ListTile(
                                title: Text(topic),
                                onTap: () => controller.selectContent('$topic Content'),
                              );
                            }).toList(),
                          ),
                          isExpanded: section.isExpanded,
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
          ),
          // Right Section: Course Content
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Obx(() {
                return SingleChildScrollView(
                  child: Text(controller.selectedContent.value),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
  
}