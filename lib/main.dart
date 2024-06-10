import 'package:beanmind_flutter/bindings/initial_binding.dart';
import 'package:beanmind_flutter/controllers/common/theme_controller.dart';
import 'package:beanmind_flutter/firebase_options.dart';
import 'package:beanmind_flutter/screens/layout/layout.dart';
import 'package:beanmind_flutter/routes/app_routes.dart';
import 'package:beanmind_flutter/screens/quiz/quiz_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();
  InitialBinding().dependencies();
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //     apiKey: "AIzaSyDnEiQYEx-eREW0igYLAbE2b9bXQbjzbQ0",
  //     authDomain: "beanmind-2911.firebaseapp.com",
  //     projectId: "beanmind-2911",
  //     storageBucket: "beanmind-2911.appspot.com",
  //     messagingSenderId: "635855189971",
  //     appId: "1:635855189971:web:9f3902e9a63a68744be126",
  //     measurementId: "G-HMP0LG4QV3",
  //   ));
  // } else {
  //   await Firebase.initializeApp();
  // }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

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
      // getPages: AppRoutes.pages(),
      home: BeanMindLayout(),
    );
  }
}

Future<void> initFireBase() async {
  await Firebase.initializeApp(
    name: 'quizzle-demo',
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
