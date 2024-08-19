import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/common/app_bar_controller.dart';
import 'package:beanmind_flutter/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHomeAppBar extends GetView<AppBarController>
    implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1.0,
      flexibleSpace: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (UIParameters.isMobile(context)) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.navigateToHome(),
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/logo-web.png?alt=media&token=fc4a7733-5731-482f-a690-94c4dbc5ce9e',
                        height: 60.0,
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
                                      CircleAvatar(
                                        backgroundImage: NetworkImage('${controller.user.value!.data!.student!.image}'),
                                        radius: 20.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        controller.user.value!.data!.userName!,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Tìm khoá học...',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                    onChanged: (value) => controller.searchCourses(value),
                                  ),
                                  Obx(() {
                                    return Column(
                                      children: List.generate(controller.filteredCourses.length, (index) {
                                        final course = controller.filteredCourses[index];
                                        return ListTile(
                                          title: Text(course.title!),
                                          onTap: () {
                                            controller.navigateToCourseDetail(course.id!);
                                          },
                                        );
                                      }),
                                    );
                                  }),
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
                        child: CircleAvatar(
                          backgroundImage:
                          NetworkImage('${controller.user.value!.data!.student!.image}'),
                          radius: 30.0,
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
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/logo-web.png?alt=media&token=fc4a7733-5731-482f-a690-94c4dbc5ce9e',
                          height: 60.0,
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
                        onChanged: (value) {
                          controller.searchCourses(value);
                          if (value.isNotEmpty) {
                            SearchOverlay().showSearch(context, _buildSearchResults(context));
                          } else {
                            SearchOverlay().removeSearch();
                          }
                        },
                      ),
                    ),

                    const Spacer(),
                    TextButton(
                      onPressed: () => controller.navigateToCourseList(),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ).copyWith(
                        foregroundColor:
                        WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.hovered)) {
                            return kPrimayLightColorLT;
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
                            fontSize: 18,
                          ),
                        ).copyWith(
                          foregroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.hovered)) {
                              return kPrimayLightColorLT;
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
                                      CircleAvatar(
                                        backgroundImage: NetworkImage('${controller.user.value!.data!.student!.image}'),
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
                        child: CircleAvatar(
                          backgroundImage:
                          NetworkImage('${controller.user.value!.data!.student!.image}'),
                          radius: 30.0,
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
                      child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/beanmind-2911.appspot.com/o/logo-web.png?alt=media&token=fc4a7733-5731-482f-a690-94c4dbc5ce9e',
                        height: 60.0,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => controller.navigateToCourseList(),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ).copyWith(
                        foregroundColor:
                            WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.hovered)) {
                            return kPrimayLightColorLT;
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
                            fontSize: 18,
                          ),
                        ).copyWith(
                          foregroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.hovered)) {
                              return kPrimayLightColorLT;
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
                                      CircleAvatar(
                                        backgroundImage: NetworkImage('${controller.user.value!.data!.student!.image}'),
                                        radius: 20.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        controller.user.value!.data!.userName!,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Tìm khoá học...',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                    ),
                                    onChanged: (value) => controller.searchCourses(value),
                                  ),
                                  Obx(() {
                                    return Column(
                                      children: List.generate(controller.filteredCourses.length, (index) {
                                        final course = controller.filteredCourses[index];
                                        return ListTile(
                                          title: Text(course.title!),
                                          onTap: () {
                                            controller.navigateToCourseDetail(course.id!);
                                          },
                                        );
                                      }),
                                    );
                                  }),
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
                        child: CircleAvatar(
                          backgroundImage:
                          NetworkImage('${controller.user.value!.data!.student!.image}'),
                          radius: 30.0,
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


  Widget _buildSearchResults(BuildContext context) {
    return Obx(() {
      if (controller.filteredCourses.isNotEmpty) {
        return Container(
          color: Colors.white,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: ListView.builder(
            itemCount: controller.filteredCourses.length,
            itemBuilder: (context, index) {
              final course = controller.filteredCourses[index];
              return ListTile(
                title: Text(course.title!),
                onTap: () {
                  controller.navigateToCourseDetail(course.id!);
                  SearchOverlay().removeSearch();
                },
              );
            },
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
