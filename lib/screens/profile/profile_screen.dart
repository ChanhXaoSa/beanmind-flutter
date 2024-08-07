import 'package:beanmind_flutter/screens/profile/desktop_profile_component.dart';
import 'package:beanmind_flutter/screens/profile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: ResponsiveLayout(
        //mobileBody: const MobileScaffold(),
        //tabletBody: const TabletScaffold(),
        desktopBody: DesktopScaffold(),
      ),
    );
  }
}
