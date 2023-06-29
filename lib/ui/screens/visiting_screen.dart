import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/widget/visited_content_widget.dart';
import 'package:places/ui/widget/want_to_visit_content_widget.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'visiting_screen.app_bar_title'.tr(),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: TabBar(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        tabs: [
                          Tab(
                            text: 'visiting_screen.tab.want_to_visit'.tr(),
                          ),
                          Tab(
                            text: 'visiting_screen.tab.visited'.tr(),
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
                WantToVisitContent(),
                VisitedContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
