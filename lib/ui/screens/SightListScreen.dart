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
      appBar: MyCustomAppBar(
        title: Text(
          "Список интересных мест",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            fontSize: 32,
            color: Color(0xFF252849),
          ),
        ),
        height: 152,
        backgroundColor: Colors.transparent,
      ),
      // AppBar(
      //   backgroundColor: Colors.transparent,
      //   centerTitle: false,
      //   toolbarHeight: 120,
      //   shadowColor: Colors.transparent,
        // title: Text(
        //   "Список\nинтересных мест",
        //   style: TextStyle(
        //     fontFamily: "Roboto",
        //     fontWeight: FontWeight.w700,
        //     fontSize: 32,
        //     color: Color(0xFF252849),
        //   ),
        // ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: mocks.map((e) => Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: SightCard(
                sight: e,
              ),
          )).toList(),
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
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: _onTap,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/img/list.svg'),
                activeIcon: SvgPicture.asset('assets/img/list_full.svg'),
                title: Text('List Places'),
                // label: '',
              ),
              // BottomNavigationBarItem(
              //   icon: SvgPicture.asset('assets/img/map.svg'),
              //   activeIcon: SvgPicture.asset('assets/img/map_full.svg'),
              //   label: '',
              // ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/img/heart_icon.svg'),
                activeIcon: SvgPicture.asset("assets/img/heart_full.svg"),
                title: Text('Favorites'),
                // label: '',
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
