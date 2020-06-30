import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penda/services/auth.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collect"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              authService.signOut();
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.person)),
          )
        ],
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.attach_money),
          onPressed: () {
            Navigator.pushNamed(context, '/goto');
          }),
    );
  }

  Widget _buildBody(BuildContext context) {
    // return _buildList(context, dummyUserSnapshot, dummydetailSnapshot);

    // TODO
    // Read data from both user and details stream
    // The below gets actual snapshot from Cloud Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('causes').snapshots(),
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
                          Navigator.pushNamed(context, '/detail', arguments: data);
                        }, // Add the navigator to go to a detail
                      )
                    ], alignment: MainAxisAlignment.start)),
                Text('due date:' + (data['due_date']).toString())
              ])
            ])));
  }
}