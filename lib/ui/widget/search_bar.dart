import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';

class SearchBar extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;
  const SearchBar(
      {Key? key, this.enabled = true, this.controller, this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      enabled: enabled,
      controller: controller,
      onSubmitted: onSubmitted,
      autocorrect: false,
      cursorColor: Theme.of(context).focusColor,
      style: Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).focusColor,
          ),
      decoration: InputDecoration(
        hintText: 'search_bar.hint_text'.tr(),
        hintStyle: Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.w400,
              color: lmInactiveColor,
            ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).backgroundColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).backgroundColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).backgroundColor),
          borderRadius: BorderRadius.circular(12.0),
        ),
        fillColor: Theme.of(context).backgroundColor,
        filled: true,
        prefixIcon: SvgPicture.asset(
          icSearch,
          fit: BoxFit.none,
        ),
        suffixIcon: enabled
            ? InkWell(
                onTap: () {
                  controller?.clear();
                },
                child: Icon(
                  Icons.cancel_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            : null,
      ),
    );
  }
}
