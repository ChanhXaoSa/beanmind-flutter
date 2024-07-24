import 'package:beanmind_flutter/screens/profile/screen/screen1.dart';
import 'package:beanmind_flutter/screens/profile/screen/screen2.dart';
import 'package:beanmind_flutter/screens/profile/screen/screen3.dart';
import 'package:beanmind_flutter/screens/profile/screen/screen4.dart';
import 'package:beanmind_flutter/screens/profile/screen/screen5.dart';
import 'package:beanmind_flutter/screens/profile/style.dart';
import 'package:flutter/material.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // open drawer
          myDrawer(_onItemTapped),
          // main content area
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                // Define your different screens here
                Screen1(),
                Screen2(),
                Screen3(),
                Screen4(),
                Screen5(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Drawer myDrawer(void Function(int) onItemTapped) {
  return Drawer(
    backgroundColor: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Center(
              child: Column(
                children: [
                  Image.network(
                      'https://i0.wp.com/thegameofnerds.com/wp-content/uploads/2022/07/TGON-GAMER-Icon.png?resize=440%2C440&ssl=1',
                      width: 100,
                      height: 100),
                  Text(
                    'Lê Tuấn kiệt',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            onTap: () => onItemTapped(5),
          ),
        ),
      ],
    ),
  );
}