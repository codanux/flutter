import 'package:flutter/material.dart';
import 'package:my_app/auth/login.dart';
import 'package:my_app/google_maps/google_maps.dart';
import 'package:my_app/home/home.dart';

import 'package:shared_preferences/shared_preferences.dart';
 
void main() => runApp(MyApp());
 
 
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final _pageOptions = [
    Home(),
    GoogleMaps()
  ];

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: "test",
      home: buildData(context),
    );
    return materialApp;
  }

  Future<bool> _authCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool('auth') ?? false;
    
    //await prefs.setBoolean('counter', counter);
    return status;
  }

  Widget buildData(BuildContext context) {
    return FutureBuilder<bool>(
      future: _authCheck(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return snapshot.data ? Scaffold(
        appBar: _selectedPage == 1 ? null : AppBar(title: Text("AppBar")),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: buildBottomNavigationBar(),
      ): LoginPage();
      },
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int _index) { setState(() {
          _selectedPage = _index;
        });},
        items: [
          BottomNavigationBarItem(
           icon: Icon(Icons.home),
           title: Text("Home")
          ),
          BottomNavigationBarItem(
           icon: Icon(Icons.supervised_user_circle),
           title: Text("Search Friend")
          ),
        ]
      );
  }
}