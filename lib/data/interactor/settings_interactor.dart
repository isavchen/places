import 'package:flutter/material.dart';
import 'package:places/data/repository/placeRepository.dart';
import 'package:places/ui/res/themes.dart';

class SettingsInteractor extends ChangeNotifier {
  static final PlaceRepository placeRepository = PlaceRepository();

  ThemeData _selectedTheme = lightTheme;

  ThemeData get getCurrentTheme => _selectedTheme;

  void changeTheme({required bool isDarkTheme}) {
    _selectedTheme = isDarkTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
