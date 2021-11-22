import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/styles.dart';

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
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Theme.of(context).primaryColor,
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: SvgPicture.asset(
                      icCamera,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    minLeadingWidth: 0,
                    title: Text(
                      'Камера',
                      style: lmMatBodyText2.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: SvgPicture.asset(
                      icPhoto,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    minLeadingWidth: 0,
                    title: Text(
                      'Фотография',
                      style: lmMatBodyText2.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    leading: SvgPicture.asset(
                      icFile,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    minLeadingWidth: 0,
                    title: Text(
                      'Файл',
                      style: lmMatBodyText2.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.0),
          SizedBox(
            width: double.infinity,
            height: 48.0,
            child: ElevatedButton(
              child: Text('ОТМЕНА'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
