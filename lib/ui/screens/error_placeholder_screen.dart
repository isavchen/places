import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';

class ErrorPlaceholderScreen extends StatelessWidget {
  const ErrorPlaceholderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icError,
          height: 64.0,
          width: 64.0,
        ),
        SizedBox(
          height: 24.0,
        ),
        Text(
          'error_placeholder_screen.title'.tr(),
          style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
                color: lmInactiveColor,
              ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          'error_placeholder_screen.subtitle'.tr(),
          style: Theme.of(context).primaryTextTheme.bodyMedium?.copyWith(
                color: lmInactiveColor,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
