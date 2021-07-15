import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screens/FiltersScreen.dart';
import 'package:places/ui/screens/SightDetailsScreen.dart';
import 'package:places/ui/screens/VisitingScreen.dart';
import 'package:places/ui/screens/SightListScreen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      // theme: lightTheme,
      title: 'Places',
      // home: SightListScreen(),
      // home: VisitingScreen(),
      // home: SightDetailsScreen(),
      home: FiltersScreen(),
    );
  }
}
