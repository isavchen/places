import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/response/place.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/visited_sight_card.dart';
import 'package:places/ui/widget/want_visiting_card.dart';

class DraggableWidget extends StatefulWidget {
  final int index;
  final Place sight;
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
      axis: MediaQuery.of(context).orientation == Orientation.portrait
          ? Axis.vertical
          : null,
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
                  borderRadius: BorderRadius.circular(17.0),
                  child: Container(
                    height: widget.content == 1 ? 197 : 217,
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
                            'draggable_widget.delete'.tr(),
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
                  key: ValueKey(widget.sight.id),
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
        key: ValueKey(widget.sight.id),
        child: Container(
          width: MediaQuery.of(context).orientation == Orientation.portrait
              ? null
              : MediaQuery.of(context).size.width * 0.43,
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
      ),
    );
  }
}
