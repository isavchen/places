import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/draggable_widget.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import '../../mocks.dart';

class VisitingContent extends StatefulWidget {
  final int content;

  VisitingContent({Key? key, required this.content}) : super(key: key);

  @override
  _VisitingContentState createState() => _VisitingContentState();
}

class _VisitingContentState extends State<VisitingContent> {
  List wantVisitingCards = [
    mocks[0],
    mocks[1],
    mocks[2],
    mocks[3],
  ];

  List visitCards = [
    mocks[1],
    mocks[0],
    mocks[6],
  ];

  @override
  Widget build(BuildContext context) {
    List cards = widget.content == 1 ? wantVisitingCards : visitCards;
    return (cards.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: OverscrollGlowAbsorber(
              child: ListView.builder(
                physics: Platform.isIOS
                    ? BouncingScrollPhysics()
                    : ClampingScrollPhysics(),
                itemCount: cards.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: DragTarget<int>(
                      builder: (context, candidateData, rejectedData) {
                        return DraggableWidget(
                          index: i,
                          content: widget.content,
                          sight: cards[i],
                          onTabClose: () {
                            setState(() {
                              cards.removeAt(i);
                            });
                          },
                          onDismissed: (_) {
                            setState(() {
                              cards.removeAt(i);
                            });
                          },
                        );
                      },
                      onWillAccept: (data) {
                        return true;
                      },
                      onAccept: (data) {
                        final item = cards[data];
                        setState(() {
                          cards.removeAt(data);
                          cards.insert(i, item);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                widget.content == 1 ? icEmpty1 : icEmpty2,
                color: dmSecondaryColor2,
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'visiting_content.empty.title'.tr(),
                style: subtitleText,
              ),
              SizedBox(
                height: 8,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 253.5),
                child: Text(
                  widget.content == 1
                      ? 'visiting_content.want_visit.empty.desc'.tr()
                      : 'visiting_content.visited.empty.desc'.tr(),
                  textAlign: TextAlign.center,
                  style: smallText,
                ),
              )
            ],
          );
  }
}
