import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// abstract class SettingsState extends Equatable {
//   const SettingsState();

//   @override
//   List<Object?> get props => [];
// }

class AppSettingsState extends Equatable {
  final ThemeData theme;
  final bool isDarkTheme;
  AppSettingsState({required this.theme, required this.isDarkTheme});

  @override
  List<Object> get props => [theme];
}
