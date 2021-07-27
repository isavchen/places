import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkTheme = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Настройки"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Тёмная тема",
                    style:
                        Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w400,
                            ),
                  ),
                  CupertinoSwitch(
                    trackColor: Theme.of(context).dividerColor,
                    activeColor: Theme.of(context).buttonColor,
                    value: isDarkTheme,
                    onChanged: (currentValue) {
                      setState(() {
                        _isDarkTheme = currentValue;
                      });
                      changeNotifier.notifyListeners();
                    },
                  ),
                ],
              ),
            ),
            Divider(
              height: 0.8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Смотреть туториал",
                    style:
                        Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w400,
                            ),
                  ),
                  IconButton(
                      onPressed: () {
                        print("Go to Tutorial");
                      },
                      icon: Icon(
                        Icons.info_outline,
                        color: Theme.of(context).buttonColor,
                      ))
                ],
              ),
            ),
            Divider(
              height: 0.8,
            ),
          ],
        ),
      ),
    );
  }
}
