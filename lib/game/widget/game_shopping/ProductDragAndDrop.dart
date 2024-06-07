import 'package:beanmind_flutter/game/widget/game_shopping/ProductDragTarget.dart';
import 'package:beanmind_flutter/game/widget/game_shopping/ProductGridView.dart';
import 'package:beanmind_flutter/game/widget/game_shopping/ProductItem.dart';
import 'package:flutter/material.dart';

class ProductDragAndDrop extends StatefulWidget {
  @override
  _ProductDragAndDropState createState() => _ProductDragAndDropState();
}

class _ProductDragAndDropState extends State<ProductDragAndDrop> {
  final List<Product> products = [
    Product(name: "Áo thun nam", image: "/images/item_store/food/item_store_017.png"),
    Product(name: "Quần jean nam", image: "/images/item_store/food/item_store_043.png"),
    Product(name: "Giày thể thao", image: "/images/item_store/food/item_store_044.png"),
    Product(name: "Túi xách nữ", image: "/images/item_store/food/item_store_056.png"),
    Product(name: "Mũ nón", image: "/images/item_store/food/item_store_057.png"),
    Product(name: "Đồng hồ", image: "/images/item_store/food/item_store_060.png"),
    Product(name: "Điện thoại", image: "/images/item_store/food/item_store_062.png"),
    Product(name: "Laptop", image: "/images/item_store/food/item_store_063.png"),
    Product(name: "Áo thun nam", image: "/images/item_store/food/item_store_067.png"),
    Product(name: "Quần jean nam", image: "/images/item_store/food/item_store_080.png"),
    Product(name: "Giày thể thao", image: "/images/item_store/food/item_store_085.png"),
    Product(name: "Túi xách nữ", image: "/images/item_store/food/item_store_087.png"),
    Product(name: "Mũ nón", image: "/images/item_store/food/item_store_089.png"),
    Product(name: "Đồng hồ", image: "/images/item_store/food/item_store_091.png"),
    Product(name: "Điện thoại", image: "/images/item_store/food/item_store_093.png"),
    Product(name: "Laptop", image: "/images/item_store/food/item_store_094.png"),
    Product(name: "Mũ nón", image: "/images/item_store/food/item_store_095.png"),
    Product(name: "Đồng hồ", image: "/images/item_store/food/item_store_096.png"),
    Product(name: "Điện thoại", image: "/images/item_store/food/item_store_097.png"),
    Product(name: "Laptop", image: "/images/item_store/food/item_store_098.png"),
  ];

  List<bool> dragBool = [];
  List<Product> acceptedData = [];

  @override
  void initState() {
    super.initState();
    dragBool = List<bool>.filled(products.length, false);
    acceptedData = List<Product>.filled(1, Product(name: "", image: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: ProductGridView(products: products, dragBool: dragBool),
              ),
            ),
            Expanded(
              child: ProductDragTarget(
                acceptedData: acceptedData,
                products: products,
                dragBool: dragBool,
                onAcceptWithDetails: (DragTargetDetails<Product> product) {
                  setState(() {
                    acceptedData[0] = product.data;
                    dragBool[products.indexOf(product.data)] = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
