import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySecondWidget(),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  
  // Type getContextRunTime() {
  //   return context.runtimeType;
  // }

  @override
  Widget build(BuildContext context) {
    print(context.runtimeType);
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

  Type getContextRunTime() {
    return context.runtimeType;
  }

  @override
  Widget build(BuildContext context) {
    i++;
    print(i);
    print(getContextRunTime);
    return Container(
      child: Center(
        child: Text('Hello!'),
      ),
    );
  }
}
