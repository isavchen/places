import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/draggable_widget.dart';
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
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  for (int i = 0; i < cards.length; i++)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                      child: DragTarget<int>(
                        builder: (context, candidateData, rejectedData) {
                          return DraggableWidget(
                            // key: ValueKey(
                            //   cards[i].name + cards[i].details,
                            // ),
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
                    ),
                ],
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
                "Пусто",
                style: subtitleText,
              ),
              SizedBox(
                height: 8,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 253.5),
                child: Text(
                  widget.content == 1
                      ? "Отмечайте понравившиеся места и они появятся здесь"
                      : "Завершите маршрут, чтобы место попало сюда",
                  textAlign: TextAlign.center,
                  style: smallText,
                ),
              )
            ],
          );
  }
}
