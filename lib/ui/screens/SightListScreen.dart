import 'dart:io';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyCustomAppBar(
      //   title: Text(
      //     "Список интересных мест",
      //   ),
      //   height: 152,
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Список интересных мест",
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //       builder: (context) => SightSearchScreen()),
                      // );
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            SightSearchScreen(),
                        transitionDuration: Duration(seconds: 0),
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
                              builder: (context) => FiltersScreen()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(
                          icFilter,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          OverscrollGlowAbsorber(
            child: ListView.builder(
              physics: Platform.isIOS
                  ? BouncingScrollPhysics()
                  : ClampingScrollPhysics(),
              itemCount: mocks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: index == 0
                      ? const EdgeInsets.all(16.0)
                      : const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                  child: SightCard(sight: mocks[index]),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddSightScreen()),
                  );
                },
                child: Container(
                  width: 177.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Theme.of(context).canvasColor,
                        Theme.of(context).buttonColor,
                      ],
                    ),
                    // color: Colors.green,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 22.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                      ),
                      // SizedBox(width: 13),
                      Text(
                        "НОВОЕ МЕСТО",
                        style: textButton,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
