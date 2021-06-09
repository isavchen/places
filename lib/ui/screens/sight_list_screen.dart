import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  TextStyle textStyle = TextStyle(
    fontFamily: "Roboto",
    fontWeight: FontWeight.w700,
    fontSize: 32,
    color: Color(0xFF252849),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        toolbarHeight: 150,
        shadowColor: Colors.transparent,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "C",
                style: textStyle.copyWith(color: Color(0xff4CAF50)),
                children: [
                  TextSpan(
                    text: "писок\n",
                    style: textStyle,
                  ),
                ],
              ),
              TextSpan(
                text: "и",
                style: textStyle.copyWith(color: Color(0xfffcdd3b)),
                children: [
                  TextSpan(
                    text: "нтересных мест",
                    style: textStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
