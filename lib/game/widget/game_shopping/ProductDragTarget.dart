import 'package:beanmind_flutter/game/widget/game_shopping/ProductItem.dart';
import 'package:flutter/material.dart';

class ProductDragTarget extends StatelessWidget {
  final List<Product> products;
  final List<bool> dragBool;
  final List<Product> acceptedData;
  final Function(DragTargetDetails<Product>) onAcceptWithDetails;

  const ProductDragTarget({
    super.key,
    required this.products,
    required this.dragBool,
    required this.acceptedData,
    required this.onAcceptWithDetails,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Product>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return acceptedData[0].name.isEmpty
            ? Container(
                height: 100.0,
                width: 100.0,
                color: Colors.cyan,
                child: const Center(
                  child: Text('Drop here'),
                ),
              )
            : Container(
                height: 100.0,
                width: 100.0,
                color: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(acceptedData[0].image, height: 53, width: 56),
                    Text(acceptedData[0].name),
                  ],
                ),
              );
      },
      onAcceptWithDetails: onAcceptWithDetails,
    );
  }
}