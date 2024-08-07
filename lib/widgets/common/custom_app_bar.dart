import 'package:beanmind_flutter/widgets/common/audio_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beanmind_flutter/configs/configs.dart';
import 'package:beanmind_flutter/screens/quiz/quiz_overview_screen.dart';
import 'package:beanmind_flutter/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.backPageRoute = 'home',
    this.showActionIcon = false,
    this.showAudioButton = false,
    this.leading,
    this.quizAppBar = false,
    this.titleWidget, this.onMenuActionTap,
  }) : super(key: key);

  final String title;
  final String backPageRoute;
  final Widget? titleWidget;
  final bool showActionIcon;
  final bool quizAppBar;
  final Widget? leading;
  final VoidCallback? onMenuActionTap;
  final bool showAudioButton;
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kMobileScreenPadding,
              vertical: kMobileScreenPadding / 1.2),
          child: Stack(
            children: [
              Positioned.fill(
                child: titleWidget == null ? Center(child: Text(title, style: kAppBarTS)) : Center(child: titleWidget!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(quizAppBar)
                  leading ??
                      Transform.translate(
                          offset: const Offset(-14, 0),
                          child:
                              const BackButton()), // transform to allign icons with body content
                  if(!quizAppBar)
                    leading ??
                        Transform.translate(
                          offset: const Offset(-14, 0),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Get.offAllNamed('/$backPageRoute');
                            },
                          ),
                        ),
                  if (showActionIcon)
                    Transform.translate(
                      offset: const Offset(10,
                          0), // transform to allign icons with body content =>  - CircularButton.padding
                      child:  CircularButton(child: const Icon(AppIcons.menu), onTap: onMenuActionTap ?? (){
                        Get.toNamed(QuizOverviewScreen.routeName);
                      },),
                    ),
                    if(showAudioButton)
                      AudioButton(),
                ],
              ),
            ],
          )),
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        80,
      );
}
