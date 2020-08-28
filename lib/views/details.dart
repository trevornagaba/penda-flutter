import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penda/services/database.dart';
import 'package:penda/widgets/eventCardDetailed.dart';

class Details extends StatefulWidget {
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

  // databaseMethods.getEventById(id) // TODO: Get the event details and render them here

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot eventDetails = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Details"), actions: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.share)),
        )
      ]),
      body: _buildListItem(context, eventDetails), // TODO
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    return EventCardDetailed(data);
  }
}
