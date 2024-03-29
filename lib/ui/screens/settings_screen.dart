// ignore_for_file: invalid_use_of_protected_member

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/bloc/settings_screen/settings_bloc.dart';
import 'package:places/bloc/settings_screen/settings_event.dart';
import 'package:places/bloc/settings_screen/settings_state.dart';
import 'package:places/ui/screens/onboarding_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

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
                    BlocBuilder<SettingsBloc, AppSettingsState>(
                      builder: (context, state) {
                        return CupertinoSwitch(
                          trackColor: Theme.of(context).dividerColor,
                          activeColor: Theme.of(context).colorScheme.surface,
                          value: state.isDarkTheme,
                          onChanged: (currentValue) {
                            context
                                .read<SettingsBloc>()
                                .add(ChangeTheme(changeToDark: currentValue));
                          },
                        );
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
