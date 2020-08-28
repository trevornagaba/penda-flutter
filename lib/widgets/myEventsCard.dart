import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyEventsCard extends StatelessWidget {
  const MyEventsCard(this.data);
  final data;

  @override
  Widget build(BuildContext context) {
    return card(context, data);
  }

  Widget card(BuildContext context, data) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          Image.asset(
            'images/lake.jpg', //TODO: Read image from firestore
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          Row(children: <Widget>[
            Container(
                padding: const EdgeInsets.all(15.0),
                width: 300, //TODO: Test this for very long with
                child: (Text(data['title'],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)))),
          ]),
          Row(children: <Widget>[
            Container(
                padding: const EdgeInsets.all(15.0),
                child: Row(children: [
                  Icon(Icons.track_changes),
                  Text(' Target Amount: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    ('UGX ' + data['target_amount'].toString()),
                  )
                ])) //TODO: Read integer from firestore
          ]),
          Row(children: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 15.0, right: 60),
                // TODO
                // make padding screenresponsive
                child: Row(children: [
                  Icon(Icons.description),
                  Text(' Details: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    data['description'],
                  )
                ])),
          ]),
          Row(children: <Widget>[
            Container(
                padding: const EdgeInsets.all(15.0),
                child: Row(children: [
                  Icon(Icons.insert_invitation),
                  (Text(' Due date: ',
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  Text((data['due_date']).toString())
                ]))
          ]),
          Row(children: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(children: [
                  Icon(Icons.monetization_on),
                  (Text(' Current Amount: ',
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  Text((data['UGX unimplemented']).toString())
                ]))
          ]),
          Row(children: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 7.0, right: 17.0),
                width: 220,
                child: ButtonBar(children: [
                  RaisedButton(
                    child: Text('withdraw'),
                    color: Colors.blue,
                    onPressed: () async {
                      final FirebaseUser currentUser =
                          await _auth.currentUser();
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('unimplemented')));
                      // Navigator.pushNamed(context, '/withdraw',
                      //     arguments: {'eventData': data, 'user': currentUser});
                    },
                  )
                ], alignment: MainAxisAlignment.start)),
            GestureDetector(
              child: Row(children: <Widget>[
                Icon(Icons.people),
                Text(' Contributors',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
              onTap: () {
                return Navigator.of(context).push(
                    // pushes the route to the Navigator's stack
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Scaffold(
                      appBar: AppBar(
                        title: Text('Contributors'),
                      ),
                      body: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return _buildRow(data['contributors'][index]);
                          },
                          itemCount: data['contributors'].length),
                      floatingActionButton: FloatingActionButton(
                          child: Icon(Icons.content_copy),
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(
                                text: data['contributors'].toString()));
                          }));
                }));
              },
            ),
          ])
        ]));
  }

  Widget _buildRow(contributors) {
    return Column(
      children: [
        ListTile(
          title: Text(contributors['name']),
          trailing: Text(contributors['amount'].toString()),
        ),
        Divider()
      ],
    );
  }
}
