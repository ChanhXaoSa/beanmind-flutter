import 'package:beanmind_flutter/screens/course/components/courselist.dart';
import 'package:beanmind_flutter/screens/home/custom_drawer.dart';
import 'package:beanmind_flutter/screens/course/components/customappbar.dart';
import 'package:beanmind_flutter/screens/course/components/dropdownlist.dart';
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
        menuScreen: const CustomDrawer(),
        mainScreen: Container(
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  padding: const EdgeInsets.only(top: 20),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          alignment: Alignment.topLeft,
                          height: MediaQuery.of(context).size.height * 0.75,
                          
                          child: Column(
                            children: [
                              const CustomTabBarsPage(),
                              const Text("CHƯƠNG TRÌNH HỌC"),
                              Column(
                                children: [
                                  CheckboxListTile(
                                    title: const Text('LỚP 1'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                  CheckboxListTile(
                                    title: const Text('LỚP 2'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                  CheckboxListTile(
                                    title: const Text('lỚP 3'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                  CheckboxListTile(
                                    title: const Text('lỚP 4'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                  CheckboxListTile(
                                    title: const Text('lỚP 5'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                ],
                              ),
                              const Text("THỜI GIAN TẠO"),
                          
                              // Dropdown
                              const SimpleDropDown(),
                              const Text("Thời gian khoá học"),
                              Column(
                                children: [
                                  CheckboxListTile(
                                    title: const Text('< 15 phút'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                  CheckboxListTile(
                                    title: const Text('15 - 30 phút'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                  CheckboxListTile(
                                    title: const Text('30 - 60 phút'),
                                    value: controller.isBlank,
                                    onChanged: (bool? value) {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Courselist(),
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
