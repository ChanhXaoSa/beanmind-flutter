import 'package:beanmind_flutter/controllers/home/home_controller.dart';
import 'package:beanmind_flutter/widgets/common/custom_home_app_bar.dart';
import 'package:beanmind_flutter/widgets/home/custom_banner.dart';
import 'package:beanmind_flutter/widgets/home/homepage_course_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHomeAppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  const CustomBanner(),
                  const FeaturedCourses(),
                  const LastestCourses(),
                  const BestRatedCourses(),
                  Container(
                    height: 1000, // Example of more content
                    color: Colors.yellow[100],
                    child: const Center(child: Text('More content here')),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
