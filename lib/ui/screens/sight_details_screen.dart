import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/bloc/visiting_screen/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/bloc/visiting_screen/want_to_visit/want_to_visit_event.dart';
import 'package:places/bloc/visiting_screen/want_to_visit/want_to_visit_state.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/page_indicator.dart';

class SightDetailsScreen extends StatefulWidget {
  final Place place;
  final bool isBottomSheet;
  const SightDetailsScreen(
      {Key? key, this.isBottomSheet = false, required this.place})
      : super(key: key);

  @override
  _SightDetailsScreenState createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _currentPageNotifier.value = _pageController.page?.round() ?? 0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverscrollGlowAbsorber(
        child: SafeArea(
          child: CustomScrollView(
            physics: Platform.isIOS
                ? BouncingScrollPhysics()
                : ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: MediaQuery.sizeOf(context).height * 0.5,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Hero(
                        tag: widget.place.id,
                        child: Container(
                          width: double.infinity,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: widget.place.urls.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                widget.place.urls[index],
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
                              );
                            },
                          ),
                        ),
                      ),
                      widget.isBottomSheet
                          ? Positioned(
                              top: 16,
                              right: 16,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                    size: 24,
                                  ),
                                ),
                              ),
                            )
                          : Positioned(
                              top: 16,
                              left: 16,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                      if (widget.isBottomSheet)
                        Positioned(
                          top: 12.0,
                          left: MediaQuery.sizeOf(context).width / 2 - 20,
                          child: Container(
                            height: 4.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 0.0,
                        child: ValueListenableBuilder<int>(
                          valueListenable: _currentPageNotifier,
                          builder: (context, value, child) => PageIndicator(
                            width: MediaQuery.sizeOf(context).width /
                                widget.place.urls.length,
                            currentIndex: value,
                            itemCount: widget.place.urls.length,
                            selectedColor: Theme.of(context).focusColor,
                            normalColor: Colors.transparent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.place.name,
                        style: Theme.of(context).primaryTextTheme.headlineSmall,
                      ),
                      Row(
                        children: [
                          Text(
                            'plase.type.${widget.place.placeType}'.tr(),
                            style:
                                Theme.of(context).primaryTextTheme.titleSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "закрыто до 09:00",
                              style:
                                  Theme.of(context).primaryTextTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        widget.place.description,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).focusColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: ElevatedButton(
                          onPressed: () {
                            //TODO: функционал кнопки "Построить маршрут"
                            print("Кнопка Построить  маршрут нажата");
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(icRoute),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('sight_details.route'.tr()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 0.8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  //TODO: функционал кнопки "Запланировать"
                                  print("Кнопка Запланировать");
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        icCalendar,
                                        width: 22,
                                        color: dmInactiveColor,
                                      ),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Text(
                                        'sight_details.schedule'.tr(),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyMedium,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<WantToVisitBloc>()
                                      .add(WantToVisitUpdateList(widget.place));
                                },
                                child: BlocBuilder<WantToVisitBloc,
                                    WantToVisitState>(
                                  builder: (context, state) {
                                    if (state
                                        is WantToVisitListUpdatedSuccess) {
                                      bool isFavoutitePlace = state.places.any(
                                          (element) =>
                                              element.id == widget.place.id);
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              isFavoutitePlace
                                                  ? icHeartFull
                                                  : icHeart,
                                              width: 20,
                                              color:
                                                  Theme.of(context).focusColor,
                                            ),
                                            SizedBox(
                                              width: 9,
                                            ),
                                            Text(
                                              'sight_details.to_favorite'.tr(),
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .focusColor),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    throw ArgumentError(
                                        'Wrong state in SightDetailsScreen');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
