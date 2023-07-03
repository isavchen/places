import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/filter.dart';
import 'package:places/redux/action/place_search_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/place_search_state.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/widget/search_field.dart';

class SightSearchScreen extends StatefulWidget {
  final Filter filter;
  const SightSearchScreen({Key? key, required this.filter}) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchTextController.addListener(
      () {
        if (searchTextController.text.isEmpty)
          StoreProvider.of<AppState>(context)
              .dispatch(LoadSearchHistoryAction());
        else if (searchTextController.text.trim().isNotEmpty &&
            searchTextController.text.split("").last == " ") {
          StoreProvider.of<AppState>(context).dispatch(
            FindPlaceAction(
              request: searchTextController.text.trim(),
            ),
          );
        }
      },
    );
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
            child: SearchField(
              controller: searchTextController,
              onSubmitted: (value) {
                StoreProvider.of<AppState>(context).dispatch(
                  FindPlaceAction(
                    request: searchTextController.text.trim(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: StoreConnector<AppState, SearchPlaceState>(
          onInit: (store) {
            store.dispatch(ShowSearchHistoryAction(queries: []));
          },
          converter: (store) {
            return store.state.searchPlaceState;
          },
          builder: (BuildContext context, SearchPlaceState vm) {
            if (vm is SearchPlaceLoadingState) {
              return _LoadingSearchPlace();
            } else if (vm is SearchPlaceDataState) {
              return vm.places.isEmpty
                  ? _EmptyResultSearchPlace()
                  : _ResultListSearchPlace(
                      places: vm.places,
                      request: searchTextController.text.trim(),
                    );
            } else if (vm is SearchPlaceHistoryState) {
              return _SearchHistory(
                queries: vm.queries,
                searchTextController: searchTextController,
              );
            }

            throw ArgumentError('No view for state: $vm');
          },
        ),
      ),
    );
  }
}

class _LoadingSearchPlace extends StatelessWidget {
  const _LoadingSearchPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Platform.isIOS
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
      ),
    );
  }
}

class _EmptyResultSearchPlace extends StatelessWidget {
  const _EmptyResultSearchPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class _ResultListSearchPlace extends StatelessWidget {
  final String request;
  final List<Place> places;
  const _ResultListSearchPlace(
      {Key? key, required this.places, required this.request})
      : super(key: key);

  List<TextSpan> highlightOccurrences(
      String source, String query, ThemeData themeData) {
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
        style: themeData.primaryTextTheme.titleMedium?.copyWith(
          color: themeData.colorScheme.secondary,
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
    return ListView(
      physics:
          Platform.isIOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
      children: [
        SizedBox(height: 32.0),
        for (final place in places)
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SightDetailsScreen(
                        sightId: place.id,
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
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        place.urls.first,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  )
                                : CupertinoActivityIndicator.partiallyRevealed(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    progress: loadingProgress
                                                .expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : 0,
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      children: highlightOccurrences(
                        place.name,
                        request.trim(),
                        Theme.of(context),
                      ),
                      style: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  subtitle: Text(
                    "plase.type.${place.placeType}".tr(),
                    style: lmMatBodyText2,
                  ),
                ),
              ),
              if (places.last != place)
                Padding(
                  padding: const EdgeInsets.only(left: 88.0, right: 16.0),
                  child: Divider(),
                ),
            ],
          ),
      ],
    );
  }
}

class _SearchHistory extends StatelessWidget {
  final List<String> queries;
  final TextEditingController searchTextController;
  const _SearchHistory(
      {Key? key, required this.queries, required this.searchTextController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics:
          Platform.isIOS ? BouncingScrollPhysics() : ClampingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 32.0, bottom: 4.0),
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
        for (String query in queries.reversed)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          searchTextController.text = query;
                          searchTextController.selection =
                              TextSelection.collapsed(
                                  offset: searchTextController.text.length);
                          StoreProvider.of<AppState>(context).dispatch(
                            FindPlaceAction(
                              request: searchTextController.text.trim(),
                            ),
                          );
                        },
                        child: Text(
                          query,
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
                        StoreProvider.of<AppState>(context).dispatch(
                          RemoveQueryFromHistoryAction(query),
                        );
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: lmInactiveColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (queries.elementAt(0) != query)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
            ],
          ),
        if (queries.isNotEmpty)
          TextButton(
            onPressed: () {
              StoreProvider.of<AppState>(context).dispatch(
                ClearSearchHistoryAction(),
              );
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('sight_search.clear_history'.tr()),
            ),
          ),
      ],
    );
  }
}