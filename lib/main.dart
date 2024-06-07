import 'package:beanmind_flutter/layout.dart';
import 'package:beanmind_flutter/quiz_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDnEiQYEx-eREW0igYLAbE2b9bXQbjzbQ0",
      authDomain: "beanmind-2911.firebaseapp.com",
      projectId: "beanmind-2911",
      storageBucket: "beanmind-2911.appspot.com",
      messagingSenderId: "635855189971",
      appId: "1:635855189971:web:9f3902e9a63a68744be126",
      measurementId: "G-HMP0LG4QV3",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beanmind',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}
