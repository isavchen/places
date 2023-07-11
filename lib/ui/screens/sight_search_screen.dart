import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/bloc/place_search_screen/place_search_screen_bloc.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/domain/filter.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/error_placeholder_screen.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/utils/highlight_occurrences.dart';
import 'package:places/ui/widget/search_field.dart';

class SightSearchScreen extends StatefulWidget {
  final Filter filter;
  const SightSearchScreen({Key? key, required this.filter}) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  TextEditingController searchTextController = TextEditingController();
  late PlaceSearchScreenBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = PlaceSearchScreenBloc(context.read<SearchInteractor>());
    searchTextController.addListener(
      () {
        if (searchTextController.text.isEmpty)
          _searchBloc.add(
            LoadSearchHistoryEvent(),
          );
        else if (searchTextController.text.trim().isNotEmpty &&
            searchTextController.text.split("").last == " ") {
          _searchBloc.add(
            FindPlaceByRequestEvent(request: searchTextController.text.trim()),
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
                _searchBloc.add(
                  FindPlaceByRequestEvent(request: value.trim()),
                );
              },
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<PlaceSearchScreenBloc, PlaceSearchScreenState>(
          bloc: _searchBloc,
          builder: (context, state) {
            if (state is PlaceSearchLoadingState) {
              // лоадер пока идет загрузка запроса
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
            } else if (state is PlaceSearchErrorState) {
              return Center(
                child: ErrorPlaceholderScreen(),
              );
            } else if (state is PlaceSearchLoadHistoryState) {
              // история поиска
              return ListView(
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
                  for (String item in state.queries.reversed)
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

                                    _searchBloc.add(
                                      FindPlaceByRequestEvent(
                                        request: item.trim(),
                                      ),
                                    );
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
                                  _searchBloc.add(
                                    RemoveQueryFromHistoryEvent(
                                        query: item),
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
                        if (state.queries.elementAt(0) != item)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0),
                            child: Divider(),
                          ),
                      ],
                    ),
                  if (state.queries.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        _searchBloc.add(ClearSearchHistory());
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('sight_search.clear_history'.tr()),
                      ),
                    ),
                ],
              );
            } else if (state is PlaceSearchLoadResultState) {
              // контент поиска
              return ListView(
                physics: Platform.isIOS
                    ? BouncingScrollPhysics()
                    : ClampingScrollPhysics(),
                children: [
                  SizedBox(height: 32.0),
                  for (final res in state.places)
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
                            dense: false,
                            leading: SizedBox(
                              width: 56,
                              height: 56,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  res.urls.first,
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
                                children: highlightOccurrences(
                                  res.name,
                                  searchTextController.text.trim(),
                                  Theme.of(context),
                                ),
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
                        if (state.places.last != res)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 88.0, right: 16.0),
                            child: Divider(),
                          ),
                      ],
                    ),
                ],
              );
            } else if (state is PlaceSearcLoadResultEmptyState) {
              // пустое состояние поиска
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
            throw ArgumentError('Wrong state in SightSearchScreen');
          },
        ),
      ),
    );
  }
}
