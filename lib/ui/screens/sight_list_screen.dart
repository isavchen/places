import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/add_sight_screen.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/sight_search_screen.dart';
import 'package:places/ui/utils/filtration_utils.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/search_bar.dart';
import 'package:places/ui/widget/sight_card.dart';

class SightListScreen extends StatefulWidget {
  final Filter? filter;

  const SightListScreen({Key? key, this.filter}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  ScrollController _scrollController = ScrollController();
  Location myLocation = Location(lat: 50.413475, lng: 30.525177);
  List<Sight> listSights = mocks;
  Filter filter = Filter(
    radius: 10000,
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
  late var _title;

  @override
  void initState() {
    if (widget.filter != null) {
      setState(() {
        filter = widget.filter!;
        listSights = filtrationPlace(
          filter: filter,
          incomingList: mocks,
          location: myLocation,
        );
      });
    }
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _title = !_isSliverAppBarExpanded
              ? _getTitle(MediaQuery.of(context).orientation)
              : Text('sight_list.title.normal'.tr());
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        (_scrollController.offset > (_isPortraitOrientation ? 140 : 80));
  }

  bool get _isPortraitOrientation {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  Text _getTitle(Orientation orientation) {
    switch (orientation) {
      case Orientation.landscape:
        return Text(
          'sight_list.title.normal'.tr(),
          style: Theme.of(context).primaryTextTheme.headline6!,
        );
      default:
        return Text(
          'sight_list.title.expanded'.tr(),
          style: Theme.of(context)
              .primaryTextTheme
              .headline6!
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
              SliverAppBar(
                expandedHeight: _isPortraitOrientation ? 184 : 140,
                elevation: 0,
                pinned: true,
                centerTitle: true,
                title: _isSliverAppBarExpanded
                    ? _title == null
                        ? _getTitle(MediaQuery.of(context).orientation)
                        : _title
                    : Container(),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _isSliverAppBarExpanded ? 0.0 : 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        !_isSliverAppBarExpanded
                            ? _getTitle(MediaQuery.of(context).orientation)
                            : Container(),
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
                                child: SearchBar(
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
                                          listSights = filtrationPlace(
                                            filter: filter,
                                            incomingList: mocks,
                                            location: myLocation,
                                          );
                                        });
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
              _isPortraitOrientation
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                            child: SightCard(sight: listSights[index]),
                          );
                        },
                        childCount: listSights.length,
                      ),
                    )
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                            child: SightCard(sight: listSights[index]),
                          );
                        },
                        childCount: listSights.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 36.0,
                        childAspectRatio: 30 / 19,
                      ),
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
                setState(() {
                  listSights = filtrationPlace(
                    filter: filter,
                    incomingList: mocks,
                    location: myLocation,
                  );
                });
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
