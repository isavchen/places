import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:provider/provider.dart';

class SightCard extends StatelessWidget {
  final Place sight;
  final Function() onTap;
  const SightCard({Key? key, required this.sight, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? _SightCardPortraitWidget(
            sight: sight,
            onTap: onTap,
          )
        : _SightCardLandscapeWidget(
            sight: sight,
            onTap: onTap,
          );
  }
}

class _SightCardPortraitWidget extends StatelessWidget {
  final Place sight;
  final Function() onTap;
  const _SightCardPortraitWidget(
      {Key? key, required this.sight, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    sight.urls.first,
                    width: double.infinity,
                    height: 96,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Container(
                        height: 96,
                        color: Theme.of(context).colorScheme.background,
                        child: Center(
                          child: Platform.isAndroid
                              ? CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                )
                              : CupertinoActivityIndicator.partiallyRevealed(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  progress: loadingProgress
                                              .expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : 0,
                                ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Text(
                    'plase.type.${sight.placeType}'.tr(),
                    style:
                        Theme.of(context).primaryTextTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            ),
                  ),
                ),
              ],
            ),
            Container(
              height: 92,
              width: double.infinity,
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 151.0),
                    child: Text(
                      sight.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                  Text(
                    sight.description,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyMedium
                        ?.copyWith(color: dmSecondaryColor2),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.0),
              splashColor: Colors.teal.withOpacity(0.1),
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SightDetailsScreen(
                      sightId: sight.id,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 9,
          right: 8,
          child: Material(
            color: Colors.transparent,
            child: Consumer<PlaceInteractor>(
              builder: (context, placeInteractor, child) {
                return InkWell(
                  onTap: () {
                    //TODO: delete onTap function, it's just for task 11
                    onTap();
                    placeInteractor.getFavouritePlacesList
                            .any((element) => element.id == sight.id)
                        ? Provider.of<PlaceInteractor>(context, listen: false)
                            .removeFromFavourites(place: sight)
                        : Provider.of<PlaceInteractor>(context, listen: false)
                            .addToFavourites(place: sight);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: SvgPicture.asset(
                      placeInteractor.getFavouritePlacesList
                              .any((element) => element.id == sight.id)
                          ? icHeartFull
                          : icHeart,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SightCardLandscapeWidget extends StatelessWidget {
  final Place sight;
  final Function() onTap;
  const _SightCardLandscapeWidget({Key? key, required this.sight, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    sight.urls.first,
                    width: double.infinity,
                    height: 96,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Container(
                        height: 96,
                        color: Theme.of(context).colorScheme.background,
                        child: Center(
                          child: Platform.isAndroid
                              ? CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                )
                              : CupertinoActivityIndicator.partiallyRevealed(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  progress: loadingProgress
                                              .expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : 0,
                                ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Text(
                    sight.placeType,
                    style:
                        Theme.of(context).primaryTextTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            ),
                  ),
                ),
              ],
            ),
            Container(
              height: 92,
              width: double.infinity,
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 151.0),
                    child: Text(
                      sight.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                  ),
                  Text(
                    sight.description,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyMedium
                        ?.copyWith(color: dmSecondaryColor2),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.0),
              splashColor: Colors.teal.withOpacity(0.1),
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SightDetailsScreen(
                      sightId: sight.id,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 9,
          right: 8,
          child: Material(
            color: Colors.transparent,
            child: Consumer<PlaceInteractor>(
              builder: (context, placeInteractor, child) {
                return InkWell(
                  onTap: () {
                     //TODO: delete onTap function, it's just for task 11
                    onTap();
                    placeInteractor.getFavouritePlacesList
                            .any((element) => element.id == sight.id)
                        ? Provider.of<PlaceInteractor>(context, listen: false)
                            .removeFromFavourites(place: sight)
                        : Provider.of<PlaceInteractor>(context, listen: false)
                            .addToFavourites(place: sight);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: SvgPicture.asset(
                      placeInteractor.getFavouritePlacesList
                              .any((element) => element.id == sight.id)
                          ? icHeartFull
                          : icHeart,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
