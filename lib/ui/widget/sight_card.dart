import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';

class SightCard extends StatelessWidget {
  final Sight sight;
  const SightCard({Key? key, required this.sight}) : super(key: key);

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
                    sight.url,
                    width: double.infinity,
                    height: 96,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: Platform.isAndroid
                            ? CircularProgressIndicator(
                                color: Color(0xFF252849),
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              )
                            : CupertinoActivityIndicator.partiallyRevealed(
                                progress: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : 0,
                              ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                  child: Text(
                    sight.type,
                    style:
                        Theme.of(context).primaryTextTheme.subtitle2?.copyWith(
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
                color: Theme.of(context).backgroundColor,
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
                      style: Theme.of(context).primaryTextTheme.subtitle1,
                    ),
                  ),
                  Text(
                    sight.details,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2
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
              onTap: () {},
            ),
          ),
        ),
        Positioned(
          top: 9,
          right: 8,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                print("Add to favorite");
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: SvgPicture.asset(
                  icHeart,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
