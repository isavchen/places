import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widget/my_custom_appbar.dart';
import 'package:places/ui/widget/sight_card.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  int _currentIndex = 0;

  void _onTap(currentIndex) {
    setState(() {
      _currentIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
       MyCustomAppBar(
        title: Text(
          "Список интересных мест",
        ),
        height: 152,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (final mock in mocks)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: SightCard(sight: mock),
              ),
          ],
        ),
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
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/img/list.svg',
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedItemColor,
              ),
              activeIcon: SvgPicture.asset('assets/img/list_full.svg',
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor),
              title: Text('List Places'),
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset('assets/img/map.svg'),
            //   activeIcon: SvgPicture.asset('assets/img/map_full.svg'),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/img/heart_icon.svg',
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor),
              activeIcon: SvgPicture.asset("assets/img/heart_full.svg",
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedItemColor),
              title: Text('Favorites'),
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset('assets/img/settings.svg'),
            //   activeIcon: SvgPicture.asset('assets/img/settings_full.svg', color: Color(0xFF252849),),
            //   label: '',
            // ),
          ],
        ),
      ),
    );
  }
}
