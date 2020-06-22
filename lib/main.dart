import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MaterialApp(
    home: HomePage(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/cause': (BuildContext context) => CausePage(),
    },));
}

final dummyUserSnapshot = [
  {
    "id": "",
    "name": "Trevor Nagaba",
    "email": "",
    "phone_number": "",
    "my_causes": ["", ""],
    "my_contributions": ["", ""]
  },
  {
    "id": "",
    "name": "Kaze Daudi",
    "email": "",
    "phone_number": "",
    "my_causes": ["", ""],
    "my_contributions": ["", ""]
  },
  {
    "id": "",
    "name": "Daudi Kaze",
    "email": "",
    "phone_number": "",
    "my_causes": ["", ""],
    "my_contributions": ["", ""]
  },
];

final dummyCauseSnapshot = [
  {
    "title": "event",
    "description": "",
    "creator": "Kaze",
    "target_amount": 100000,
    "due_date": "31/12/2020",
    "current_amount": 20000,
    "category": "event",
    "contributors": ["", ""]
  },
  {
    "title": "another event",
    "description": "",
    "creator": "Kaze Daudi",
    "target_amount": 100000,
    "due_date": "31/12/2020",
    "current_amount": 20000,
    "category": "event",
    "contributors": ["", ""]
  },
  {
    "title": "event une",
    "description": "",
    "creator": "Daudi Kaze",
    "target_amount": 100000,
    "due_date": "31/12/2020",
    "current_amount": 20000,
    "category": "event",
    "contributors": ["", ""]
  },
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: HomePage(),
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
      appBar: AppBar(title: Text("Penda")),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    // return _buildList(context, dummyUserSnapshot, dummyCauseSnapshot);

    // TO-DO
    // Read data from both user and causes stream
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
      BuildContext context, List<DocumentSnapshot> causeSnapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 0.0),
      children:
          causeSnapshot.map((data) => _buildListItem(context, data)).toList(),
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
                        onPressed: () {Navigator.pushNamed(context, '/cause');}, // Add the navigator to go to a cause
                      )
                    ], alignment: MainAxisAlignment.start)),
                Text('due date:' + (data['due_date']).toString())
              ])
            ])));
  }
}

class CausePage extends StatefulWidget {
  _CausePageState createState() => _CausePageState();
}

class _CausePageState extends State<CausePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cause details")),
      // body: _buildBody(context), // TO-DO
    );
  }
}