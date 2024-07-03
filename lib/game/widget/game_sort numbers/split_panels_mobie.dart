import 'package:beanmind_flutter/game/class/drag_and_drop/math_sort.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/types.dart';
import 'package:flutter/material.dart';

class SplitPanelsMobie extends StatefulWidget {
  const SplitPanelsMobie(
      {super.key, this.columns = 10, this.itemSpacing = 4.0});

  final int columns;
  final double itemSpacing;

  @override
  State<SplitPanelsMobie> createState() => _SplitPanelsMobieState();
}

class _SplitPanelsMobieState extends State<SplitPanelsMobie> {
  @override
  void initState() {
    super.initState();
    upper.clear();
    lower.clear();
    randomNumber();
  }

  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  bool? wasUpperList;
  int? draggedProduct;
  void onDragStart(int product) {
    setState(() {
      // Lưu vị trí và danh sách trước đó của mục được kéo
      draggedProduct = product;
      wasUpperList = upper.contains(product);
    });
  }

  void onDrop(int product, bool isUpper) {
    setState(() {
      // Loại bỏ mục khỏi danh sách tạm thời
      upper.remove(product);
      lower.remove(product);

      // Điều kiện 2: Giới hạn số lượng item
      if (isUpper && upper.length >= 10) {
        _showDialog('Số lượng vượt quá 10');
        // Thêm lại mục vào danh sách trước đó nếu số lượng vượt quá
        if (wasUpperList == true) {
          upper.add(draggedProduct!);
        } else {
          lower.add(draggedProduct!);
        }
        return;
      }

      // Kiểm tra nếu mục được thả vào cùng danh sách thì không làm gì
      if ((isUpper && wasUpperList == true) ||
          (!isUpper && wasUpperList == false)) {
        // Thêm lại mục vào danh sách trước đó
        if (wasUpperList == true) {
          upper.add(draggedProduct!);
        } else {
          lower.add(draggedProduct!);
        }
        return;
      }

      // Nếu mục được thả vào danh sách mới, cập nhật danh sách và số dư
      if (isUpper) {
        upper.add(product);
      } else {
        lower.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple[250],
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DragDropList(
              products: upper,
              onDragStart: onDragStart,
              onDrop: (product) => onDrop(product, true),
              isUpper: true,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: DragDropList(
            products: lower,
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

  final List<int> products;
  final void Function(int) onDragStart;
  final void Function(int) onDrop;
  final bool isUpper;

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onWillAccept: (data) => true,
      onAccept: onDrop,
      builder: (context, candidateData, rejectedData) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10, // Số lượng mục trong một hàng
            mainAxisSpacing: 1, // Khoảng cách giữa các hàng
            crossAxisSpacing: 1, // Khoảng cách giữa các cột
            childAspectRatio: 1, // Tỷ lệ chiều rộng/chiều cao của mục
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Draggable<int>(
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

  final int product;
  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;
    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    double size = screenWidth < screenHeight
                  ? screenWidth / 8
                  : screenHeight / 8;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Center(
        child: Column(
          children: [
            Card(
              color: Colors.blue[300],
              child: Container(
                height:size,
                width: size,
                alignment: Alignment.center,
                child: Text(
                  '${product.toString()}',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
