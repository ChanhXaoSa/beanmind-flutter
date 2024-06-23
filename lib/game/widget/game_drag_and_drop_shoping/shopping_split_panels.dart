import 'dart:math';
import 'package:beanmind_flutter/game/class/drag_and_drop/shopping.dart';
import 'package:beanmind_flutter/game/widget/game_drag_and_drop_shoping/shopping_draggable_widget.dart';
import 'package:beanmind_flutter/game/widget/game_drag_and_drop_shoping/shopping_drop_region.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/types.dart';
import 'package:beanmind_flutter/models/game_item_model.dart';
import 'package:beanmind_flutter/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

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

  PanelLocation? dragStart;
  PanelLocation? dropPreview;
  ItemModel? hoveringData;
  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  void onDragStart(PanelLocation start) {
    final data = switch (start.$2) {
      Panel.lower => lowerItemModel[start.$1],
      Panel.upper => upperItemModel[start.$1],
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
          _showDialog('Số tiền không đủ');
          return;
        }
        if (upperItemModel.length >= 10 && dragStart!.$2 == Panel.lower) {
          _showDialog('Số lượng vượt quá 10');
          return;
        }
        if (dragStart != null) {
          if (dragStart!.$2 == dropPreview!.$2) {
            return;
          }

          if (dragStart!.$2 == Panel.upper) {
            upperItemModel.removeAt(dragStart!.$1);
            balance += hoveringData!.price;
          } else {
            lowerItemModel.removeAt(dragStart!.$1);
            balance -= hoveringData!.price;
          }
        }
        if (dropPreview!.$2 == Panel.upper) {
          upperItemModel.insert(min(dropPreview!.$1, upperItemModel.length), hoveringData!);
        } else {
          lowerItemModel.insert(min(dropPreview!.$1, lowerItemModel.length), hoveringData!);
        }
        dragStart = null;
        dropPreview = null;
        hoveringData = null;
      });
    } catch (e) {
      return;
    }
  }

  void setExternalData(ItemModel data) => hoveringData = data;

  void updateDropPreview(PanelLocation update) {
    setState(() {
      dropPreview = update;
    });
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
                  'Số tiền giữ lại theo yêu cầu: ${lastbalance} \$',
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
                  items: upperItemModel,
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
                items: lowerItemModel,
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
  final ItemModel? hoveringData;
  final List<ItemModel> items;
  final double spacing;

  final Function(PanelLocation) onDragStart;
  final Panel panel;

  @override
  Widget build(BuildContext context) {
    final itemCopy = List<ItemModel>.from(items);

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
            items.asMap().entries.map<Widget>((MapEntry<int, ItemModel> entry) {
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
                  child: Image.network(
                        entry.value.imageurl ??
                            'https://via.placeholder.com/150',
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
              data: entry.value.imageurl ??
                  'gs://beanmind-2911.appspot.com/item_game_images/item_store_002.png',
              onDragStart: () => onDragStart((entry.key, panel)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform.scale(
                      scale: 2.0, // Doubles the size of the child
                      child: Image.network(
                        entry.value.imageurl ??
                            'https://via.placeholder.com/150',
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