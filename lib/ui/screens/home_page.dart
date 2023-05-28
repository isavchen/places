import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/screens/settings_screen.dart';
import 'package:places/ui/screens/sight_list_screen.dart';
import 'package:places/ui/screens/visiting_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final widgetOptions = [
    const SightListScreen(),
    const VisitingScreen(),
    const SettingsScreen(),
  ];

  void _onTap(index) {
    if (_currentIndex != index)
      setState(() {
        _currentIndex = index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: widgetOptions,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: Color(0xFF7C7E92).withOpacity(0.56), width: 0.8),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icList,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              activeIcon: SvgPicture.asset(
                icListFull,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
              ),
              label: 'List Places',
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     icMap,
            //     color: Theme.of(context)
            //         .bottomNavigationBarTheme
            //         .unselectedItemColor,
            //   ),
            //   activeIcon: SvgPicture.asset(
            //     icMapFull,
            //     color: Theme.of(context)
            //         .bottomNavigationBarTheme
            //         .selectedItemColor,
            //   ),
            //   label: 'Map',
            // ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icHeart,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              activeIcon: SvgPicture.asset(
                icHeartFull,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                icSettings,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              activeIcon: SvgPicture.asset(
                icSettingsFull,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
