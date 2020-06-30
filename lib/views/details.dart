import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penda/services/database.dart';

class DetailPage extends StatefulWidget {
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  
  // databaseMethods.getEventById(id) // TODO: Get the event details and render them here

  @override
  Widget build(BuildContext context) {

    DocumentSnapshot eventDetails = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: _buildListItem(context, eventDetails), // TODO
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
            margin: EdgeInsets.all(10),
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
                    child: (Text(
                      data['title'],
                    ))),
                Container(
                    padding: const EdgeInsets.only(left: 65.0),
                    child: Text((data['target_amount']).toString()))
              ]),
              Row(children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(left: 15.0, right: 60),
                    // TODO
                    // make padding screenresponsive
                    child: Text(
                      data['description'],
                      // TODO
                      // find a way to wrap the description
                      overflow: TextOverflow.ellipsis,
                      softWrap:
                          true, // text lines will fill the column width before wrapping at a word boundary
                    )),
                IconButton(
                    icon: Icon(Icons.share),
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("SnackBar"),
                      ));
                    })
              ]),
              Row(children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(left: 7.0, right: 87.0),
                    child: ButtonBar(children: [
                      // TODO
                      // Add the action/route for the on_pressed method
                      RaisedButton(
                        child: Text('expand'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/detail');
                        }, // Add the navigator to go to a detail
                      )
                    ], alignment: MainAxisAlignment.start)),
                Text('due date:' + (data['due_date']).toString())
              ])
            ])));
  }
}