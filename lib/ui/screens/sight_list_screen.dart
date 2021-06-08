import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Container(
        color: Colors.green,
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Drawer Header",
                style: TextStyle(
                    fontFamily: "Roboto", fontSize: 20, color: Colors.white),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.home),
              title: Text("Title 1"),
            ),
            ListTile(
              trailing: Icon(Icons.settings),
              title: Text("Title 2"),
            ),
            ListTile(
              trailing: Icon(Icons.logout),
              title: Text("Title 3"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("AppBar SightListScreen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SightListScreen body"),
            TextField(),
          ],
        ),
      ),
    );
  }
}
