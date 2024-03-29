import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/visited_sight_card.dart';
import 'package:places/ui/widget/want_visiting_card.dart';

class DismissibleCardWidget extends StatefulWidget {
  final Place sight;
  final bool isWantToVisitContent;
  final dynamic Function() onTabClose;
  final Function(DismissDirection) onDismissed;
  const DismissibleCardWidget({
    Key? key,
    required this.sight,
    required this.isWantToVisitContent,
    required this.onTabClose,
    required this.onDismissed,
  }) : super(key: key);

  @override
  _DismissibleCardWidgetState createState() => _DismissibleCardWidgetState();
}

class _DismissibleCardWidgetState extends State<DismissibleCardWidget> {
  GlobalKey globalKey = GlobalKey();
  bool isDrag = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(17.0),
          child: Container(
            height: widget.isWantToVisitContent ? 197 : 217,
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
          child: widget.isWantToVisitContent
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
    );
  }
}
