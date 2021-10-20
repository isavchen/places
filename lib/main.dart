import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screens/SplashScreen.dart';

void main() {
  runApp(App());
}

ChangeNotifier changeNotifier = ChangeNotifier();
bool isDarkTheme = false;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    changeNotifier.addListener(() {
      setState(() {
        isDarkTheme = !isDarkTheme;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? darkTheme : lightTheme,
      title: 'Places',
      home: SplashScreen(),
    );
  }
}
