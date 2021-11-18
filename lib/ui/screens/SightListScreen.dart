import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/AddSightScreen.dart';
import 'package:places/ui/screens/FiltersScreen.dart';
import 'package:places/ui/screens/SightSearchScreen.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/search_bar.dart';
import 'package:places/ui/widget/sight_card.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  ScrollController _scrollController = ScrollController();
  late Text _title = Text(
    'sight_list.title.expanded'.tr(),
    style: Theme.of(context)
        .primaryTextTheme
        .headline6!
        .copyWith(fontWeight: FontWeight.w700, fontSize: 32),
  );

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _title = !_isSliverAppBarExpanded
              ? Text(
                  'sight_list.title.expanded'.tr(),
                  style: Theme.of(context).primaryTextTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                )
              : Text('sight_list.title.normal'.tr());
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients && (_scrollController.offset > 150);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverscrollGlowAbsorber(
        child: CustomScrollView(
          controller: _scrollController,
          physics: Platform.isIOS
              ? BouncingScrollPhysics()
              : ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 186,
              elevation: 0,
              pinned: true,
              centerTitle: true,
              title: _isSliverAppBarExpanded ? _title : Container(),
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: _isSliverAppBarExpanded ? 0.0 : 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 46.0),
                      !_isSliverAppBarExpanded ? _title : Container(),
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
                                            SightSearchScreen(),
                                  ),
                                );
                              },
                              child: SearchBar(
                                enabled: false,
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 15,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => FiltersScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SvgPicture.asset(
                                      icFilter,
                                      color: Theme.of(context).colorScheme.surface,
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: index == 0
                        ? const EdgeInsets.all(16.0)
                        : const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: SightCard(sight: mocks[index]),
                  );
                },
                childCount: mocks.length,
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
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddSightScreen()),
            );
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
    );
  }
}
