import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/visited_sight_card.dart';
import 'package:places/ui/widget/want_visiting_card.dart';
import '../../mocks.dart';

class VisitingContent extends StatelessWidget {
  final int content;
  List<WantVisitingCard> wontVisitingCards = [
    WantVisitingCard(
      sight: mocks[1],
    ),
  ];

  List<VisitedSightCard> visitCards = [
    VisitedSightCard(
      sight: mocks[1],
    ),
    VisitedSightCard(
      sight: mocks[0],
    ),
  ];

  VisitingContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List cards = content == 1 ? wontVisitingCards : visitCards;
    return (cards.isNotEmpty)
        ? SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    for (int i = 0; i < cards.length; i++)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        child: cards[i],
                      )
                  ],
                )),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                content == 1
                    ? "assets/img/empty_1.svg"
                    : "assets/img/empty_2.svg",
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
                  content == 1
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
