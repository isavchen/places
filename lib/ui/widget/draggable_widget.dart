import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/visited_sight_card.dart';
import 'package:places/ui/widget/want_visiting_card.dart';

class DraggableWidget extends StatefulWidget {
  final int index;
  final Sight sight;
  final int content;
  final dynamic Function() onTabClose;
  final Function(DismissDirection) onDismissed;
  const DraggableWidget({
    Key? key,
    required this.sight,
    required this.content,
    required this.onTabClose,
    required this.index,
    required this.onDismissed,
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
      axis: Axis.vertical,
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
          ? Container(height: widget.content == 1 ? 198 : 218)
          : Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    height: widget.content == 1 ? 198 : 218,
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(bin),
                          SizedBox(height: 8.0),
                          Text(
                            'Удалить',
                            style: lmCaptionText.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: widget.onDismissed,
                  child: widget.content == 1
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
                ),
              ],
            ),
      feedback: Dismissible(
        key: UniqueKey(),
        child: widget.content == 1
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
      ),
    );
  }
}