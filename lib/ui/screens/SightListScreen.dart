import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/assets.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/screens/AddSightScreen.dart';
import 'package:places/ui/widget/my_custom_appbar.dart';
import 'package:places/ui/widget/sight_card.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    print(mocks.length);
    return Scaffold(
      // appBar: MyCustomAppBar(
      //   title: Text(
      //     "Список интересных мест",
      //   ),
      //   height: 152,
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Список интересных мест",
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 16.0, vertical: 6.0),
                //   child: TextField(
                //     enabled: false,
                //     decoration: InputDecoration(
                //       contentPadding: const EdgeInsets.symmetric(
                //           horizontal: 15.0, vertical: 10.0),
                //       disabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //             color: Theme.of(context).backgroundColor),
                //         borderRadius: BorderRadius.circular(12.0),
                //       ),
                //       fillColor: Theme.of(context).backgroundColor,
                //       filled: true,

                //       // prefixIcon: SvgPicture.asset(icSearch, height: 18,),
                //     ),
                //   ),
                // ),
                for (final mock in mocks)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: SightCard(sight: mock),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddSightScreen()),
                  );
                },
                child: Container(
                  width: 177.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Theme.of(context).canvasColor,
                        Theme.of(context).buttonColor,
                      ],
                    ),
                    // color: Colors.green,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 22.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                      ),
                      // SizedBox(width: 13),
                      Text(
                        "НОВОЕ МЕСТО",
                        style: textButton,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
