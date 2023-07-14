import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  final Color selectedColor;
  final Color normalColor;
  final double width;
  final double? dotWidth;

  const PageIndicator({
    Key? key,
    required this.currentIndex,
    required this.itemCount,
    required this.selectedColor,
    required this.width,
    required this.normalColor,
    this.dotWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(itemCount, (int index) {
          bool isCurrentPageSelected = index == currentIndex;
          return Container(
            width: width,
            height: 8,
            decoration: BoxDecoration(
              color: isCurrentPageSelected
                  ? selectedColor
                  : dotWidth != null
                      ? Colors.transparent
                      : normalColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: dotWidth != null && !isCurrentPageSelected
                ? Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: normalColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  )
                : Container(),
          );
        }),
      ),
    );
  }
}
