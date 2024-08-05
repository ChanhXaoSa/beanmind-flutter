import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class CustomBanner extends StatefulWidget {
  const CustomBanner({super.key});

  @override
  _CustomBannerState createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black)
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

final List<Widget> imageSliders = imgList
    .map((item) => Container(
  margin: const EdgeInsets.all(5.0),
  child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: <Widget>[
          Image.asset(item, fit: BoxFit.cover, width: 1000.0),
          // Positioned(
          //   bottom: 0.0,
          //   left: 0.0,
          //   right: 0.0,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [
          //           Color.fromARGB(200, 0, 0, 0),
          //           Color.fromARGB(0, 0, 0, 0)
          //         ],
          //         begin: Alignment.bottomCenter,
          //         end: Alignment.topCenter,
          //       ),
          //     ),
          //     padding: EdgeInsets.symmetric(
          //         vertical: 10.0, horizontal: 20.0),
          //     child: Text(
          //       'No. ${imgList.indexOf(item)} image',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 20.0,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      )),
)).toList();
