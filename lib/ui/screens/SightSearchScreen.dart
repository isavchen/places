import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/location.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/SightDetailsScreen.dart';
import 'package:places/ui/utils/location_utils.dart';
import 'package:places/ui/widget/search_bar.dart';

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  TextEditingController searchTextController = TextEditingController();
  Location myLocation = Location(lat: 50.414855, lng: 30.531350);
  List<String> bufferSearchList = ["Булочки", "Пицца"];
  List searchResoult = [];
  double radius = 8;
  bool _showResoultList = false;
  bool _errorState = false;
  bool _isLoading = false;

  void searchInMocks() {
    setState(() {
      _isLoading = true;
    });
    imitationLoading();
    for (final mock in mocks) {
      if (mock.name
              .toLowerCase()
              .contains(searchTextController.text.trim().toLowerCase()) &&
          isPointsNear(
            Location(lat: mock.lat, lng: mock.lon),
            myLocation,
            radius,
          )) {
        searchResoult.add(mock);
      }
    }
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

  imitationLoading() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    searchTextController.addListener(() {
      if (searchTextController.text.isEmpty)
        setState(() {
          searchResoult.clear();
          _showResoultList = false;
        });
      else if (searchTextController.text.trim().isNotEmpty &&
          searchTextController.text.split("").last == " ") {
        setState(() {
          searchResoult.clear();
          _showResoultList = true;
        });
        searchInMocks();
      }
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'sight_search.title'.tr(),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: SearchBar(
              controller: searchTextController,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  setState(() {
                    if (bufferSearchList.contains(value.trim())) {
                      bufferSearchList.remove(value.trim());
                      bufferSearchList.add(value.trim());
                    } else {
                      bufferSearchList.add(value.trim());
                    }
                    _showResoultList = true;
                  });
                  searchResoult.clear();
                  searchInMocks();
                }
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // лоадер пока идет загрузка запроса

          if (_isLoading)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(),
              ),
            ),

          // история поиска

          if (!_showResoultList)
            Expanded(
              child: Container(
                child: ListView(
                  physics: Platform.isIOS
                      ? BouncingScrollPhysics()
                      : ClampingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 32.0, bottom: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'sight_search.history'.tr(),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .caption
                              ?.copyWith(color: lmInactiveColor),
                        ),
                      ),
                    ),
                    for (String item in bufferSearchList.reversed)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 15.0, 16.0, 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      searchTextController.text = item;
                                    },
                                    child: Text(
                                      item,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .subtitle1
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: lmSecondaryColor2,
                                          ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      bufferSearchList.remove(item);
                                    });
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: lmInactiveColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (bufferSearchList.elementAt(0) != item)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(),
                            ),
                        ],
                      ),
                    if (bufferSearchList.isNotEmpty && !_showResoultList)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            bufferSearchList.clear();
                          });
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('sight_search.clear_history'.tr()),
                        ),
                      ),
                  ],
                ),
              ),
            ),

          // когда состояние поиска не пустое, показать контент поиска

          if (_showResoultList && searchResoult.isNotEmpty && !_isLoading)
            Expanded(
              child: Container(
                child: ListView(
                  physics: Platform.isIOS
                      ? BouncingScrollPhysics()
                      : ClampingScrollPhysics(),
                  children: [
                    SizedBox(height: 32.0),
                    for (final res in searchResoult)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SightDetailsScreen(
                                    sightId: res.id,
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  res.url,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: Platform.isAndroid
                                          ? CircularProgressIndicator(
                                              color: Color(0xFF252849),
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            )
                                          : CupertinoActivityIndicator
                                              .partiallyRevealed(
                                              progress: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : 0,
                                            ),
                                    );
                                  },
                                ),
                              ),
                              title: RichText(
                                text: TextSpan(
                                  children: highlightOccurrences(res.name,
                                      searchTextController.text.trim()),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle1
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              subtitle: Text(
                                res.type,
                                style: lmMatBodyText2,
                              ),
                            ),
                          ),
                          if (searchResoult.last != res)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 88.0, right: 16.0),
                              child: Divider(),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),

          // пустое состояние поиска
          if (_showResoultList && searchResoult.isEmpty && !_isLoading)
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: SvgPicture.asset(icSearch, height: 48.0)),
                    SizedBox(
                      height: 32.0,
                    ),
                    Center(
                      child: Text(
                        'sight_search.empty'.tr(),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline6
                            ?.copyWith(color: lmInactiveColor),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 253.5),
                        child: Text(
                          'sight_search.change_query'.tr(),
                          textAlign: TextAlign.center,
                          style: dmMatBodyText2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // ошибка загрузки запроса
          if (_errorState) Text("Error State"),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: Color(0xFF7C7E92).withOpacity(0.56), width: 0.8),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icList,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              activeIcon: SvgPicture.asset(
                icListFull,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
              ),
              title: Text('List Places'),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icHeart,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              activeIcon: SvgPicture.asset(
                icHeartFull,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
              ),
              title: Text('Favorites'),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icSettings,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              activeIcon: SvgPicture.asset(
                icSettingsFull,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
              ),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
