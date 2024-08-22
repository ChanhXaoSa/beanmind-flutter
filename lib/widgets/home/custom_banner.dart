import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shimmer/shimmer.dart';

class CustomBanner extends flutter.StatefulWidget {
  const CustomBanner({super.key});

  @override
  _CustomBannerState createState() => _CustomBannerState();
}

class _CustomBannerState extends flutter.State<CustomBanner> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  final List<String> imgList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    final ListResult result = await FirebaseStorage.instance.ref('banner_images').listAll();
    final List<String> urls = await Future.wait(result.items.map((Reference ref) => ref.getDownloadURL()));

    setState(() {
      imgList.addAll(urls);
      isLoading = false;
    });
  }

  @override
  flutter.Widget build(flutter.BuildContext context) {
    if (isLoading) {
      return flutter.Center(child: Shimmer.fromColors(
        baseColor: flutter.Colors.grey[300]!,
        highlightColor: flutter.Colors.grey[100]!,
        child: flutter.Container(
          width: double.infinity,
          height: 650.0,
          color: flutter.Colors.white,
        ),
      ),);
    }

    return flutter.Column(
      children: [
        CarouselSlider(
          items: imgList.map((item) => flutter.Container(
            margin: const flutter.EdgeInsets.all(5.0),
            child: flutter.ClipRRect(
                borderRadius: const flutter.BorderRadius.all(flutter.Radius.circular(5.0)),
                child: flutter.Stack(
                  children: <flutter.Widget>[
                    flutter.Image.network(item, fit: flutter.BoxFit.cover, width: 1000.0, height: 650.0,),
                  ],
                )
            ),
          )).toList(),
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
