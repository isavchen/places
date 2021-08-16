import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/visited_sight_card.dart';
import 'package:places/ui/widget/want_visiting_card.dart';
import '../../mocks.dart';

class VisitingContent extends StatefulWidget {
  final int content;

  VisitingContent({Key? key, required this.content}) : super(key: key);

  @override
  _VisitingContentState createState() => _VisitingContentState();
}

class _VisitingContentState extends State<VisitingContent> {
  List wantVisitingCards = [
    mocks[3],
    mocks[9],
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
                        child: widget.content == 1
                            ? WantVisitingCard(
                                sight: wantVisitingCards[i],
                                key: ValueKey(wantVisitingCards[i].name + wantVisitingCards[i].details),
                                onTapClose: () {
                                  setState(() {
                                    wantVisitingCards.removeAt(i);
                                  });
                                },
                              )
                            : VisitedSightCard(
                                sight: visitCards[i],
                                onTapClose: () {
                                  setState(() {
                                    visitCards.removeAt(i);
                                  });
                                },
                                key: ValueKey(
                                    visitCards[i].name + visitCards[i].details),
                              ),
                      )
                  ],
                )),
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
