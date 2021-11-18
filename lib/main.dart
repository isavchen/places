import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';
import 'package:places/ui/screens/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('ru'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('ru'),
      saveLocale: true,
      child: App(),
    ),
  );
}

ChangeNotifier changeNotifier = ChangeNotifier();
bool isDarkTheme = false;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    changeNotifier.addListener(() {
      setState(() {
        isDarkTheme = !isDarkTheme;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? darkTheme : lightTheme,
      title: 'Places',
      home: SplashScreen(),
    );
  }
}
