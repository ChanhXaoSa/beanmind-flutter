import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:beanmind_flutter/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    // first 4 boxes in grid
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      width: double.infinity,
                      child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[400],
                            gradient: mainGradient(context),
                          ),
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText('Chào mừng bạn quay lại, User',
                                  maxFontSize: 45,
                                  minFontSize: 30,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              AutoSizeText(
                                  'Bạn đã hoàn thành ... khóa học, bạn muốn khám phá những khóa học khác không ?',
                                  maxFontSize: 24,
                                  minFontSize: 16,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Khám phá ngay',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25)),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Xem lại khóa học',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25)),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // text
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: AutoSizeText('Tiến độ các khóa học bạn chưa hoàn thành',
                          maxFontSize: 24,
                          minFontSize: 24,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior(),
                        child: Scrollbar(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            children: [
                              buildProgressItem(
                                  context, 'Khóa học 1', 0.6, '6/10', '12 giờ'),
                              buildProgressItem(
                                  context, 'Khóa học 2', 0.8, '8/10', '15 giờ'),
                              buildProgressItem(
                                  context, 'Khóa học 3', 0.3, '3/10', '5 giờ'),
                              buildProgressItem(
                                  context, 'Khóa học 4', 0.7, '7/10', '10 giờ'),
                              buildProgressItem(
                                  context, 'Khóa học 5', 1, '10/10', '10 giờ'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // text
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      child: AutoSizeText('Khóa học bạn đã đăng kí gần đây',
                          maxFontSize: 24,
                          minFontSize: 24,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    // list of previous days
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior(),
                        child: Scrollbar(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              buildCourseItem(
                                context,
                                'Khóa học 1',
                                'Ngày đăng kí: 01/01/2021',
                                'https://th.bing.com/th/id/OIP.3EbFGW-Tb-VkOsIfRgOCcgHaE3?rs=1&pid=ImgDetMain',
                              ),
                              buildCourseItem(
                                context,
                                'Khóa học 2',
                                'Ngày đăng kí: 01/01/2021',
                                'https://th.bing.com/th/id/OIP.3EbFGW-Tb-VkOsIfRgOCcgHaE3?rs=1&pid=ImgDetMain',
                              ),
                              buildCourseItem(
                                context,
                                'Khóa học 3',
                                'Ngày đăng kí: 01/01/2021',
                                'https://th.bing.com/th/id/OIP.3EbFGW-Tb-VkOsIfRgOCcgHaE3?rs=1&pid=ImgDetMain',
                              ),
                              buildCourseItem(
                                context,
                                'Khóa học 4',
                                'Ngày đăng kí: 01/01/2021',
                                'https://th.bing.com/th/id/OIP.3EbFGW-Tb-VkOsIfRgOCcgHaE3?rs=1&pid=ImgDetMain',
                              ),
                              buildCourseItem(
                                context,
                                'Khóa học 4',
                                'Ngày đăng kí: 01/01/2021',
                                'https://th.bing.com/th/id/OIP.3EbFGW-Tb-VkOsIfRgOCcgHaE3?rs=1&pid=ImgDetMain',
                              ),
                              buildCourseItem(
                                context,
                                'Khóa học 4',
                                'Ngày đăng kí: 01/01/2021',
                                'https://th.bing.com/th/id/OIP.3EbFGW-Tb-VkOsIfRgOCcgHaE3?rs=1&pid=ImgDetMain',
                              ),
                              buildCourseItem(
                                context,
                                'Khóa học 4',
                                'Ngày đăng kí: 01/01/2021',
                                'https://th.bing.com/th/id/OIP.3EbFGW-Tb-VkOsIfRgOCcgHaE3?rs=1&pid=ImgDetMain',
                              ),
                              buildCourseItem(
                                context,
                                'Khóa học 4',
                                'Ngày đăng kí: 01/01/2021',
                                'https://th.bing.com/th/id/OIP.3EbFGW-Tb-VkOsIfRgOCcgHaE3?rs=1&pid=ImgDetMain',
                              ),
                              // Thêm nhiều item hơn nếu cần
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override the drag devices to include a mouse.
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

Widget buildCourseItem(
    BuildContext context, String title, String subtitle, String imageUrl) {
  return Container(
    width: 200,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          child: Image.network(imageUrl,
              height: MediaQuery.of(context).size.height * 0.09,
              width: double.infinity,
              fit: BoxFit.cover),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildProgressItem(BuildContext context, String title, double progress,
    String slots, String time) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,  
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),     
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(progress >= 1 ? Colors.green : Colors.blue),
        ),
        SizedBox(height: 5),
        Text(
          'Đã học: $slots slot',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        Text(
          'Thời gian đã học: $time',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}
