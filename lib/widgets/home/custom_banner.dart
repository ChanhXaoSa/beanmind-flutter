import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart' as flutter;

class CustomBanner extends flutter.StatefulWidget {
  const CustomBanner({super.key});

  @override
  _CustomBannerState createState() => _CustomBannerState();
}

class _CustomBannerState extends flutter.State<CustomBanner> {
  int _current = 0;
  final CarouselControllerPlus _controller = CarouselControllerPlus();

  @override
  flutter.Widget build(flutter.BuildContext context) {
    return flutter.Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          controller: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        flutter.Row(
          mainAxisAlignment: flutter.MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return flutter.GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: flutter.Container(
                width: 12.0,
                height: 12.0,
                margin: const flutter.EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: flutter.BoxDecoration(
                    shape: flutter.BoxShape.circle,
                    color: (flutter.Theme.of(context).brightness == flutter.Brightness.dark
                        ? flutter.Colors.white
                        : flutter.Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

final List<String> imgList = [
  'images/background/background_farm.png',
  'images/background/background_ocean.png',
  'images/background/background_shopping_game.png',
  'images/background/background_store.png',
];

final List<flutter.Widget> imageSliders = imgList
    .map((item) => flutter.Container(
  margin: const flutter.EdgeInsets.all(5.0),
  child: flutter.ClipRRect(
      borderRadius: const flutter.BorderRadius.all(flutter.Radius.circular(5.0)),
      child: flutter.Stack(
        children: <flutter.Widget>[
          flutter.Image.asset(item, fit: flutter.BoxFit.cover, width: 1000.0),
        ],
      )),
)).toList();
