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
      height: MediaQuery.of(context).size.height * 0.75,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4 items per row
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 20, // replace with your item count
        itemBuilder: (context, index) {
          return SizedBox(
            child: Container(
              color: Colors.blueAccent,
              child: Column(
                children: [
                  const Image(
                      image: AssetImage(
                          'assets/images/background/background_store.png')),
                  const SizedBox(height: 8),
                  Text('Khoá học $index',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
