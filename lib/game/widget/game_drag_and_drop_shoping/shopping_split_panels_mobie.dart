import 'package:beanmind_flutter/game/class/drag_and_drop/shopping.dart';
import 'package:beanmind_flutter/models/game_item_model.dart';
import 'package:beanmind_flutter/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopingSplitPanelsMobie extends StatefulWidget {
  const ShopingSplitPanelsMobie({super.key});

  @override
  State<ShopingSplitPanelsMobie> createState() =>
      _ShopingSplitPanelsMobieState();
}

class _ShopingSplitPanelsMobieState extends State<ShopingSplitPanelsMobie> {
  late int columns;
  @override
  void initState() {
    super.initState();
    balance = 100;
    lastbalance = 20;
    upperItemModel.clear();
    lowerItemModel.clear();
    startLowerItemModel = [];
    fetchData();
  }

  Future<void> fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('itemstore').get();

      List<ItemModel> items =
          snapshot.docs.map((doc) => ItemModel.fromSnapshot(doc)).toList();
      print('Number of items fetched: ${items.length}');
      items.forEach((item) {
        print(
            'Item: ${item.id}, Price: ${item.price}, ImageUrl: ${item.imageurl}');
      });

      // Update startLower and lower with the fetched items
      setState(() {
        startLowerItemModel = items;
        lowerItemModel = List<ItemModel>.from(startLowerItemModel);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  void onDragStart(ItemModel product) {
    setState(() {
      upperItemModel.remove(product);
      lowerItemModel.remove(product);
    });
  }

  void onDrop(ItemModel product, bool isUpper) {
    setState(() {
      // Điều kiện 1: Kiểm tra số dư
      if (isUpper && balance - product.price < 0) {
        _showDialog('Số tiền không đủ');
        return;
      }

      // Điều kiện 2: Giới hạn số lượng item
      if (isUpper && upperItemModel.length >= 10) {
        _showDialog('Số lượng vượt quá 10');
        return;
      }

      if (isUpper) {
        upperItemModel.add(product);
        balance -= product.price;
      } else if (!isUpper) {
        lowerItemModel.add(product);
        balance += product.price;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Số tiền bạn có: ${balance} \$',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        )),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Số tiền giữ lại theo yêu cầu: ${lastbalance} \$',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: DragDropList(
            products: upperItemModel,
            onDragStart: onDragStart,
            onDrop: (product) => onDrop(product, true),
            isUpper: true,
          ),
        ),
        const Divider(color: Colors.black, height: 2),
        Expanded(
          flex: 2,
          child: DragDropList(
            products: lowerItemModel,
            onDragStart: onDragStart,
            onDrop: (product) => onDrop(product, false),
            isUpper: false,
          ),
        ),
      ],
    );
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          content: IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.deepPurple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    message,
                    style: whiteTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DragDropList extends StatelessWidget {
  const DragDropList({
    super.key,
    required this.products,
    required this.onDragStart,
    required this.onDrop,
    required this.isUpper,
  });

  final List<ItemModel> products;
  final void Function(ItemModel) onDragStart;
  final void Function(ItemModel) onDrop;
  final bool isUpper;

  @override
  Widget build(BuildContext context) {
    return DragTarget<ItemModel>(
      onWillAccept: (data) => true,
      onAccept: onDrop,
      builder: (context, candidateData, rejectedData) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8, // Số lượng mục trong một hàng
            mainAxisSpacing: 1, // Khoảng cách giữa các hàng
            crossAxisSpacing: 1, // Khoảng cách giữa các cột
            childAspectRatio: 1, // Tỷ lệ chiều rộng/chiều cao của mục
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Draggable<ItemModel>(
              data: product,
              onDragStarted: () => onDragStart(product),
              feedback: ShoppingCartItem(
                product: product,
                isDragging: true,
              ),
              childWhenDragging: Container(),
              child: ShoppingCartItem(
                product: product,
                isDragging: false,
              ),
            );
          },
        );
      },
    );
  }
}

class ShoppingCartItem extends StatelessWidget {
  const ShoppingCartItem(
      {super.key, required this.product, required this.isDragging});

  final ItemModel product;
  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Center(
        child: Column(
          children: [
            Image.network(
              product.imageurl ?? '',
              scale: 0.7,
            ),
            Text('\$${product.price}',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none)),
          ],
        ),
      ),
    );
  }
}
