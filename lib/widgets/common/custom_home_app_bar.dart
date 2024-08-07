import 'package:beanmind_flutter/configs/themes/ui_parameters.dart';
import 'package:beanmind_flutter/controllers/common/app_bar_controller.dart';
import 'package:beanmind_flutter/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHomeAppBar extends GetView<AppBarController> implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1.0,
      title: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if(UIParameters.isMobile(context)) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.navigateToHome(),
                      child: Image.asset(
                        'images/logo_beanmind.png',
                        height: 40.0,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () => controller.navigateToHome(),
                      child: const Text(
                        'Beanmind',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Hành động khi bấm nút tìm kiếm
                      },
                    ),
                    const Spacer(),
                    Obx(() {
                      return controller.isLoggedIn.value
                          ? PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'Profile') {
                            Get.toNamed(ProfileScreen.routeName);
                          }
                          // Handle other menu selections
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Profile', 'Settings', 'Logout'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/logo_beanmind.png'),
                          radius: 20.0,
                        ),
                      )
                          : ElevatedButton(
                        onPressed: () => controller.signIn(),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                        child: const Text('Đăng nhập'),
                      );
                    }),
                  ],
                );
              } else if(UIParameters.isDesktop(context)) {
                return Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => controller.navigateToHome(),
                        child: Image.asset(
                          'images/logo_beanmind.png',
                          height: 40.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => controller.navigateToHome(),
                        child: const Text(
                          'Beanmind',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm khóa học ...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(onPressed: () => controller.navigateToCourseLeaning(), child: const Text('Danh sách khóa học')),
                    const SizedBox(width: 10.0),
                    TextButton(onPressed: () => controller.navigateToGameList(), child: const Text('Danh sách game')),
                    const SizedBox(width: 20.0),
                    Obx(() {
                      return controller.isLoggedIn.value
                          ? PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'Profile') {
                            Get.toNamed(ProfileScreen.routeName);
                          } else if (value == 'Logout') {
                            controller.signOut();
                          }
                          // Handle other menu selections
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Profile', 'Logout'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/logo_beanmind.png'),
                          radius: 20.0,
                        ),
                      )
                          : ElevatedButton(
                        onPressed: () => controller.signIn(),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                        child: const Text('Đăng nhập'),
                      );
                    }),
                  ],
                );
              } else {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.navigateToHome(),
                      child: Image.asset(
                        'images/logo_beanmind.png',
                        height: 40.0,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () => controller.navigateToHome(),
                      child: const Text(
                        'Beanmind',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Hành động khi bấm nút tìm kiếm
                      },
                    ),
                    const Spacer(),
                    Obx(() {
                      return controller.isLoggedIn.value
                          ? PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'Profile') {
                            Get.toNamed(ProfileScreen.routeName);
                          }
                          // Handle other menu selections
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Profile', 'Settings', 'Logout'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/logo_beanmind.png'),
                          radius: 20.0,
                        ),
                      )
                          : ElevatedButton(
                        onPressed: () => controller.signIn(),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                        child: const Text('Đăng nhập'),
                      );
                    }),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}