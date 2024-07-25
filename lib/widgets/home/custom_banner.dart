import 'package:flutter/material.dart';

class CustomBanner extends StatefulWidget {
  @override
  _CustomBannerState createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  final PageController _controller = PageController();

  final List<String> _images = [
    'images/background/background_farm.png',
    'images/background/background_ocean.png',
    'images/background/background_shopping_game.png',
  ];

  int _currentIndex = 0;

  void _nextPage() {
    if (_currentIndex < _images.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                _images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300.0,
              );
            },
          ),
          Positioned(
            left: 16.0,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: _previousPage,
              ),
            ),
          ),
          Positioned(
            right: 16.0,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.arrow_forward, color: Colors.white),
                onPressed: _nextPage,
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Make yourself two',
                    style: TextStyle(color: Colors.white, fontSize: 24.0),
                  ),
                  Text(
                    'Comfort & Professional',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Comprehensive educational experiences that develop and enhance skill sets that can be applied to diverse job profiles.',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Find your desired Course'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
