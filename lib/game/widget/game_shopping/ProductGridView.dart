import 'package:beanmind_flutter/game/widget/game_shopping/ProductItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductGridView extends StatelessWidget {
  final List<Product> products;
  final List<bool> dragBool;

  const ProductGridView({
    Key? key,
    required this.products,
    required this.dragBool,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
      itemBuilder: (context, index) {
        return dragBool[index]
            ? SizedBox()
            : Draggable<Product>(
                data: products[index],
                feedback: Container(
                  color: Colors.deepOrange,
                  height: 60,
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(products[index].image, height: 53, width: 56),
                    ],
                  ),
                ),
                childWhenDragging: Container(
                  height: 60.0,
                  width: 60.0,
                  color: Colors.pinkAccent,
                  child: Center(
                    child: Image.asset(products[index].image, height: 53, width: 56),
                  ),
                ),
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(products[index].image, height: 53, width: 56),
                      Text(products[index].name),
                    ],
                  ),
                ),
              );
      },
    );
  }
}