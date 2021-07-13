import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/widget/visiting_content.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  int _currentIndex = 2;

  void _onTap(currentIndex) {
    setState(() {
      _currentIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Избранное",
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          toolbarHeight: 140,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(52.0),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: TabBar(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      tabs: [
                        Tab(
                          text: "Хочу посетить",
                        ),
                        Tab(
                          text: "Посетил",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          child: TabBarView(
            children: [
              VisitingContent(
                content: 1,
              ),
              VisitingContent(
                content: 2,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Color(0xFF7C7E92).withOpacity(0.56), width: 0.8)),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTap,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/img/list.svg',
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/img/list_full.svg',
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor,
                ),
                title: Text('List Places'),
                // label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/img/map.svg',
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/img/map_full.svg',
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor,
                ),
                title: Text('Map'),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/img/heart_icon.svg',
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedItemColor),
                activeIcon: SvgPicture.asset(
                  "assets/img/heart_full.svg",
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor,
                ),
                title: Text('Favorites'),
                // label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/img/settings.svg',
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/img/settings_full.svg',
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor,
                ),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
