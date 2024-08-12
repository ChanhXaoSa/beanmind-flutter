import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Screen2 extends GetView<ProfileController> {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final user = controller.user.value?.data;

          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: ListTile(
                  title: const Text('Tên người dùng:'),
                  subtitle: Text(user.userName ?? 'Chưa có thông tin'),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Email:'),
                  subtitle: Text(user.email ?? 'Chưa có thông tin'),
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text('Số điện thoại:'),
                  subtitle: Text(user.phoneNumber ?? 'Chưa có thông tin'),
                ),
              ),
              // Hiển thị thêm các thông tin khác nếu cần
            ],
          );
        }),
      ),
    );
  }
}