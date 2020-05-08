import 'package:crudwindowsfinal/screens/additems.dart';
import 'package:crudwindowsfinal/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:crudwindowsfinal/screens/allitems.dart';
import 'package:crudwindowsfinal/screens/search.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class SearchWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.redAccent,
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text(
            "Crud Carros",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions:
          <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  _scaffoldState.currentContext,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return AddItems();
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  _scaffoldState.currentContext,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return Welcome();
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Search(),
      ),
    );
  }
}
