import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/screens/HomePage.dart';
import 'package:places/ui/screens/OnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future isInitialized;
  bool showOnboarding = true;

  void _navigateToNext() async {
    await Future.delayed(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => showOnboarding ? OnboardingScreen() : HomePage(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            lmYellowColor,
            lmGreenColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SvgPicture.asset(splashLogo),
        ),
      ),
    );
  }
}
