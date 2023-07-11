import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/bloc/place_list_screen/place_list_screen_bloc.dart';
import 'package:places/bloc/settings_screen/settings_bloc.dart';
import 'package:places/bloc/settings_screen/settings_state.dart';
import 'package:places/bloc/visiting_screen/visited/visited_bloc.dart';
import 'package:places/bloc/visiting_screen/want_to_visit/want_to_visit_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    BlocProvider(
      create: (_) => SettingsBloc(),
      child: EasyLocalization(
        supportedLocales: [
          Locale('ru'),
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('ru'),
        saveLocale: true,
        child: App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlaceInteractor()),
        Provider(create: (context) => SearchInteractor()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                PlaceListScreenBloc(PlaceInteractor())..add(LoadPlacesList()),
          ),
          BlocProvider(create: (_) => WantToVisitBloc()),
          BlocProvider(create: (_) => VisitedBloc()),
        ],
        child: BlocBuilder<SettingsBloc, AppSettingsState>(
          builder: (context, settings) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: settings.theme,
              title: 'Places',
              home: SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
