import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/themes/app_colors.dart';
import 'package:beanmind_flutter/screens/home/home_screen.dart';
import 'package:beanmind_flutter/widgets/common/circle_button.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);
  static const String routeName = '/introduction';
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(
    //     alignment: Alignment.center,
    //     decoration: BoxDecoration(gradient: mainGradient(context)),
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
    //       child: EasySeparatedColumn(
    //         separatorBuilder: (context, index) => const SizedBox(
    //           height: 40,
    //         ),
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Icon(
    //             Icons.warning_amber_sharp,
    //             size: 65,
    //             color: kOnSurfaceTextColor,
    //           ),
    //           const Text(
    //             'Beanmind Introduction.',
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //               fontSize: 18,
    //               color: kOnSurfaceTextColor,
    //               fontWeight: FontWeight.bold
    //             ),
    //           ),
    //           CircularButton(
    //               onTap: () => Get.offAndToNamed(HomeScreen.routeName),
    //               child: const Icon(
    //                 Icons.arrow_forward,
    //                 size: 35,
    //               ))
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: mainGradient(context)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: EasySeparatedColumn(
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/background/background_introduction.png',
              height: 200,
            ),
            const Text(
              'Beanmind',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                decoration: TextDecoration.none,
                color: kOnSurfaceTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Trang web học tập dành cho học sinh tiểu học!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.none,
                color: kOnSurfaceTextColor,
              ),
            ),
            CircularButton(
              onTap: () => Get.offAndToNamed(HomeScreen.routeName),
              child: const Icon(
                Icons.arrow_forward,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
