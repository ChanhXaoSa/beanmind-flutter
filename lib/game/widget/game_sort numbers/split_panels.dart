import 'dart:math';
import 'package:beanmind_flutter/game/class/drag_and_drop/math_sort.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/item_panel.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/my_drop_region.dart';
import 'package:beanmind_flutter/game/widget/game_sort%20numbers/types.dart';
import 'package:beanmind_flutter/utils/my_button.dart';
import 'package:flutter/material.dart';

class SplitPanels extends StatefulWidget {
  const SplitPanels({super.key, this.columns = 10, this.itemSpacing = 4.0});

  final int columns;
  final double itemSpacing;

  @override
  State<SplitPanels> createState() => _SplitPanelsState();
}

class _SplitPanelsState extends State<SplitPanels> {
  @override
  void initState() {
    super.initState();
    upper.clear();
    lower.clear();
    randomNumber();
  }

  PanelLocation? dragStart;
  PanelLocation? dropPreview;
  int? hoveringData;

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
    assert(dropPreview != null, 'Can only drop over a known location');
    assert(hoveringData != null, 'Can only drop when data is being dragged');
    setState(() {
      if (dragStart != null) {
        if (dragStart!.$2 == Panel.upper) {
          upper.removeAt(dragStart!.$1);
        } else {
          lower.removeAt(dragStart!.$1);
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
  }

  void setExternalData(int data) => hoveringData = data;

  void updateDropPreview(PanelLocation update) {
    setState(() {
      dropPreview = update;
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
            height: constraints.maxHeight / 2,
            width: constraints.maxWidth,
            top: 0,
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
            ),
          ),
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
          ),
        ],
      );
    });
  }
}
