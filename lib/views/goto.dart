import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penda/services/database.dart';

class Goto extends StatefulWidget {
  @override
  _GotoState createState() => _GotoState();
}

class _GotoState extends State<Goto> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController eventIdTextEditingController =
      new TextEditingController();

  DocumentSnapshot eventSnapshot;

  void pressArrow() {
    databaseMethods.getEventById(eventIdTextEditingController.text).then((val) {
      eventSnapshot = val;
      Navigator.pushReplacementNamed(
          context,
          '/detail',
              arguments: eventSnapshot); //TDO: Implement the query snapshot so that details handles receipt of the firestore object
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Enter event id"),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Center(
                // Centering the field is not working
                child: Column(children: [
              Row(children: [
                Expanded(
                    child: TextField(
                        controller:
                            eventIdTextEditingController, // Captures the text input
                        decoration: InputDecoration(
                            hintText: 'Input event id',
                            hintStyle: TextStyle(color: Colors.grey)))),
                GestureDetector(
                  child: Icon(Icons.arrow_forward),
                  onTap: () {
                    pressArrow();
                  },
                )
              ])
            ]))));
  }
}
