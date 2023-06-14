import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/dismissible_card_widget.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:provider/provider.dart';

class VisitingContent extends StatefulWidget {
  final int content;

  VisitingContent({Key? key, required this.content}) : super(key: key);

  @override
  _VisitingContentState createState() => _VisitingContentState();
}

class _VisitingContentState extends State<VisitingContent> {

  //
  void removePlace(Place place) {
    if (widget.content == 1) {
      Provider.of<PlaceInteractor>(context, listen: false)
          .removeFromFavourites(place: place);
    } else {
      Provider.of<PlaceInteractor>(context, listen: false)
          .removeFromVisitedList(place: place);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceInteractor>(
      builder: (context, placeInteractor, child) {
        final cardsList = widget.content == 1
            ? placeInteractor.getFavouritePlacesList
            : placeInteractor.getVisitedPlaces;
        return cardsList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: OverscrollGlowAbsorber(
                  child: MediaQuery.of(context).orientation ==
                          Orientation.portrait
                      ? ListView.builder(
                          physics: Platform.isIOS
                              ? BouncingScrollPhysics()
                              : ClampingScrollPhysics(),
                          itemCount: cardsList.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 0, 16.0, 16.0),
                              child: DismissibleCardWidget(
                                content: widget.content,
                                sight: cardsList[i],
                                onTabClose: () => removePlace(cardsList[i]),
                                onDismissed: (_) => removePlace(cardsList[i]),
                              ),
                              // child: DragTarget<int>(
                              //   builder:
                              //       (context, candidateData, rejectedData) {
                              //     return DraggableWidget(
                              //       index: i,
                              //       content: widget.content,
                              //       sight: cardsList[i],
                              //       onTabClose: () => removePlace(cardsList[i]),
                              //       onDismissed: (_) => removePlace(cardsList[i]),
                              //     );
                              //   },
                              //   onWillAccept: (data) {
                              //     return true;
                              //   },
                              //   onAccept: (data) {
                              //     final item = cardsList[data];
                              //     setState(() {
                              //       cardsList.removeAt(data);
                              //       cardsList.insert(i, item);
                              //     });
                              //   },
                              // ),
                            );
                          },
                        )
                      : GridView.builder(
                          itemCount: cardsList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 36.0,
                            childAspectRatio:
                                widget.content == 1 ? 30 / 19 : 30 / 20.5,
                          ),
                          itemBuilder: (context, i) => Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                            child: DismissibleCardWidget(
                              content: widget.content,
                              sight: cardsList[i],
                              onTabClose: () => removePlace(cardsList[i]),
                              onDismissed: (_) => removePlace(cardsList[i]),
                            ),
                            // child: DragTarget<int>(
                            //   builder: (context, candidateData, rejectedData) {
                            //     return DraggableWidget(
                            //       index: i,
                            //       content: widget.content,
                            //       sight: cardsList[i],
                            //       onTabClose: () => removePlace(cardsList[i]),
                            //       onDismissed: (_) => removePlace(cardsList[i]),
                            //     );
                            //   },
                            //   onWillAccept: (data) {
                            //     return true;
                            //   },
                            //   onAccept: (data) {
                            //     final item = cardsList[data];
                            //     setState(() {
                            //       cardsList.removeAt(data);
                            //       cardsList.insert(i, item);
                            //     });
                            //   },
                            // ),
                          ),
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
      },
    );
  }
}
