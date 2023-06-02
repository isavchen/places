import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widget/slider_radius_search.dart';

final lightTheme = ThemeData(
  primaryColor: lmPrimaryColor,
  focusColor: lmFocusColor,
  scaffoldBackgroundColor: lmPrimaryColor,
  dividerColor: lmInactiveColor,
  canvasColor: lmYellowColor,
  highlightColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    backgroundColor: lmPrimaryColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: lmMatHeadline6,
    foregroundColor: lmAccentColor,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  primaryTextTheme: TextTheme(
    titleLarge: lmMatHeadline6,
    headlineSmall: lmMatHeadline5,
    titleMedium: lmMatSubtitle1,
    titleSmall: lmMatSubtitle2,
    bodyMedium: lmMatBodyText2,
    bodySmall: lmCaptionText,
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
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return lmBackgroundColor;
          return lmGreenColor;
        },
      ),
      elevation: MaterialStateProperty.all<double>(0.0),
      textStyle: MaterialStateProperty.all<TextStyle>(textButton),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: lmGreenColor,
      textStyle: lmMatSubtitle1,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
    ),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: lmGreenColor,
    inactiveTrackColor: lmInactiveColor,
    overlayColor: Colors.transparent,
    thumbColor: Colors.white,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8, elevation: 3),
    trackShape: CustomTrackShape(),
    trackHeight: 0.2,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: lmPrimaryColor,
    hourMinuteColor: Colors.lightGreen.withOpacity(0.15),
    hourMinuteTextColor: Colors.lightGreen,
    dialBackgroundColor: Colors.grey[300],
    dialHandColor: Colors.lightGreen,
    dialTextColor: Colors.black,
  ), colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: lmAccentColor,
    surface: lmGreenColor,
  ).copyWith(background: lmBackgroundColor).copyWith(error: lmRedColor),
);

final darkTheme = ThemeData(
  primaryColor: dmPrimaryColor,
  focusColor: dmFocusColor,
  scaffoldBackgroundColor: dmPrimaryColor,
  dividerColor: dmInactiveColor,
  appBarTheme: AppBarTheme(
    backgroundColor: dmPrimaryColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: dmMatHeadline6,
    foregroundColor: dmAccentColor,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  canvasColor: dmYellowColor,
  highlightColor: Colors.transparent,
  primaryTextTheme: TextTheme(
    titleLarge: dmMatHeadline6,
    headlineSmall: dmMatHeadline5,
    titleMedium: dmMatSubtitle1,
    titleSmall: dmMatSubtitle2,
    bodyMedium: dmMatBodyText2,
    bodySmall: dmCaptionText,
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
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled))
            return dmBackgroundColor;
          else
            return dmGreenColor;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled))
            return dmInactiveColor;
          else
            return Colors.white;
        },
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(textButton),
      elevation: MaterialStateProperty.all<double>(0.0),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    foregroundColor: dmGreenColor,
    textStyle: dmMatSubtitle1,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
  )),
  sliderTheme: SliderThemeData(
    activeTrackColor: dmGreenColor,
    inactiveTrackColor: dmInactiveColor,
    overlayColor: Colors.transparent,
    thumbColor: Colors.white,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8, elevation: 3),
    trackShape: CustomTrackShape(),
    trackHeight: 0.2,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: dmPrimaryColor,
    hourMinuteColor: dmRedColor.withOpacity(0.15),
    hourMinuteTextColor: dmRedColor,
    dialBackgroundColor: dmInactiveColor,
    dialHandColor: dmRedColor,
    dialTextColor: Colors.white,
    entryModeIconColor: Colors.white,
    helpTextStyle: TextStyle(color: Colors.white),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: dmAccentColor,
    surface: dmGreenColor,
  ).copyWith(background: dmBackgroundColor).copyWith(error: dmRedColor),
);
