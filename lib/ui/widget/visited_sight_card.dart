import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';

class VisitedSightCard extends StatelessWidget {
  final Sight sight;
  const VisitedSightCard({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 218,
      child: Column(
        children: [
          Container(
            height: 96,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    sight.url,
                    width: double.infinity,
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
                                progress: loadingProgress
                                            .expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : 0,
                              ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 16.0,
                  left: 16.0,
                  child: Text(
                    sight.type,
                    style: Theme.of(context).primaryTextTheme.subtitle2?.copyWith(
                              color: Colors.white,
                            ),
                  ),
                ),
                Positioned(
                  top: 22,
                  right: 22,
                  child: SvgPicture.asset("assets/img/close.svg", color: Colors.white,),
                ),
                Positioned(
                  top: 16,
                  right: 56,
                  child: SvgPicture.asset("assets/img/share.svg", color: Colors.white,),
                ),
              ],
            ),
          ),
          Container(
            height: 122,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: Text(
                      sight.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).primaryTextTheme.subtitle1,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 28,
                    child: Text(
                      'Цель достигнута 12 окт. 2020',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2
                        ?.copyWith(color: dmSecondaryColor2),
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "закрыто до 09:00",
                      style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2
                        ?.copyWith(color: dmSecondaryColor2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
