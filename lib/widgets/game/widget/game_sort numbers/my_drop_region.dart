import 'package:beanmind_flutter/widgets/game/widget/game_sort%20numbers/types.dart';
import 'package:flutter/material.dart';
class MyDropRegion extends StatefulWidget {
  const MyDropRegion({
    super.key,
    required this.childSize,
    required this.columns,
    required this.panel,
    required this.onDrop,
    required this.setExternalData,
    required this.updateDropPreview,
    required this.child,
  });

  final Size childSize;
  final int columns;
  final Panel panel;
  final VoidCallback onDrop;
  final void Function(int) setExternalData;
  final void Function(PanelLocation) updateDropPreview;
  final Widget child;

  @override
  State<MyDropRegion> createState() => _MyDropRegionState();
}

class _MyDropRegionState extends State<MyDropRegion> {
  int? dropIndex;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAccept: (data) {
        if (data != null) {
          _updatePreview(data);
          return true;
        }
        return false;
      },
      onAccept: (data) {
        widget.setExternalData(int.parse(data));
        widget.onDrop();
      },
      builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
        return widget.child;
      },
    );
  }

  void _updatePreview(String data) {
    final int itemData = int.parse(data);
    final int row = itemData ~/ widget.childSize.height.toInt();
    final int column = (itemData - (widget.childSize.width / 2).toInt()) ~/ widget.childSize.width.toInt();
    int newDropIndex = (row * widget.columns) + column;

    if (newDropIndex != dropIndex) {
      dropIndex = newDropIndex;
      widget.updateDropPreview((newDropIndex, widget.panel));
    }
  }
}
