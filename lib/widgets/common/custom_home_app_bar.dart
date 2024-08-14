import 'package:beanmind_flutter/configs/themes/ui_parameters.dart';
import 'package:beanmind_flutter/controllers/common/app_bar_controller.dart';
import 'package:beanmind_flutter/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHomeAppBar extends GetView<AppBarController>
    implements PreferredSizeWidget {
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
              if (UIParameters.isMobile(context)) {
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
                    Obx(() {
                      return controller.isLoggedIn.value
                          ? PopupMenuButton<String>(
                        tooltip: '',
                        offset: const Offset(0, kToolbarHeight),
                        onSelected: (String value) {
                          if (value == 'Profile') {
                            Get.toNamed(ProfileScreen.routeName);
                          } else if (value == 'Logout') {
                            controller.signOut();
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              enabled: false,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'images/logo_beanmind.png'),
                                        radius: 20.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        controller.user.value!.data!.userName!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Tìm khoá học...',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            const PopupMenuItem<String>(
                              value: 'Profile',
                              child: Row(
                                children: [
                                  Icon(Icons.person, color: Colors.black54),
                                  SizedBox(width: 8.0),
                                  Text('Tài khoản của tôi'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Logout',
                              child: Row(
                                children: [
                                  Icon(Icons.logout, color: Colors.black54),
                                  SizedBox(width: 8.0),
                                  Text('Đăng xuất'),
                                ],
                              ),
                            ),
                          ];
                        },
                        child: const CircleAvatar(
                          backgroundImage:
                          AssetImage('images/logo_beanmind.png'),
                          radius: 20.0,
                        ),
                      )
                          : ElevatedButton(
                              onPressed: () => controller.signIn(),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                              ),
                              child: const Text('Đăng nhập'),
                            );
                    }),
                  ],
                );
              } else if (UIParameters.isDesktop(context)) {
                return Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => controller.navigateToHome(),
                        child: Image.asset(
                          'images/logo-beanmind.png',
                          height: 40.0,
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
                    TextButton(
                      onPressed: () => controller.navigateToCourseList(),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ).copyWith(
                        foregroundColor:
                        WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.hovered)) {
                            return Colors.blue[900];
                          }
                          return null;
                        }),
                        overlayColor:
                        WidgetStateProperty.all(Colors.transparent),
                      ),
                      child: const Text('Danh sách khóa học'),
                    ),
                    const SizedBox(width: 10.0),
                    TextButton(
                        onPressed: () => controller.navigateToGameList(),
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ).copyWith(
                          foregroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Colors.blue[900];
                            }
                            return null;
                          }),
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                        ),
                        child: const Text('Danh sách game')),
                    const SizedBox(width: 20.0),
                    Obx(() {
                      return controller.isLoggedIn.value
                          ? PopupMenuButton<String>(
                        tooltip: '',
                        offset: const Offset(0, kToolbarHeight),
                        onSelected: (String value) {
                          if (value == 'Profile') {
                            Get.toNamed(ProfileScreen.routeName);
                          } else if (value == 'Logout') {
                            controller.signOut();
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              enabled: false,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'images/logo_beanmind.png'),
                                        radius: 20.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        controller.user.value!.data!.userName!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  // TextField(
                                  //   decoration: InputDecoration(
                                  //     hintText: 'Tìm khoá học...',
                                  //     prefixIcon: const Icon(Icons.search),
                                  //     border: OutlineInputBorder(
                                  //       borderRadius:
                                  //       BorderRadius.circular(10.0),
                                  //       borderSide: BorderSide.none,
                                  //     ),
                                  //     filled: true,
                                  //     fillColor: Colors.grey[200],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            const PopupMenuItem<String>(
                              value: 'Profile',
                              child: Row(
                                children: [
                                  Icon(Icons.person, color: Colors.black54),
                                  SizedBox(width: 8.0),
                                  Text('Tài khoản của tôi'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Logout',
                              child: Row(
                                children: [
                                  Icon(Icons.logout, color: Colors.black54),
                                  SizedBox(width: 8.0),
                                  Text('Đăng xuất'),
                                ],
                              ),
                            ),
                          ];
                        },
                        child: const CircleAvatar(
                          backgroundImage:
                          AssetImage('images/logo_beanmind.png'),
                          radius: 20.0,
                        ),
                      )
                          : ElevatedButton(
                              onPressed: () => controller.signIn(),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                    TextButton(
                      onPressed: () => controller.navigateToCourseList(),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ).copyWith(
                        foregroundColor:
                            WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.hovered)) {
                            return Colors.blue[900];
                          }
                          return null;
                        }),
                        overlayColor:
                            WidgetStateProperty.all(Colors.transparent),
                      ),
                      child: const Text('Danh sách khóa học'),
                    ),
                    const SizedBox(width: 10.0),
                    TextButton(
                        onPressed: () => controller.navigateToGameList(),
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ).copyWith(
                          foregroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Colors.blue[900];
                            }
                            return null;
                          }),
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                        ),
                        child: const Text('Danh sách game')),
                    const SizedBox(width: 20.0),
                    Obx(() {
                      return controller.isLoggedIn.value
                          ? PopupMenuButton<String>(
                        tooltip: '',
                        offset: const Offset(0, kToolbarHeight),
                        onSelected: (String value) {
                          if (value == 'Profile') {
                            Get.toNamed(ProfileScreen.routeName);
                          } else if (value == 'Logout') {
                            controller.signOut();
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              enabled: false,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'images/logo_beanmind.png'),
                                        radius: 20.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        controller.user.value!.data!.userName!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Tìm khoá học...',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            const PopupMenuItem<String>(
                              value: 'Profile',
                              child: Row(
                                children: [
                                  Icon(Icons.person, color: Colors.black54),
                                  SizedBox(width: 8.0),
                                  Text('Tài khoản của tôi'),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Logout',
                              child: Row(
                                children: [
                                  Icon(Icons.logout, color: Colors.black54),
                                  SizedBox(width: 8.0),
                                  Text('Đăng xuất'),
                                ],
                              ),
                            ),
                          ];
                        },
                        child: const CircleAvatar(
                          backgroundImage:
                          AssetImage('images/logo_beanmind.png'),
                          radius: 20.0,
                        ),
                      )
                          : ElevatedButton(
                              onPressed: () => controller.signIn(),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
