import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/placeRepository.dart';
import 'package:places/redux/middleware/place_middleware.dart';
import 'package:places/redux/reducer/reducer.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

void main() async {
  final store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: [
      PlaceMiddleware(PlaceRepository()),
    ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsInteractor(),
      child: EasyLocalization(
        supportedLocales: [
          Locale('ru'),
        ],
        path: 'assets/translations',
        fallbackLocale: Locale('ru'),
        saveLocale: true,
        child: App(
          store: store,
        ),
      ),
    ),
  );
}

class App extends StatefulWidget {
  final Store<AppState> store;

  const App({Key? key, required this.store}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PlaceInteractor()),
          ChangeNotifierProvider(create: (context) => SearchInteractor()),
        ],
        child: Consumer<SettingsInteractor>(
          builder: (context, settingsInteractor, child) {
            return StoreProvider(
              store: widget.store,
              child: MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: settingsInteractor.getCurrentTheme,
                title: 'Places',
                home: SplashScreen(),
              ),
            );
          },
        ));
  }
}
