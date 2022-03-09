import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/screens/sight_details_bottomsheet_screen.dart';
import 'package:places/ui/screens/sight_details_screen.dart';

class WantVisitingCard extends StatelessWidget {
  final Function() onTapClose;
  final Sight sight;
  const WantVisitingCard(
      {Key? key, required this.sight, required this.onTapClose})
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
                    sight.galery.first,
                    height: 96,
                    width: MediaQuery.of(context).size.width - 32.0,
                    colorBlendMode: BlendMode.srcATop,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.24),
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: Platform.isAndroid
                            ? CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.secondary,
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
                Positioned(
                  top: 16.0,
                  left: 16.0,
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
              height: 102,
              width: MediaQuery.of(context).size.width - 32.0,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      sight.name,
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
                      'Запланировано на 12 окт. 2020',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                          ),
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
                          ?.copyWith(
                            color: dmSecondaryColor2,
                          ),
                    ),
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
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? _openDetailsScreen(sight.id, context)
                    : Navigator.of(context).push(
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
          right: 49,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                var dateTime;
                if (Platform.isAndroid)
                  dateTime = await _openAndroidDateTimePicker(context);
                else
                  dateTime = await _openIOSDateTimePicker(context);
                if (dateTime != null) {
                  //TODO: установить напоминание
                  print(dateTime);
                }
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SvgPicture.asset(
                  icCalendar,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 9,
          right: 9,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTapClose,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: SvgPicture.asset(
                  icClose,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openDetailsScreen(int sightId, BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SightDetailsBottomsheet(
          sightId: sightId,
        );
      },
      isScrollControlled: true,
    );
  }
}

Future<dynamic> _openAndroidDateTimePicker(BuildContext context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(Duration(days: 100)),
    lastDate: DateTime.now().add(
      Duration(days: 100),
    ),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).primaryColor == Colors.white
            ? ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: lmGreenColor,
                  secondary: lmGreenColor,
                ),
              )
            : ThemeData.dark().copyWith(
                dialogBackgroundColor: dmPrimaryColor,
                colorScheme: ColorScheme.light(
                  primary: dmGreenColor,
                  onPrimary: dmAccentColor,
                  onSurface: dmAccentColor,
                ),
              ),
        child: child!,
      );
    },
  ).then(
    (value) {
      if (value != null) {
        return showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) => Theme(
            data: Theme.of(context).primaryColor == Colors.white
                ? ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: lmGreenColor,
                      secondary: lmGreenColor,
                    ),
                  )
                : ThemeData.dark().copyWith(
                    dialogBackgroundColor: dmPrimaryColor,
                    colorScheme: ColorScheme.dark(
                      primary: dmGreenColor,
                      onPrimary: dmAccentColor,
                      onSurface: dmAccentColor,
                    ),
                  ),
            child: child!,
          ),
        );
      }
    },
  );
}

Future<dynamic> _openIOSDateTimePicker(BuildContext context) {
  DateTime? _selected;
  return showModalBottomSheet(
    context: context,
    builder: (_) => Container(
      height: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: Text(
                    'Cancel',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoButton(
                  child: Text(
                    'Done',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.surface),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(_selected);
                  },
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
          ),
          Expanded(
            child: Container(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  brightness: Theme.of(context).primaryColor == Colors.white ? Brightness.light : Brightness.dark,
                ),
                child: CupertinoDatePicker(
                  backgroundColor: Theme.of(context).primaryColor,
                  initialDateTime: DateTime.now(),
                  minimumDate: DateTime.now().subtract(Duration(days: 100)),
                  maximumDate: DateTime.now().add(
                    Duration(days: 100),
                  ),
                  onDateTimeChanged: (value) {
                    _selected = value;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
