import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class MyDraggableWidget extends StatelessWidget {
  const MyDraggableWidget({
    super.key,
    required this.data,
    required this.onDragStart,
    required this.child,
  });

  final String data;
  final Function() onDragStart;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DragItemWidget(dragItemProvider: (DragItemRequest request) {
      onDragStart();
      final item = DragItem(
        localData: data,
      );
      //item.add(Formats.plainText(data));
      return item;
    },
    dragBuilder: (context, child) => Opacity(opacity: 0.8, child: child,),
    allowedOperations: () => [DropOperation.copy],
    child: DraggableWidget(child: child,),
    );
  }
}
