import 'package:beanmind_flutter/controllers/common/app_bar_controller.dart';
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
          child: Row(
            children: [
              Image.asset(
                'images/logo_beanmind.png', // Replace with your logo URL
                height: 40.0,
              ),
              const SizedBox(width: 10.0),
              const Text(
                'Beanmind',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
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
              TextButton(onPressed: () => controller.navigateToHome(), child: const Text('Trang chủ')),
              const SizedBox(width: 10.0),
              TextButton(onPressed: () => controller.navigateToCourseLeaning(), child: const Text('Danh sách khóa học')),
              const SizedBox(width: 10.0),
              TextButton(onPressed: () => controller.navigateToGameList(), child: const Text('Danh sách game')),
              const SizedBox(width: 20.0),
              Obx(() {
                return controller.isLoggedIn.value
                    ? PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'Profile') {
                      // controller.navigateToProfile();
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
                    backgroundImage: AssetImage('images/avatar.png'), // Replace with user's avatar
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
          ),
        ),
      ),
    );
  }
}