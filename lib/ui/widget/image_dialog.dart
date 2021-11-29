import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/styles.dart';
import 'package:easy_localization/easy_localization.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Theme.of(context).primaryColor,
            ),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 6.0,
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12.0),
                      leading: SvgPicture.asset(
                        icCamera,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      minLeadingWidth: 0,
                      title: Text(
                        'dialog.title.camera'.tr(),
                        style: lmMatBodyText2.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop('camera');
                      },
                    ),
                    Divider(),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12.0),
                      leading: SvgPicture.asset(
                        icPhoto,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      minLeadingWidth: 0,
                      title: Text(
                        'dialog.title.photo'.tr(),
                        style: lmMatBodyText2.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop('photo');
                      },
                    ),
                    Divider(),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12.0),
                      leading: SvgPicture.asset(
                        icFile,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      minLeadingWidth: 0,
                      title: Text(
                        'dialog.title.file'.tr(),
                        style: lmMatBodyText2.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop('file');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          SizedBox(
            width: double.infinity,
            height: 48.0,
            child: Theme(
              data: ThemeData(
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                ),
              ),
              child: ElevatedButton(
                child: Text(
                  'dialog.button.cancel'.tr().toUpperCase(),
                  style: textButton.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
