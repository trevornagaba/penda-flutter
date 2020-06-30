import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class PendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      title: 'Collect',
      home: HomePage(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/detail': (BuildContext context) => DetailPage(),
      // TO-DO: Add routes to other pages like payments, and later create cause, mycause and withdraw
    },
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Collect")),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    // return _buildList(context, dummyUserSnapshot, dummydetailSnapshot);

    // TO-DO
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
                    // TO-DO
                    // make padding screenresponsive
                    child: Text(
                      data['description'],
                      // TO-DO
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
                      // TO-DO
                      // Add the action/route for the on_pressed method
                      RaisedButton(
                        child: Text('expand'),
                        onPressed: () {Navigator.pushNamed(context, '/detail');}, // Add the navigator to go to a detail
                      )
                    ], alignment: MainAxisAlignment.start)),
                Text('due date:' + (data['due_date']).toString())
              ])
            ])));
  }
}

class DetailPage extends StatefulWidget {
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: _buildBody(context), // TO-DO
    );
  }

  Widget _buildBody(BuildContext context) {
    // return _buildList(context, dummyUserSnapshot, dummydetailSnapshot);

    // TO-DO
    // Read data from both user and details stream
    // The below gets actual snapshot from Cloud Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('details').snapshots(), 
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
                    // TO-DO
                    // make padding screenresponsive
                    child: Text(
                      data['description'],
                      // TO-DO
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
                      // TO-DO
                      // Add the action/route for the on_pressed method
                      RaisedButton(
                        child: Text('expand'),
                        onPressed: () {Navigator.pushNamed(context, '/detail');}, // Add the navigator to go to a detail
                      )
                    ], alignment: MainAxisAlignment.start)),
                Text('due date:' + (data['due_date']).toString())
              ])
            ])));
  }
}