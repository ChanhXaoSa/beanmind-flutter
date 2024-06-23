import 'package:beanmind_flutter/screens/home/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class CourseScreen extends GetView<CourseController> {
  const CourseScreen({Key? key}) : super(key: key);

  static const String routeName = '/course';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<MyDrawerController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        borderRadius: 50.0,
        showShadow: true,
        angle: 0.0,
        style: DrawerStyle.defaultStyle,
        menuScreen: const CustomDrawer(),
        menuBackgroundColor: Colors.white.withOpacity(0.5),
        slideWidth: MediaQuery.of(context).size.width * 0.6,
        mainScreen: Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kMobileScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(-10, 0),
                        child: const CircularButton(
                          child: Icon(AppIcons.menuleft),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Icon(AppIcons.peace),
                            Builder(
                              builder: (_) {
                                final AuthController _auth = Get.find();
                                final user = _auth.getUser();
                                String _label = '  Xin chào';
                                if (user != null) {
                                  _label = '  Xin chào ${user.displayName}';
                                }
                                return Text(_label,
                                    style: kDetailsTS.copyWith(
                                        color: kOnSurfaceTextColor));
                              },
                            ),
                          ],
                        ),
                      ),
                      const Text('Bạn muốn học gì hôm nay ?', style: kHeaderTS),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                        height:  MediaQuery.of(context).size.height * 0.8, // chiều cao của container
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        flex: 4,
                        child: Container(
                          color: Colors.white,
                          height:  MediaQuery.of(context).size.height * 0.8, // chiều cao của container
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // 4 items per row
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: 20, // replace with your item count
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.blueAccent,
                                child: Center(child: Text('Item $index')),
                              );
                            },
                          ),
                        ),
                      ),
                    const SizedBox(
                      width: 20,)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
