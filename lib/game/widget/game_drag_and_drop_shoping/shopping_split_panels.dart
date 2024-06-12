import 'dart:math';

import 'package:beanmind_flutter/game/class/drag_and_drop/shopping.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/types.dart';
import 'package:beanmind_flutter/game/widget/game_drag_and_drop_shoping/shopping_draggable_widget.dart';
import 'package:beanmind_flutter/game/widget/game_drag_and_drop_shoping/shopping_drop_region.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ShopingSplitPanels extends StatefulWidget {
  const ShopingSplitPanels(
      {super.key, this.columns = 10, this.itemSpacing = 4.0});

  final int columns;
  final double itemSpacing;

  @override
  State<ShopingSplitPanels> createState() => _ShopingSplitPanelsState();
}

class _ShopingSplitPanelsState extends State<ShopingSplitPanels> {
  @override
  void initState() {
    super.initState();
    upper.clear();
    lower.clear();
    lower = List.from(startLower);
  }

  PanelLocation? dragStart;
  PanelLocation? dropPreview;
  Product? hoveringData;
  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  void onDragStart(PanelLocation start) {
    final data = switch (start.$2) {
      Panel.lower => lower[start.$1],
      Panel.upper => upper[start.$1],
    };
    setState(() {
      dragStart = start;
      hoveringData = data;
    });
  }

  void drop() {
    try {
      assert(dropPreview != null, 'Can only drop over a known location');
      assert(hoveringData != null, 'Can only drop when data is being dragged');
      setState(() {
        if (dragStart!.$2 == Panel.lower && balance - hoveringData!.price < 0) {
          // Kéo từ dưới lên trên và số dư không đủ
          _showDialog('Số tiền không đủ');
          return;
        }
        if (upper.length >= 10 && dragStart!.$2 == Panel.lower) {
          // Kéo từ dưới lên trên và số lượng vượt quá 10
          _showDialog('Số lượng vượt quá 10');
          return;
        }
        if (dragStart != null) {
          if (dragStart!.$2 == dropPreview!.$2) {
            return;
          }

          if (dragStart!.$2 == Panel.upper) {
            upper.removeAt(dragStart!.$1);
            balance += hoveringData!.price;
          } else {
            lower.removeAt(dragStart!.$1);
            balance -= hoveringData!.price;
          }
        }
        if (dropPreview!.$2 == Panel.upper) {
          upper.insert(min(dropPreview!.$1, upper.length), hoveringData!);
        } else {
          lower.insert(min(dropPreview!.$1, lower.length), hoveringData!);
        }
        dragStart = null;
        dropPreview = null;
        hoveringData = null;
      });
    } catch (e) {
      return;
    }
  }

  void setExternalData(Product data) => hoveringData = data;

  void updateDropPreview(PanelLocation update) {
    setState(() {
      dropPreview = update;
    });
  }

  void _showDialog(
    String message,
  ) {
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final gutters = widget.columns + 1;
      final spaceForColumns =
          constraints.maxWidth - (widget.itemSpacing * gutters);
      final columnWidth = spaceForColumns / widget.columns;
      final itemSize = Size(columnWidth, columnWidth);

      return Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Số tiền bạn có: ${balance} \$',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Text(
                  'Số tiền yêu cầu: ${lastbalance} \$',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
              height: constraints.maxHeight / 2,
              width: constraints.maxWidth,
              top: 100,
              child: MyDropRegion(
                onDrop: drop,
                setExternalData: setExternalData,
                updateDropPreview: updateDropPreview,
                columns: widget.columns,
                childSize: itemSize,
                panel: Panel.upper,
                child: ItemPanel(
                  crossAxisCount: widget.columns,
                  dragStart: dragStart?.$2 == Panel.upper ? dragStart : null,
                  dropPreview:
                      dropPreview?.$2 == Panel.upper ? dropPreview : null,
                  hoveringData:
                      dropPreview?.$2 == Panel.upper ? hoveringData : null,
                  spacing: widget.itemSpacing,
                  items: upper,
                  onDragStart: onDragStart,
                  panel: Panel.upper,
                ),
              )),
          Positioned(
            height: 2,
            width: constraints.maxWidth,
            top: constraints.maxHeight / 2,
            child: const ColoredBox(
              color: Colors.black,
            ),
          ),
          Positioned(
            height: constraints.maxHeight / 2,
            width: constraints.maxWidth,
            bottom: 0,
            child: MyDropRegion(
              onDrop: drop,
              setExternalData: setExternalData,
              updateDropPreview: updateDropPreview,
              columns: widget.columns,
              childSize: itemSize,
              panel: Panel.lower,
              child: ItemPanel(
                crossAxisCount: widget.columns,
                dragStart: dragStart?.$2 == Panel.lower ? dragStart : null,
                dropPreview:
                    dropPreview?.$2 == Panel.lower ? dropPreview : null,
                hoveringData:
                    dropPreview?.$2 == Panel.lower ? hoveringData : null,
                items: lower,
                onDragStart: onDragStart,
                panel: Panel.lower,
                spacing: widget.itemSpacing,
              ),
            ),
          )
        ],
      );
    });
  }
}

class ItemPanel extends StatelessWidget {
  const ItemPanel({
    super.key,
    required this.crossAxisCount,
    required this.dragStart,
    required this.dropPreview,
    required this.hoveringData,
    required this.items,
    required this.onDragStart,
    required this.panel,
    required this.spacing,
  });

  final int crossAxisCount;
  final PanelLocation? dragStart;
  final PanelLocation? dropPreview;
  final Product? hoveringData;
  final List<Product> items;
  final double spacing;

  final Function(PanelLocation) onDragStart;
  final Panel panel;

  @override
  Widget build(BuildContext context) {
    final itemCopy = List<Product>.from(items);

    PanelLocation? dragStartCopy;

    PanelLocation? dropPreviewCopy;

    if (dragStart != null) {
      dragStartCopy = dragStart!.copyWith();
    }

    if (dropPreview != null && hoveringData != null) {
      dropPreviewCopy = dropPreview!.copyWith(
        index: min(items.length, dropPreview!.$1),
      );

      if (dragStartCopy?.$2 == dropPreviewCopy.$2) {
        itemCopy.removeAt(dragStartCopy!.$1);
        dragStartCopy = null;
      }
      itemCopy.insert(
        min(dropPreview!.$1, itemCopy.length),
        hoveringData!,
      );
    }

    return GridView.count(
        crossAxisCount: crossAxisCount,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        children:
            items.asMap().entries.map<Widget>((MapEntry<int, Product> entry) {
          Color textColor =
              entry.key == dragStartCopy?.$1 || entry.key == dropPreviewCopy?.$1
                  ? Colors.grey
                  : Colors.white;

          Widget child = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Transform.scale(
                  scale: 2.0, // Doubles the size of the child
                  child: Image.asset(
                    entry.value.image,
                    height: 55, // Original size
                    width: 55, // Original size
                  ),
                ),
                Text(
                  '${entry.value.price} \$',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, color: textColor),
                ),
              ],
            ),
          );

          if (entry.key == dragStartCopy?.$1) {
            child = Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: child,
            );
          } else if (entry.key == dropPreviewCopy?.$1) {
            child = DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              dashPattern: const [10, 10],
              color: Colors.grey,
              strokeWidth: 2,
              child: child,
            );
          } else {
            child = Container(
              height: 200,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: child,
            );
          }

          return Draggable(
            feedback: child,
            child: MyDraggableWidget(
              data: entry.value.image,
              onDragStart: () => onDragStart((entry.key, panel)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform.scale(
                      scale: 2.0, // Doubles the size of the child
                      child: Image.asset(
                        entry.value.image,
                        height: 55, // Original size
                        width: 55, // Original size
                      ),
                    ),
                    Text(
                      '${entry.value.price} \$',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 36, color: textColor),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList());
  }
}
