import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/screens/home_page.dart';
import 'package:places/ui/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateAnimation;

  bool showOnboarding = true;

  void _navigateToNext() async {
    await Future.delayed(Duration(seconds: 2), () {
      _animationController.dispose();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              showOnboarding ? OnboardingScreen() : HomePage(),
        ),
      );
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1600),
    );
    _rotateAnimation = Tween<double>(begin: 2 * pi, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
    );
    _animationController.repeat();
    _navigateToNext();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Здесь не срабатывает dispose и происходит ошибка
    // _animationController.dispose();
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
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateAnimation.value,
                child: SvgPicture.asset(splashLogo),
              );
            },
          ),
        ),
      ),
    );
  }
}
