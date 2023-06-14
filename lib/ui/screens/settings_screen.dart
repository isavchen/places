// ignore_for_file: invalid_use_of_protected_member

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('settings.app_bar.title'.tr()),
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
                      'settings.dark_theme'.tr(),
                      style: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    CupertinoSwitch(
                      trackColor: Theme.of(context).dividerColor,
                      activeColor: Theme.of(context).colorScheme.surface,
                      value: _isDarkTheme,
                      onChanged: (currentValue) {
                        setState(() {
                          _isDarkTheme = currentValue;
                        });
                        //
                        Provider.of<SettingsInteractor>(context, listen: false)
                            .changeTheme(isDarkTheme: _isDarkTheme);
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
                      'settings.tutorial'.tr(),
                      style: Theme.of(context)
                          .primaryTextTheme
                          .titleMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => OnboardingScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.surface,
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
      ),
    );
  }
}
