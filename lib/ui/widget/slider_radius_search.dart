import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/styles.dart';

//коллбек onChanged, возвращает текущее значение слайдера
typedef MyDoubleCallback(double);

class SliderRadiusSearch extends StatefulWidget {
  final double value;
  final MyDoubleCallback onChanged;
  const SliderRadiusSearch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SliderRadiusSearchState createState() => _SliderRadiusSearchState();
}

class _SliderRadiusSearchState extends State<SliderRadiusSearch> {
  @override
  Widget build(BuildContext context) {
    double _value = widget.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'filters.distance'.tr(),
                style: smallText.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                'filters.distance_value'.tr(
                  namedArgs: {
                    'value': (_value / 1000).toStringAsFixed(1),
                  },
                ),
                style: smallText.copyWith(
                  fontSize: 16,
                  color: dmSecondaryColor2,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Container(
            height: 16,
            child: Slider(
              min: 0,
              max: 10000,
              value: 10000,
              onChanged: null,
              //TODO: add radius changing when geolocation will be conected
              // value: _value,
              // onChanged: (currentlyValue) {
              //   setState(() {
              //     _value = currentlyValue;
              //   });
              //   widget.onChanged(_value);
              // }
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dy;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
