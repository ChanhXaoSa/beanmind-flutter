import 'package:beanmind_flutter/game/widget/game_drag_and_drop/types.dart';
import 'package:beanmind_flutter/game/widget/game_drag_and_drop_shoping/shopping_split_panels.dart';
import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

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
  final void Function(Product) setExternalData;
  final void Function(PanelLocation) updateDropPreview;
  final Widget child;

  @override
  State<MyDropRegion> createState() => _MyDropRegionState();
}

class _MyDropRegionState extends State<MyDropRegion> {
  int? dropIndex;

  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: Formats.standardFormats,
      onDropOver: (DropOverEvent event) {
        _updatePreview(event.position.local);
        return DropOperation.copy;
      },

      onPerformDrop: (PerformDropEvent event) async {
        widget.onDrop();
      },

      onDropEnter: (DropEvent event) {
        if (event.session.items.first.dataReader != null) {
          final dataReader = event.session.items.first.dataReader!;
          if (!dataReader.canProvide(Formats.plainTextFile)) {
            // show unsportted file type message
            return;
          }
        }
      },
      child: widget.child,
    );
    //onPerformDrop: onPerformDrop);
  }

  void _updatePreview(Offset hoverPosition) {
    final int row = hoverPosition.dy ~/ widget.childSize.height;
    final int column = (hoverPosition.dx - (widget.childSize.width / 2)) ~/
        widget.childSize.width;
    int newDropIndex = (row * widget.columns) + column;

    if (newDropIndex != dropIndex) {
      dropIndex = newDropIndex;
      widget.updateDropPreview((dropIndex!, widget.panel));
    }
  }
}
