import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/category.dart';
import 'package:places/ui/res/assets.dart';


//коллбек onChanged, возвращает текущее значение итема
typedef MyBoolCallback(bool);

class FilterItem extends StatefulWidget {
  final Category category;
  final bool value;
  final MyBoolCallback onChanged;
  const FilterItem(
      {Key? key,
      required this.category,
      required this.onChanged,
      required this.value})
      : super(key: key);

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    bool _value = widget.value;
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(32.0),
          onTap: () {
            setState(() {
              _value = !_value;
            });
            widget.onChanged(_value);
          },
          child: Stack(
            children: [
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    widget.category.img,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              _value
                  ? Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: SvgPicture.asset(
                            icCheck,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
                  : Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(),
                    ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          widget.category.name,
          style: Theme.of(context).primaryTextTheme.caption,
        ),
      ],
    );
  }
}
