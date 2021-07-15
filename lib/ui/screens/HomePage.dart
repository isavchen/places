import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/screens/SettingsScreen.dart';
import 'package:places/ui/screens/SightListScreen.dart';
import 'package:places/ui/screens/VisitingScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final widgetOptions = [
    SightListScreen(),
    VisitingScreen(),
    SettingsScreen(),
  ];

  void _onTap(currentIndex) {
    setState(() {
      _currentIndex = currentIndex;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: Color(0xFF7C7E92).withOpacity(0.56), width: 0.8),
          ),
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
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     'assets/img/map.svg',
            //     color: Theme.of(context)
            //         .bottomNavigationBarTheme
            //         .unselectedItemColor,
            //   ),
            //   activeIcon: SvgPicture.asset(
            //     'assets/img/map_full.svg',
            //     color: Theme.of(context)
            //         .bottomNavigationBarTheme
            //         .selectedItemColor,
            //   ),
            //   title: Text('Map'),
            // ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/img/heart_icon.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              activeIcon: SvgPicture.asset(
                "assets/img/heart_full.svg",
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
              ),
              title: Text('Favorites'),
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
    );
  }
}
