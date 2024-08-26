import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Screen2 extends GetView<ProfileController> {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    user.student!.image ?? 'https://via.placeholder.com/150',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: const Text('Tên người dùng:'),
                  subtitle: Text( '${user.firstName ?? 'Chưa có thông tin'} ${user.lastName ?? ''}'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: const Text('Email:'),
                  subtitle: Text(user.email ?? 'Chưa có thông tin'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: const Text('Số điện thoại:'),
                  subtitle: Text(user.phoneNumber ?? 'Chưa có'),
                ),
              ),
              // Thêm các thông tin khác nếu cần
            ],
          );
        }),
      ),
    );
  }
}
