import 'package:flutter/material.dart';

class Courselist extends StatefulWidget {
  const Courselist({super.key});

  @override
  State<Courselist> createState() => _CourselistState();
}

class _CourselistState extends State<Courselist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.topLeft,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 300,
        ),
        itemCount: 20, // replace with your item count
        itemBuilder: (context, index) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  border: Border.all(color: Colors.white, width: 5), // Border with width 5
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Image(
                      // border radius for the image
                        image: AssetImage(
                            'assets/images/background/background_store.png')),
                    const SizedBox(height: 8),
                    Text('Khoá học $index',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
