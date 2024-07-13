import 'package:beanmind_flutter/bindings/initial_binding.dart';
import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/controllers/common/drawer_controller.dart';
import 'package:beanmind_flutter/controllers/common/theme_controller.dart';
import 'package:beanmind_flutter/firebase_options.dart';
import 'package:beanmind_flutter/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();
  InitialBinding().dependencies();
  setPathUrlStrategy();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

// void main(List<String> args) async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await initFireBase();
//   runApp(GetMaterialApp(
//     home: DataUploaderScreen(),
//   ));
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Beanmind',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: Get.find<ThemeController>().getLightheme(),
      darkTheme: Get.find<ThemeController>().getDarkTheme(),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages(),
      // home: BeanMindLayout(),
    );
  }
}

Future<void> initFireBase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
