import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final PageController controller;
  final int itemCount;
  final Color selectedColor;
  final Color normalColor;
  final double width;

  const PageIndicator({
    Key? key,
    required this.controller,
    required this.itemCount,
    required this.selectedColor,
    required this.width,
    required this.normalColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, (int index) {
        bool isCurrentPageSelected = index ==
            (controller.page != null
                ? controller.page!.round() % itemCount
                : 0);
        return Container(
          width: width,
          height: 8,
          decoration: BoxDecoration(
            color: isCurrentPageSelected ? selectedColor : normalColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
        );
      }),
    );
  }
}
