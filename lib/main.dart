import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySecondWidget(),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    i++;
    print(i);
    return Container(
      child: Center(
        child: Text('Hello!'),
      ),
    );
  }
}

class MySecondWidget extends StatefulWidget {
  @override
  _MySecondWidgetState createState() => _MySecondWidgetState();
}

class _MySecondWidgetState extends State<MySecondWidget> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    i++;
    print(i);
    return Container(
      child: Center(
        child: Text('Hello!'),
      ),
    );
  }
}
