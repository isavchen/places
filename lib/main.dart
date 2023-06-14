import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    //
    ChangeNotifierProvider(
      create: (context) => SettingsInteractor(),
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
    // Изначально реализовал бизнес-логику через Provider в модуле 10
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PlaceInteractor()),
          ChangeNotifierProvider(create: (context) => SearchInteractor()),
        ],
        //
        child: Consumer<SettingsInteractor>(
          builder: (context, settingsInteractor, child) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: settingsInteractor.getCurrentTheme,
              title: 'Places',
              home: SplashScreen(),
            );
          },
        ));
  }
}
