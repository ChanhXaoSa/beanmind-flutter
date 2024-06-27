import 'package:beanmind_flutter/controllers/controllers.dart';
import 'package:beanmind_flutter/widgets/common/screen_background_decoration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html';

import 'package:get/get.dart';

class VideoLearningScreen extends GetView<QuizController> {
  const VideoLearningScreen({Key? key}) : super(key: key);

  static const String routeName = '/videolearningscreen';

  @override
  Widget build(BuildContext context) {
    registerVideoIframe('https://www.youtube.com/embed/d5QASNZ1Nxw');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Video Learning Screen'),
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: HtmlElementView(
                    viewType: 'video-iframe-https://www.youtube.com/embed/d5QASNZ1Nxw',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void registerVideoIframe(String videoUrl) {
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    'video-iframe-$videoUrl',
        (int viewId) => IFrameElement()
      ..width = '640'
      ..height = '360'
      ..src = videoUrl
      ..style.border = 'none',
  );
}
