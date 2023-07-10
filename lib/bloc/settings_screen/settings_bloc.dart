import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/bloc/settings_screen/settings_event.dart';
import 'package:places/bloc/settings_screen/settings_state.dart';
import 'package:places/ui/res/themes.dart';

class SettingsBloc extends Bloc<SettingsEvent, AppSettingsState> {
  SettingsBloc() : super(AppSettingsState(theme: lightTheme, isDarkTheme: false)) {
    on<ChangeTheme>(_changeTheme);
  }

  void _changeTheme(ChangeTheme event, Emitter<AppSettingsState> emit) {
    emit(AppSettingsState(theme: event.changeToDark ? darkTheme : lightTheme, isDarkTheme: event.changeToDark));
  }
}
