import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/widget/visiting_content.dart';
import 'package:places/ui/screens/SightListScreen.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  int _currentIndex = 1;

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
            style: TextStyle(
                color: Color(0xFF252849),
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 18),
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
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: TabBar(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      unselectedLabelColor: Color(0xFF7C7E92).withOpacity(0.56),
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xFF3B3E5B),
                      ),
                      tabs: [
                        Tab(
                          text: "Хочу посетить",
                        ),
                        Tab(
                          text: "Посетил",
                          iconMargin: EdgeInsets.symmetric(horizontal: 5),
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
      ),
    );
  }
}
