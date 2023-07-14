import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class ChangeTheme extends SettingsEvent {
  final bool changeToDark;

  ChangeTheme({this.changeToDark = true});
}
