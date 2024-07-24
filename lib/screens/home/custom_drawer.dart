import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/screens/profile/profile_screen.dart';

class CustomDrawer extends GetView<MyDrawerController> {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(gradient: mainGradient(context)),
      padding: UIParameters.screenPadding,
      child: Theme(
        data: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(backgroundColor: kOnSurfaceTextColor))),
        child: SafeArea(
            child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: BackButton(
                  color: kOnSurfaceTextColor,
                  onPressed: () {
                    controller.toggleDrawer();
                  },
                )),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => controller.user.value == null
                      ? TextButton.icon(
                          icon: const Icon(Icons.login_rounded),
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              elevation: 0,
                              backgroundColor: Colors.white.withOpacity(0.5),
                              foregroundColor: Colors.white),
                          onPressed: () {
                            controller.signIn();
                          },
                          label: const Text("Sign in"))
                      : GestureDetector(
                          onTap: () {
                            Get.toNamed(ProfileScreen.routeName);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 10),
                              child: CircleAvatar(
                                foregroundImage:
                                    // controller.user.value!.photoURL == null
                                    //     ?
                                    null,
                                        // : NetworkImage(
                                        //     controller.user.value!.photoURL!),
                                backgroundColor: Colors.white,
                                radius: 40,
                              ),
                            ),
                          ),
                        )),
                  Obx(
                    () => controller.user.value == null
                        ? const SizedBox()
                        // : Text(controller.user.value!.displayName ?? '',
                        : Text(controller.user.value!.first.data.userName ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: kOnSurfaceTextColor)),
                  ),
                  const Spacer(flex: 1),
                  _DrawerButton(
                      onPressed: () => controller.game(),
                      icon: Icons.gamepad_outlined,
                      label: 'Game của tôi'),
                  _DrawerButton(
                      onPressed: () => controller.courseLearning(),
                      icon: Icons.book,
                      label: 'Quá trình học'),
                  // _DrawerButton(
                  //     onPressed: () => controller.github(),
                  //     icon: AppIcons.github,
                  //     label: 'My GitHub'),
                  // _DrawerButton(
                  //   icon: Icons.code,
                  //   label: ' Download Source Code',
                  //   onPressed: () => controller.downloadSourceCode(),
                  // ),
                  // _DrawerButton(
                  //     icon: AppIcons.contact,
                  //     label: 'Contact Me',
                  //     onPressed: () {}),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 25),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.stretch,
                  //     children: [
                  //       _DrawerButton(
                  //           icon: AppIcons.web, label: 'Web', onPressed: () {}),
                  //       _DrawerButton(
                  //           icon: AppIcons.email,
                  //           label: 'Email',
                  //           onPressed:  () => controller.email()),
                  //       // _DrawerButton(
                  //       //     icon: AppIcons.github,
                  //       //     label: 'GitHub',
                  //       //     onPressed: () {}),
                  //     ],
                  //   ),
                  // ),
                  const Spacer(flex: 4),
                  _DrawerButton(
                    icon: AppIcons.logout,
                    label: 'Sign out',
                    onPressed: () {
                      controller.signOut();
                    },
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({
    Key? key,
    required this.icon,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 15,
        ),
        label: Align(alignment: Alignment.centerLeft, child: Text(label)));
  }
}
