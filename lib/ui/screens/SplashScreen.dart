import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<String> list = List<String>.generate(100000, (index) => "gnirts $index");
  late Future isInitialized;

  void _navigateToNext() async {
    await Future.delayed(
        Duration(seconds: 2), () => print("Переход на следующий экран"));
  }

  List<String> reverseStr(String from) {
    print("started $from - " + "${DateTime.now()}");
    List<String> reverseArr = [];
    for (int i = 0; i < list.length; i++) {
      setState(() {
        reverseArr.add(list[i].split('').reversed.join(''));
      });
    }
    print("end $from - " + "${DateTime.now()}");
    return reverseArr;
  }

  void syncFunc() {
    final _arr = reverseStr("syncFunc");
    print(_arr);
  }

  void futureFunc() {
    List<String> arr = [];
    Future(() {
      arr = reverseStr("futureFunc");
    }).then((_) {
      print(arr);
    });
  }

  void isolateFunc() async {
    final arr = await compute(reverseIsolate, list);
    print(arr);
  }

  @override
  void initState() {
    super.initState();
    syncFunc();
    futureFunc();
    isolateFunc();
    // _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            lmYellowColor,
            lmGreenColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SvgPicture.asset(splashLogo),
        ),
      ),
    );
  }
}


List<String> reverseIsolate(List<String> list) {
  print("started isolateFunc - " + "${DateTime.now()}");
  List<String> reverseArr = [];
  for (int i = 0; i < list.length; i++) {
    reverseArr.add(list[i].split('').reversed.join(''));
  }
  print("end isolateFunc - " + "${DateTime.now()}");
  return reverseArr;
}
