import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';

class VisitingContentEmptyStateWidget extends StatelessWidget {
  final bool isWantToVisitContent;
  const VisitingContentEmptyStateWidget(
      {Key? key, required this.isWantToVisitContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          isWantToVisitContent ? icEmpty1 : icEmpty2,
          color: dmSecondaryColor2,
        ),
        SizedBox(
          height: 32,
        ),
        Text(
          'visiting_content.empty.title'.tr(),
          style: subtitleText,
        ),
        SizedBox(
          height: 8,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 253.5),
          child: Text(
            isWantToVisitContent
                ? 'visiting_content.want_visit.empty.desc'.tr()
                : 'visiting_content.visited.empty.desc'.tr(),
            textAlign: TextAlign.center,
            style: smallText,
          ),
        )
      ],
    );
  }
}
