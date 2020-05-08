import 'package:crudwindowsfinal/screens/additems.dart';
import 'package:flutter/material.dart';
import 'package:crudwindowsfinal/screens/allitems.dart';
import 'package:crudwindowsfinal/screens/search.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
           "Editor",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: AllItems(),
    );
  }
}
