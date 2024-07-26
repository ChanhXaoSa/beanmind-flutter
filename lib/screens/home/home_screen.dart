import 'package:beanmind_flutter/controllers/home/home_controller.dart';
import 'package:beanmind_flutter/widgets/common/custom_home_app_bar.dart';
import 'package:beanmind_flutter/widgets/course/course_card.dart';
import 'package:beanmind_flutter/widgets/home/custom_banner.dart';
import 'package:beanmind_flutter/widgets/home/document_paper_card.dart';
import 'package:beanmind_flutter/widgets/home/homepage_course_card.dart';
import 'package:beanmind_flutter/widgets/home/video_learning_paper_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

import 'custom_drawer.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeAppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  CustomBanner(),
                  FeaturedCourses(),
                  LastestCourses(),
                  BestRatedCourses(),
                  Container(
                    height: 1000, // Example of more content
                    color: Colors.blue[100],
                    child: Center(child: Text('More content here')),
                  ),
                  Container(
                    height: 1000, // Example of more content
                    color: Colors.red[100],
                    child: Center(child: Text('More content here')),
                  ),
                  Container(
                    height: 1000, // Example of more content
                    color: Colors.yellow[100],
                    child: Center(child: Text('More content here')),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
