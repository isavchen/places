import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/bloc/place_list_screen/place_list_screen_bloc.dart';
import 'package:places/domain/filter.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/add_sight_screen.dart';
import 'package:places/ui/screens/error_placeholder_screen.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/sight_search_screen.dart';
import 'package:places/ui/widget/gradient_progress_indicator.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/search_field.dart';
import 'package:places/ui/widget/sight_card.dart';

class SightListScreen extends StatefulWidget {
  final Filter? filter;

  const SightListScreen({Key? key, this.filter}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  ScrollController _scrollController = ScrollController();
  StreamController<Widget> _titleStreamController = StreamController<Widget>();

  //TODO: move this parameter to search interactor e.g
  //TODO add radius and userLocation when geolocation will be conected
  Filter filter = Filter(
    // userLocation: Location(lat: 50.413475, lng: 30.525177),
    // radius: 10000,
    categoryType: {
      CategoryType.temple: true,
      CategoryType.monument: true,
      CategoryType.park: true,
      CategoryType.theatre: true,
      CategoryType.museum: true,
      CategoryType.hotel: true,
      CategoryType.restaurant: true,
      CategoryType.cafe: true,
      CategoryType.other: true,
    },
  );

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        _titleStreamController.sink.add(!_isSliverAppBarExpanded
            ? _getTitle(MediaQuery.orientationOf(context))
            : Text(
                'sight_list.title.normal'.tr(),
                style: Theme.of(context).primaryTextTheme.titleLarge!,
              ));
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _titleStreamController.close();
    super.dispose();
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        (_scrollController.offset > (_isPortraitOrientation ? 130 : 85));
  }

  bool get _isPortraitOrientation {
    return MediaQuery.orientationOf(context) == Orientation.portrait;
  }

  Text _getTitle(Orientation orientation) {
    switch (orientation) {
      case Orientation.landscape:
        return Text(
          'sight_list.title.normal'.tr(),
          style: Theme.of(context).primaryTextTheme.titleLarge!,
        );
      default:
        return Text(
          'sight_list.title.expanded'.tr(),
          style: Theme.of(context)
              .primaryTextTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w700, fontSize: 32),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OverscrollGlowAbsorber(
          child: CustomScrollView(
            controller: _scrollController,
            physics: Platform.isIOS
                ? BouncingScrollPhysics()
                : ClampingScrollPhysics(),
            slivers: [
              // TODO: replace SliverAppBar with SliverPersistentHeaderDelegate
              // for auto collapsing app bar
              SliverAppBar(
                expandedHeight: _isPortraitOrientation ? 184 : 140,
                elevation: 0,
                pinned: true,
                centerTitle: true,
                title: StreamBuilder(
                  stream: _titleStreamController.stream,
                  initialData: Container(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _isSliverAppBarExpanded
                          ? snapshot.data as Widget
                          : Container();
                    } else {
                      return _getTitle(MediaQuery.orientationOf(context));
                    }
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getTitle(MediaQuery.orientationOf(context)),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              SightSearchScreen(
                                        filter: filter,
                                      ),
                                    ),
                                  );
                                },
                                child: SearchField(
                                  enabled: false,
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 8,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () async {
                                      final searchFilter =
                                          await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => FiltersScreen(
                                            filter: filter,
                                          ),
                                        ),
                                      );
                                      if (searchFilter != null) {
                                        setState(() {
                                          filter = searchFilter;
                                        });
                                        // getFilteredPlaces(searchFilter);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12.0),
                                      child: SvgPicture.asset(
                                        icFilter,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<PlaceListScreenBloc, PlaceListScreenState>(
                builder: (_, state) {
                  if (state is PlaceListScreenLoadingState) {
                    return SliverFillRemaining(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            child: Center(
                              child: Container(
                                width: 40,
                                height: 40,
                                child: GradientProgressIndicator(
                                  progress: 0.8,
                                  strokeWidth: 6.0,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .background,
                                  gradient: SweepGradient(
                                    colors: [
                                      Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                      Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is PlaceListScreenErrorState) {
                    return SliverFillRemaining(
                      child: ErrorPlaceholderScreen(),
                    );
                  } else if (state is PlaceListScreenSuccessState) {
                    return _isPortraitOrientation
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 0, 16.0, 16.0),
                                child: SightCard(
                                  sight: state.places[index],
                                ),
                              ),
                              childCount: state.places.length,
                            ),
                          )
                        : SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 0, 16.0, 16.0),
                                  child: SightCard(
                                    sight: state.places[index],
                                  ),
                                );
                              },
                              childCount: state.places.length,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 36.0,
                              childAspectRatio: 30 / 19,
                            ),
                          );
                  }
                  throw ArgumentError(
                      "Wrong state in SightListScreen as ${_isPortraitOrientation ? 'Portrait' : 'Landscape'} Orientation");
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Theme.of(context).canvasColor,
                Theme.of(context).colorScheme.surface,
              ],
            ),
          ),
          child: FloatingActionButton.extended(
            elevation: 0,
            highlightElevation: 0,
            backgroundColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () async {
              final newSight = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddSightScreen()),
              );
              if (newSight != null) {
                await showDialog(
                  context: context,
                  builder: (_) => Platform.isIOS
                      ? CupertinoAlertDialog(
                          title: Text(
                            'add_sight.sight_created_dialog.title'.tr(),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text(
                                'add_sight.sight_created_dialog.button.title'
                                    .tr(),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        )
                      : AlertDialog(
                          title: Text(
                            'add_sight.sight_created_dialog.title'.tr(),
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                'add_sight.sight_created_dialog.button.title'
                                    .tr(),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                );
                // getFilteredPlaces(widget.filter ?? filter);
              }
            },
            label: Container(
              child: Text(
                'sight_list.new_sight'.tr(),
                style: textButton,
              ),
            ),
            icon: Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
