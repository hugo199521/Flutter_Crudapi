import 'package:crudwindowsfinal/Crud/modelo/api/profile.dart';
import 'package:crudwindowsfinal/screens/visorsearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:crudwindowsfinal/Crud/modelo/api/searchservice.dart';
import 'package:crudwindowsfinal/screens/additems.dart';

class Search extends StatefulWidget {
  Search() : super();



  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class UserFilterDemoState extends State<Search> {
  //
  final _debouncer = Debouncer(milliseconds:100);
  List<Profile> users = List();
  List<Profile> filteredUsers = List();

  @override
  void initState() {
    super.initState();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: 'Filtra por modelo o agencia',
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  filteredUsers = users
                      .where((u) =>
                  (u.modelo
                      .toLowerCase()
                      .contains(string.toLowerCase()) ||
                      u.agencia.toLowerCase().contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(2.0),
              itemCount: filteredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(

                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children:<Widget>[

                            Image.network(filteredUsers[index].carro_foto,
                            ),
                            Text(filteredUsers[index].modelo,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            Text(filteredUsers[index].agencia,
                            ),
                            Text(filteredUsers[index].precio.toString()),
                            //Text(filteredUsers[index].carro_foto.toString()),

                            Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return VisorSearch(
                                                profile: filteredUsers[index]);
                                          }));
                                    },
                                  ),
                                  Text(
                                    "Visualizar",
                                    style: TextStyle(color: Colors.deepOrangeAccent),
                                  ),
                                ]
                            ),
                          ],
                        ),
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}