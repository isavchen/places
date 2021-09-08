import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/widget/visited_sight_card.dart';
import 'package:places/ui/widget/want_visiting_card.dart';

class DraggableWidget extends StatefulWidget {
  final int index;
  final Sight sight;
  final int content;
  final dynamic Function() onTabClose;
  const DraggableWidget({
    Key? key,
    required this.sight,
    required this.content,
    required this.onTabClose,
    required this.index,
  }) : super(key: key);

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  GlobalKey globalKey = GlobalKey();
  bool isDrag = false;

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      // axis: Axis.vertical,
      onDragStarted: () {
        setState(() {
          isDrag = true;
        });
      },
      onDragEnd: (details) {
        setState(() {
          isDrag = false;
        });
      },
      data: widget.index,
      child: isDrag
          ? Container(height: widget.content == 1 ? 178 : 198)
          : widget.content == 1
              ? WantVisitingCard(
                  sight: widget.sight,
                  onTapClose: widget.onTabClose,
                  key: globalKey,
                )
              : VisitedSightCard(
                  sight: widget.sight,
                  onTapClose: widget.onTabClose,
                  key: globalKey,
                ),
      feedback: widget.content == 1
          ? WantVisitingCard(
              sight: widget.sight,
              onTapClose: widget.onTabClose,
              key: globalKey,
            )
          : VisitedSightCard(
              sight: widget.sight,
              onTapClose: widget.onTabClose,
              key: globalKey,
            ),
    );
  }
}
