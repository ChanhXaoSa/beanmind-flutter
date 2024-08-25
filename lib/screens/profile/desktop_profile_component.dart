import 'package:beanmind_flutter/controllers/profile/profile_controller.dart';
import 'package:beanmind_flutter/screens/profile/screen/screen1.dart';
import 'package:beanmind_flutter/screens/profile/screen/screen2.dart';
import 'package:beanmind_flutter/screens/profile/screen/screen3.dart';
import 'package:beanmind_flutter/screens/profile/screen/screen4.dart';
import 'package:beanmind_flutter/screens/profile/screen/screen5.dart';
import 'package:beanmind_flutter/screens/profile/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesktopScaffold extends GetView<ProfileController> {
  const DesktopScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // open drawer
          myDrawer(controller.onItemTapped, controller),
          // main content area
          Expanded(
            child: Obx(() => IndexedStack(
                  index: controller.selectedIndex.value,
                  children: [
                    // Define your different screens here
                    const Screen1(),
                    const Screen2(),
                    const Screen3(),
                    const Screen4(),
                    Screen5(),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

Drawer myDrawer(void Function(int) onItemTapped, ProfileController controller) {
  return Drawer(
    backgroundColor: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Center(
              child: Column(
                children: [
                  Image.network(
                      controller.user.value?.data?.student!.image ?? 'https://cdn-icons-png.flaticon.com/512/5294/5294712.png',
                      width: 100,
                      height: 100),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text(
                        '${controller.user.value?.data?.firstName ?? 'null'} ${controller.user.value?.data?.lastName ?? 'null'}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                  // Obx(() {
                  //   return Padding(
                  //     padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  //     child: Text(
                  //       // controller.user.value?.data?.userName ?? 'Tên người dùng',
                  //       'vinhtran91@gmail.com',
                  //       style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  //     ),
                  //   );
                  // }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      controller.user.value?.data?.userName ?? 'email',
                      // 'vinhtran91@gmail.com',
                      style:
                          const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(
              Icons.dashboard,
              size: 30,
              color: drawerIconColor,
            ),
            title: Text(
              'TIẾN ĐỘ HỌC TẬP',
              style: drawerTextColor,
            ),
            onTap: () => onItemTapped(0),
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(
              Icons.account_circle,
              size: 30,
              color: drawerIconColor,
            ),
            title: Text(
              'THÔNG TIN CÁ NHÂN',
              style: drawerTextColor,
            ),
            onTap: () => onItemTapped(1),
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(
              Icons.book,
              size: 30,
              color: drawerIconColor,
            ),
            title: Text(
              ' KHOÁ HỌC ĐÃ ĐĂNG KÍ',
              style: drawerTextColor,
            ),
            onTap: () => onItemTapped(2),
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(
              Icons.history,
              size: 30,
              color: drawerIconColor,
            ),
            title: Text(
              'LỊCH SỬ HỌC TẬP',
              style: drawerTextColor,
            ),
            onTap: () => onItemTapped(3),
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(
              Icons.gamepad,
              size: 30,
              color: drawerIconColor,
            ),
            title: Text(
              'TRÒ CHƠI ĐÃ CHƠI',
              style: drawerTextColor,
            ),
            onTap: () => onItemTapped(4),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
        ),
        Padding(
          padding: tilePadding,
          child: ListTile(
            leading: Icon(
              Icons.logout,
              size: 30,
              color: drawerIconColor,
            ),
            title: Text(
              'ĐĂNG XUẤT',
              style: drawerTextColor,
            ),
            onTap: () => controller.signOut(),
          ),
        ),
      ],
    ),
  );
}
