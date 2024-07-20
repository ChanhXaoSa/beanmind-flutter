import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/themes/app_colors.dart';
import 'package:beanmind_flutter/screens/home/home_screen.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});
  static const String routeName = '/introduction';

  Shader get iphoneShader =>
      const LinearGradient(colors: [Color(0xff7b7d80), Color(0xffffffff)])
          .createShader(const Rect.fromLTWH(0, 100, 50, 2));

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   alignment: Alignment.center,
    //   decoration: BoxDecoration(gradient: mainGradient(context)),
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
    //     child: EasySeparatedColumn(
    //       separatorBuilder: (context, index) => const SizedBox(
    //         height: 20,
    //       ),
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Image.asset(
    //           'assets/images/background/background_introduction.png',
    //           height: 200,
    //         ),
    //         const Text(
    //           'Beanmind',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             fontSize: 24,
    //             decoration: TextDecoration.none,
    //             color: kOnSurfaceTextColor,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         const Text(
    //           'Trang web học tập dành cho học sinh tiểu học!',
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             fontSize: 18,
    //             decoration: TextDecoration.none,
    //             color: kOnSurfaceTextColor,
    //           ),
    //         ),
    //         CircularButton(
    //           onTap: () => Get.offAndToNamed(HomeScreen.routeName),
    //           child: const Icon(
    //             Icons.arrow_forward,
    //             size: 35,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'BEANMIND',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text('Đăng nhập',
                              style: TextStyle(color: Color(0xFFFFFFFF))),
                          SizedBox(width: 40),
                          Text('Các khóa học',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(width: 40),
                          Text('Về chúng tôi',
                              style: TextStyle(color: Color(0xFFFFFFFF))),
                          SizedBox(width: 40),
                          Icon(Icons.search, color: Colors.white),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 100),
                          const Text('Nền tảng',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF), fontSize: 18)),
                          const SizedBox(height: 20),
                          Text(
                            'Beanmind',
                            style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = iphoneShader,
                                shadows: const [
                                  Shadow(
                                      offset: Offset(10, 10),
                                      blurRadius: 20,
                                      color: Colors.black),
                                  Shadow(
                                      offset: Offset(10, 10),
                                      blurRadius: 20,
                                      color: Colors.black12),
                                ]),
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(
                            width: 450,
                            child: Text(
                              'Nền tảng học tập trực tuyến dành cho học sinh tiểu học',
                              style: TextStyle(
                                fontSize: 18,
                                decoration: TextDecoration.none,
                                color: kOnSurfaceTextColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          const SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: () =>
                                Get.offAndToNamed(HomeScreen.routeName),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // Background color
                              foregroundColor: Colors.white, // Text and icon color
                              side: const BorderSide(color: Color(0xffffffff)), // Border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding as needed
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.double_arrow,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Học ngay',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Image.asset(
                        'images/background/background_introduction.png',
                        width: 700,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 100),
                          const Text('Nền tảng',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF), fontSize: 18)),
                          const SizedBox(height: 20),
                          Text(
                            'Beanmind',
                            style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = iphoneShader,
                                shadows: const [
                                  Shadow(
                                      offset: Offset(10, 10),
                                      blurRadius: 20,
                                      color: Colors.black),
                                  Shadow(
                                      offset: Offset(10, 10),
                                      blurRadius: 20,
                                      color: Colors.black12),
                                ]),
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(
                            width: 450,
                            child: Text(
                              'Nền tảng học tập trực tuyến dành cho học sinh tiểu học',
                              style: TextStyle(
                                fontSize: 18,
                                decoration: TextDecoration.none,
                                color: kOnSurfaceTextColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          const SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: () =>
                                Get.offAndToNamed(HomeScreen.routeName),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // Background color
                              foregroundColor: Colors.white, // Text and icon color
                              side: const BorderSide(color: Color(0xffffffff)), // Border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Adjust padding as needed
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.double_arrow,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Học ngay',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Image.asset(
                        'images/background/background_introduction.png',
                        width: 700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
