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
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: const CustomAppBar(),
    //   body: Container(
    //       constraints: const BoxConstraints(maxWidth: double.infinity),
    //       padding: const EdgeInsets.symmetric(horizontal: 30),
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(gradient: mainGradient(context)),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             width: 350,
    //             height: 350,
    //             child: SvgPicture.asset('assets/images/logo_beanmind.svg'),
    //           ),
    //           const Padding(
    //             padding: EdgeInsets.symmetric(vertical: 60),
    //             child: Text(
    //               'Trang web học tập giành cho học sinh tiểu học',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                   color: kOnSurfaceTextColor, fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //           Container(
    //             width: 280,
    //             child: MainButton(
    //               onTap: () {
    //                 controller.siginInWithGoogle();
    //               },
    //               color: Colors.white,
    //               child: Stack(
    //                 children: [
    //                   Positioned(
    //                       top: 0,
    //                       bottom: 0,
    //                       left: 0,
    //                       child: SvgPicture.asset(
    //                         'assets/icons/google.svg',
    //                       )),
    //                   Center(
    //                     child: Text(
    //                       'Sign in with google',
    //                       style: TextStyle(
    //                           color: Theme.of(context).primaryColor,
    //                           fontWeight: FontWeight.bold),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       )),
    // );

    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        body: Center(
            child: isSmallScreen
                ? const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Logo(),
                _FormContent(),
              ],
            )
                : Container(
              padding: const EdgeInsets.all(32.0),
              constraints: const BoxConstraints(maxWidth: 800),
              child: const Row(
                children: [
                  Expanded(child: _Logo()),
                  Expanded(
                    child: Center(child: _FormContent()),
                  ),
                ],
              ),
            )));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo_beanmind.png',
          width: isSmallScreen ? 100 : 200,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Chào mừng đến với Beanmind!",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  final TextEditingController _emailController = TextEditingController(text: 'user1');
  final TextEditingController _passwordController = TextEditingController(text: 'User1!');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Ô này không được để trống';
                }

                // bool emailValid = RegExp(
                //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                //     .hasMatch(value);
                // if (!emailValid) {
                //   return 'Vui lòng nhập địa chỉ email hợp lệ';
                // }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Địa chỉ email',
                hintText: 'Nhập địa chỉ email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ô này không được để trống';
                }

                if (value.length < 6) {
                  return 'Mật khẩu phải dài hơn 6 kí tự';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
            ),
            _gap(),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
              },
              title: const Text('Nhớ tài khoản'),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    Get.find<AuthController>().login(email, password);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
