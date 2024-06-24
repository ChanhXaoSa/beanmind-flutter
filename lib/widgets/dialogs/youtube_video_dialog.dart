import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class YoutubeVideoDialog extends StatelessWidget {
  final String videoId;

  YoutubeVideoDialog({required this.videoId});

  @override
  Widget build(BuildContext context) {
    registerYoutubeIframe(videoId);

    return AlertDialog(
      content: AspectRatio(
        aspectRatio: 16 / 9,
        child: HtmlElementView(
          viewType: 'youtube-iframe-$videoId',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Đóng'),
        ),
      ],
    );
  }
}

void registerYoutubeIframe(String videoId) {
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    'youtube-iframe-$videoId',
        (int viewId) => IFrameElement()
      ..width = '640'
      ..height = '360'
      ..src = 'https://www.youtube.com/embed/$videoId'
      ..style.border = 'none',
  );
}
