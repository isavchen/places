import 'package:flutter/material.dart';
// import 'package:places/ui/screens/SightDetails.dart';
import 'package:places/ui/screens/VisitingScreen.dart';
// import 'package:places/ui/screens/SightDetails.dart';
import 'package:places/ui/screens/SightListScreen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Places',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VisitingScreen(),
      // home: SightListScreen(),
    );
  }
}
