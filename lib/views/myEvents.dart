import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penda/services/database.dart';
import 'package:penda/widgets/myEventsCard.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Events")),
      //TODO: Populate with my causes, my contributions, signout and profile etc
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    var userId = ModalRoute.of(context).settings.arguments;

    // TODO
    // Read data from both user and details stream
    // The below gets actual snapshot from Cloud Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('causes')
          .where('creatorId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(
      BuildContext context, List<DocumentSnapshot> detailSnapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 0.0),
      children:
          detailSnapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    return new MyEventsCard(data);
  }
}
