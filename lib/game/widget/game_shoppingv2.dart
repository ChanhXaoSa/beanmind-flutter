import 'package:flutter/material.dart';

class Product {
  final String name;
  final String image;

  Product({required this.name, required this.image});
}

class ProductDragAndDrop extends StatefulWidget {
  @override
  _ProductDragAndDropState createState() => _ProductDragAndDropState();
}

class _ProductDragAndDropState extends State<ProductDragAndDrop> {
  final products = [
    Product(
        name: "Áo thun nam",
        image: "/images/item_store/food/item_store_017.png"),
    Product(
        name: "Quần jean nam",
        image: "/images/item_store/food/item_store_043.png"),
    Product(
        name: "Giày thể thao",
        image: "/images/item_store/food/item_store_044.png"),
    Product(
        name: "Túi xách nữ",
        image: "/images/item_store/food/item_store_056.png"),
    Product(
        name: "Mũ nón", 
        image: "/images/item_store/food/item_store_057.png"),
    Product(
        name: "Đồng hồ", 
        image: "/images/item_store/food/item_store_060.png"),
    Product(
        name: "Điện thoại",
        image: "/images/item_store/food/item_store_062.png"),
    Product(
        name: "Laptop", 
        image: "/images/item_store/food/item_store_063.png"),
    Product(
        name: "Áo thun nam",
        image: "/images/item_store/food/item_store_067.png"),
    Product(
        name: "Quần jean nam",
        image: "/images/item_store/food/item_store_080.png"),
    Product(
        name: "Giày thể thao",
        image: "/images/item_store/food/item_store_085.png"),
    Product(
        name: "Túi xách nữ",
        image: "/images/item_store/food/item_store_087.png"),
    Product(
        name: "Mũ nón", 
        image: "/images/item_store/food/item_store_089.png"),
    Product(
        name: "Đồng hồ", 
        image: "/images/item_store/food/item_store_091.png"),
    Product(
        name: "Điện thoại",
        image: "/images/item_store/food/item_store_093.png"),
    Product(
        name: "Laptop", 
        image: "/images/item_store/food/item_store_094.png"),
    Product(
        name: "Mũ nón", 
        image: "/images/item_store/food/item_store_095.png"),
    Product(
        name: "Đồng hồ", 
        image: "/images/item_store/food/item_store_096.png"),
    Product(
        name: "Điện thoại",
        image: "/images/item_store/food/item_store_097.png"),
    Product(
        name: "Laptop", 
        image: "/images/item_store/food/item_store_098.png"),
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
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
                itemBuilder: (context, index) {
                  return dragBool[index]
                      ? SizedBox()
                      : Draggable<Product>(
                    data: products[index],
                    feedback: Container(
                      color: Colors.deepOrange,
                      height: 100,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(products[index].image,
                              height: 53, width: 56),
                          //Text(products[index].name),
                        ],
                      ),
                    ),
                    childWhenDragging: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.pinkAccent,
                      child: Center(
                        child: Image.asset(products[index].image,
                              height: 53, width: 56),
                      ),
                    ),
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(products[index].image,
                              height: 53, width: 56),
                          Text(products[index].name),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: DragTarget<Product>(
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
                          child: Center(
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
                              Image.asset(acceptedData[0].image,
                                  height: 53, width: 56),
                              Text(acceptedData[0].name),
                            ],
                          ),
                        );
                },
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
    );
  }
}
