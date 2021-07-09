import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';

final lightTheme = ThemeData(
  primaryColor: lmPrimaryColor,
  accentColor: lmAccentColor,
  focusColor: lmFocusColor,
  scaffoldBackgroundColor: lmPrimaryColor,
  backgroundColor: lmBackgroundColor,
  dividerColor: lmInactiveColor,
  buttonColor: lmGreenColor,
  primaryTextTheme: TextTheme(
    headline6: lmMatHeadline6,
    headline5: lmMatHeadline5,
    subtitle1: lmMatSubtitle1,
    subtitle2: lmMatSubtitle2,
    bodyText2: lmMatBodyText2,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: lmPrimaryColor,
    unselectedLabelColor: lmInactiveColor,
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: tabBarLabel,
    unselectedLabelStyle: tabBarLabel,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: lmAccentColor,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lmPrimaryColor,
    unselectedItemColor: lmSecondaryColor,
    selectedItemColor: lmSecondaryColor,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(lmGreenColor),
      elevation: MaterialStateProperty.all<double>(0.0),
      textStyle: MaterialStateProperty.all<TextStyle>(textButton),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
    ),
  ),
);

final darkTheme = ThemeData(
  primaryColor: dmPrimaryColor,
  accentColor: dmAccentColor,
  focusColor: dmFocusColor,
  backgroundColor: dmBackgroundColor,
  scaffoldBackgroundColor: dmPrimaryColor,
  dividerColor: dmInactiveColor,
  buttonColor: dmGreenColor,
  primaryTextTheme: TextTheme(
    headline6: dmMatHeadline6,
    headline5: dmMatHeadline5,
    subtitle1: dmMatSubtitle1,
    subtitle2: dmMatSubtitle2,
    bodyText2: dmMatBodyText2,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: dmSecondaryColor,
    unselectedLabelColor: dmSecondaryColor2,
    indicatorSize: TabBarIndicatorSize.tab,
    labelStyle: tabBarLabel,
    unselectedLabelStyle: tabBarLabel,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: dmAccentColor,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: dmPrimaryColor,
    unselectedItemColor: dmAccentColor,
    selectedItemColor: dmAccentColor,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(dmGreenColor),
      textStyle: MaterialStateProperty.all<TextStyle>(textButton),
      elevation: MaterialStateProperty.all<double>(0.0),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
    ),
  ),
);
