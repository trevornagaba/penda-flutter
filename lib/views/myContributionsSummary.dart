import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penda/services/auth.dart';
import 'package:penda/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penda/views/authenticate.dart';
import 'package:penda/widgets/eventCard.dart';

class MyContributionsSummary extends StatefulWidget {
  _MyContributionsSummaryState createState() => _MyContributionsSummaryState();
}

class _MyContributionsSummaryState extends State<MyContributionsSummary> {
  AuthService authService = new AuthService();
  var events;

  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    var userId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("My contributions"),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('users')
                .where('id', isEqualTo: userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return ListView(
                padding: const EdgeInsets.only(top: 0.0),
                children: snapshot.data.documents
                    .map((data) => ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title:
                                    Text(data['contributions'][index]['title'], style: TextStyle(fontWeight: FontWeight.bold),),
                                trailing: Text('UGX  '+data['contributions'][index]
                                        ['amount']
                                    .toString()),
                              ),
                              // Text(
                              //   data['contributions'][index]['id'],
                              //   textAlign: TextAlign.left, style: TextStyle(fontStyle: FontStyle.italic,)
                              // ), //TODO: Left Align id
                              Divider()
                            ],
                          );
                        },
                        itemCount: data['contributions'].length))
                    .toList(),
              );
            }));
  }
}