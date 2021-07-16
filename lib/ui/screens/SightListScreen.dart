import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widget/my_custom_appbar.dart';
import 'package:places/ui/widget/sight_card.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        title: Text(
          "Список интересных мест",
        ),
        height: 152,
        backgroundColor: Theme.of(context).primaryColor,
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
    );
  }
}
