import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventCardDetailed extends StatelessWidget {
  const EventCardDetailed(this.data);
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
                    padding: const EdgeInsets.only(left: 7.0, right: 87.0),
                    width: 270,
                    child: ButtonBar(children: [
                      // TODO
                      // Add the action/route for the on_pressed method
                      RaisedButton(
                        child: Text('contribute'), color: Colors.blue,
                        onPressed: () {
                          Navigator.pushNamed(context, '/contribute');
                        }, // Navigate to contribute page TODO: Include the context so that it is captured after making the contribution
                      )
                    ], alignment: MainAxisAlignment.start)),
                IconButton(
                    icon: Icon(Icons.share),
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("share"),
                      ));
                    }) //TODO: Read date from firestore
              ]),
              Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 17.0, top: 10.0),
                      alignment: Alignment.centerLeft,
                      child: Row(children: <Widget>[
                        Icon(Icons.people),
                        Text(' Contributors',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ])),
                  // Container(
                  //   padding: const EdgeInsets.all(10.0),
                  //   alignment: Alignment.centerLeft,
                  //   child:
                  //   Expanded(child: ListView(
                  //     padding: const EdgeInsets.only(top: 0.0),
                  //     children: <Widget>[ListTile(title: Text('name'),trailing: Text('amount'),)],
                  //   ),)
                  // )
                ],
              )
            ])));
  }
}
