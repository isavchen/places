import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/widget/overscroll_glow_absorber.dart';
import 'package:places/ui/widget/page_indicator.dart';

class SightDetailsScreen extends StatefulWidget {
  final int sightId;
  const SightDetailsScreen({Key? key, required this.sightId}) : super(key: key);

  @override
  _SightDetailsScreenState createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  PageController _pageController = PageController();

  void _pageChanged(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Sight sight = mocks.where((element) => element.id == widget.sightId).first;
    final List<String> gallery = sight.galery;
    return Scaffold(
      body: OverscrollGlowAbsorber(
        child: CustomScrollView(
          physics: Platform.isIOS
              ? BouncingScrollPhysics()
              : ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: _pageChanged,
                        itemCount: gallery.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            gallery[index],
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
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 36,
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
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: PageIndicator(
                        width:
                            MediaQuery.of(context).size.width / gallery.length,
                        controller: _pageController,
                        itemCount: gallery.length,
                        selectedColor: Theme.of(context).focusColor,
                        normalColor: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        sight.name,
                        style: Theme.of(context).primaryTextTheme.headline5,
                      ),
                      Row(
                        children: [
                          Text(
                            sight.type,
                            style: Theme.of(context).primaryTextTheme.subtitle2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              "?????????????? ???? 09:00",
                              style: Theme.of(context).primaryTextTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        sight.details,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2
                            ?.copyWith(color: Theme.of(context).focusColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: ElevatedButton(
                          onPressed: () {
                            //TODO: ???????????????????? ???????????? "?????????????????? ??????????????"
                            print("???????????? ??????????????????  ?????????????? ????????????");
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
                                  //TODO: ???????????????????? ???????????? "??????????????????????????"
                                  print("???????????? ??????????????????????????");
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
                                            .bodyText2,
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
                                  //TODO: ???????????????????? ???????????? "???????????????? ?? ??????????????????"
                                  print("???????????? ?? ??????????????????");
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        icHeart,
                                        width: 20,
                                        color: Theme.of(context).focusColor,
                                      ),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      Text(
                                        'sight_details.to_favorite'.tr(),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyText2
                                            ?.copyWith(
                                                color:
                                                    Theme.of(context).focusColor),
                                      )
                                    ],
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
