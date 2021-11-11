import 'package:flutter/material.dart';
import 'package:places/ui/widget/visiting_content.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
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
      ),
    );
  }
}
