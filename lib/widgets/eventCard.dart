import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard(this.data);
  final data;

  @override
  Widget build(BuildContext context) {
    return card(context, data);
  }

  Widget card(BuildContext context, data) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
            margin: EdgeInsets.all(3),
            child: Column(children: <Widget>[
              Image.asset(
                'images/lake.jpg',
                width: 600,
                height: 240,
                fit: BoxFit.cover,
              ),
              Row(children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(15.0),
                    width: 300, //TODO: Test this for very long with
                    child: (Text(data['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)))),
              ]),
              Row(children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(children: [
                      Icon(Icons.track_changes),
                      Text(' Target Amount: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(('UGX ' + data['target_amount'].toString()))
                    ])) //TODO: Read integer from firestore
              ]),
              Row(children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 60),
                    // height: 200,
                    width: 400,
                    // TODO
                    // make padding screenresponsive
                    child: Row(children: [
                      Icon(Icons.description),
                      Text(' Details: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        data['description'],
                        // TODO
                        // find a way to wrap the description
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      )
                    ]) // text lines will fill the column width before wrapping at a word boundary
                    )
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
                    padding: const EdgeInsets.only(left: 7.0, right: 87.0),
                    width: 200,
                    child: ButtonBar(children: [
                      // TODO
                      // Add the action/route for the on_pressed method
                      RaisedButton(
                        child: Text('expand'), color: Colors.blue,
                        onPressed: () {
                          Navigator.pushNamed(context, '/detail',
                              arguments: data);
                        }, // Add the navigator to go to a detail
                      )
                    ], alignment: MainAxisAlignment.start)),
              ]),
            ])));
  }
}
