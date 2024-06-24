import 'package:beanmind_flutter/screens/home/custom_drawer.dart';
import 'package:beanmind_flutter/utils/customappbar.dart';
import 'package:beanmind_flutter/utils/dropdownlist.dart';
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
        showShadow: true,
        angle: 0.0,
        menuScreen: const CustomDrawer(),
        mainScreen: Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: SafeArea(
            child: Column(
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
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              child: const CustomTabBarsPage(),
                            ),
                            Text("CLASS LEVEL"),
                            Container(
                              // build checkbox list
                              child: Column(
                                children: [
                                  CheckboxListTile(
                                    title: const Text('Beginner'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Intermediate'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                  CheckboxListTile(
                                    title: const Text('Advanced'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                ],
                              ),
                            ),
                            Text("CREATED WITHIN"),
                            Container(
                              child: const SimpleDropDown(),
                            ),
                            Text("CLASS LENGTH"),
                            Container(
                              // add list view

                              child: Column(
                                children: [
                                  CheckboxListTile(
                                    title: const Text('< 15 minutes'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                  CheckboxListTile(
                                    title: const Text('15 - 30 minutes'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                  CheckboxListTile(
                                    title: const Text('30 - 60 minutes'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // 4 items per row
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: 20, // replace with your item count
                            itemBuilder: (context, index) {
                              return SizedBox(
                                child: Container(
                                  color: Colors.blueAccent,
                                  child: Column(
                                    children: [
                                      const Image(
                                          image: AssetImage(
                                              'assets/images/background/background_store.png')),
                                      const SizedBox(height: 8),
                                      Text('Course $index',
                                          style: kHeaderTS.copyWith(
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
