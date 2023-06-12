import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/filter.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/widget/search_field.dart';
import 'package:provider/provider.dart';

class SightSearchScreen extends StatefulWidget {
  final Filter filter;
  const SightSearchScreen({Key? key, required this.filter}) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  TextEditingController searchTextController = TextEditingController();
  List<Place> searchResoult = [];

  bool _showResoultList = false;
  bool _errorState = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    searchTextController.addListener(() {
      if (searchTextController.text.isEmpty)
        setState(() {
          _showResoultList = false;
        });
      else if (searchTextController.text.trim().isNotEmpty &&
          searchTextController.text.split("").last == " ") {
        _searchPlace();
      }
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  Future<void> _searchPlace() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<SearchInteractor>(context, listen: false)
        .searchPlaces(namePlace: searchTextController.text.trim());
    setState(() {
      _isLoading = false;
      _showResoultList = true;
    });
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
        style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(
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
            child: SearchField(
              controller: searchTextController,
              onSubmitted: (value) {
                _searchPlace();
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<SearchInteractor>(
          builder: (context, searchInteractor, child) {
            return Column(
              children: [
                // лоадер пока идет загрузка запроса
                if (_isLoading)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Platform.isIOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                    ),
                  ),

                // история поиска

                if (!_showResoultList && !_isLoading)
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
                                  .bodySmall
                                  ?.copyWith(color: lmInactiveColor),
                            ),
                          ),
                        ),
                        for (String item
                            in searchInteractor.getSeatchHistory.reversed)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 15.0, 16.0, 13.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          searchTextController.text = item;
                                          searchTextController.selection =
                                              TextSelection.collapsed(
                                                  offset: searchTextController
                                                      .text.length);
                                          _searchPlace();
                                        },
                                        child: Text(
                                          item,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: lmSecondaryColor2,
                                              ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        searchInteractor
                                            .removeFromSearchHistory(item);
                                      },
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: lmInactiveColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (searchInteractor.getSeatchHistory
                                      .elementAt(0) !=
                                  item)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Divider(),
                                ),
                            ],
                          ),
                        if (searchInteractor.getSeatchHistory.isNotEmpty &&
                            !_showResoultList)
                          TextButton(
                            onPressed: () {
                              searchInteractor.clearSearchHistory();
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('sight_search.clear_history'.tr()),
                            ),
                          ),
                      ],
                    )),
                  ),

                // когда состояние поиска не пустое, показать контент поиска

                if (_showResoultList &&
                    searchInteractor.getSearchResult.isNotEmpty &&
                    !_isLoading)
                  Expanded(
                    child: Container(
                      child: ListView(
                        physics: Platform.isIOS
                            ? BouncingScrollPhysics()
                            : ClampingScrollPhysics(),
                        children: [
                          SizedBox(height: 32.0),
                          for (final res in searchInteractor.getSearchResult)
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SightDetailsScreen(
                                          sightId: res.id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    dense: false,
                                    leading: SizedBox(
                                      width: 56,
                                      height: 56,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: Image.network(
                                          res.urls.first,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: Platform.isAndroid
                                                  ? CircularProgressIndicator(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
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
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
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
                                    ),
                                    title: RichText(
                                      text: TextSpan(
                                        children: highlightOccurrences(res.name,
                                            searchTextController.text.trim()),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      "plase.type.${res.placeType}".tr(),
                                      style: lmMatBodyText2,
                                    ),
                                  ),
                                ),
                                if (searchInteractor.getSearchResult.last !=
                                    res)
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
                if (_showResoultList &&
                    searchInteractor.getSearchResult.isEmpty &&
                    !_isLoading)
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: SvgPicture.asset(icSearch, height: 48.0)),
                          SizedBox(
                            height: 32.0,
                          ),
                          Center(
                            child: Text(
                              'sight_search.empty'.tr(),
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleLarge
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
            );
          },
        ),
      ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     border: Border(
      //       top: BorderSide(
      //           color: Color(0xFF7C7E92).withOpacity(0.56), width: 0.8),
      //     ),
      //   ),
      //   child: BottomNavigationBar(
      //     currentIndex: 0,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: SvgPicture.asset(
      //           icList,
      //           color: Theme.of(context)
      //               .bottomNavigationBarTheme
      //               .unselectedItemColor,
      //         ),
      //         activeIcon: SvgPicture.asset(
      //           icListFull,
      //           color: Theme.of(context)
      //               .bottomNavigationBarTheme
      //               .selectedItemColor,
      //         ),
      //         label: 'List Places',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: SvgPicture.asset(
      //           icHeart,
      //           color: Theme.of(context)
      //               .bottomNavigationBarTheme
      //               .unselectedItemColor,
      //         ),
      //         activeIcon: SvgPicture.asset(
      //           icHeartFull,
      //           color: Theme.of(context)
      //               .bottomNavigationBarTheme
      //               .selectedItemColor,
      //         ),
      //         label: 'Favorites',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: SvgPicture.asset(
      //           icSettings,
      //           color: Theme.of(context)
      //               .bottomNavigationBarTheme
      //               .unselectedItemColor,
      //         ),
      //         activeIcon: SvgPicture.asset(
      //           icSettingsFull,
      //           color: Theme.of(context)
      //               .bottomNavigationBarTheme
      //               .selectedItemColor,
      //         ),
      //         label: 'Settings',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
