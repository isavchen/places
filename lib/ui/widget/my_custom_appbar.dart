import 'package:flutter/material.dart';

class MyCustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Text title;
  final double height;
  final Color backgroundColor;
  const MyCustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.blue,
    this.height = 100,
  }) : super(key: key);

  @override
  _MyCustomAppBarState createState() => _MyCustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(this.height);
}

class _MyCustomAppBarState extends State<MyCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, bottom: 16),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65),
            child: widget.title,
          ),
        ),
      ),
    );
  }
}
