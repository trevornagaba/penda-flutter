import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penda/services/database.dart';
import 'package:penda/widgets/eventCard.dart';
import 'package:penda/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyContributions extends StatefulWidget {
  @override
  _MyContributionsState createState() => _MyContributionsState();
}

class _MyContributionsState extends State<MyContributions> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Contributions")),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    var userId = ModalRoute.of(context).settings.arguments;
    // var userSnapshot = databaseMethods.getUserbyId(userId);
    // var contributions = userSnapshot.contributors;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('causes')
          .where('contributors_dict.$userId',
              isEqualTo: userId)
          // .where('contributors', arrayContains: "$userId")
          // // .where('id', isEqualTo: userId)
          .snapshots(), //TODO: We may have to move all these to database.dart for consistency
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
    return new EventCard(data);
  }
}
