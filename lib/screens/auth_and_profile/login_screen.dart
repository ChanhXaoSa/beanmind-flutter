import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/auth_controller.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Container(
          constraints: const BoxConstraints(maxWidth: double.infinity),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 350,
                child: SvgPicture.asset('assets/images/logo_beanmind.svg'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Text(
                  'Trang web học tập giành cho học sinh tiểu học',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kOnSurfaceTextColor, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 280,
                child: MainButton(
                  onTap: () {
                    controller.siginInWithGoogle();
                  },
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          child: SvgPicture.asset(
                            'assets/icons/google.svg',
                          )),
                      Center(
                        child: Text(
                          'Sign in with google',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
