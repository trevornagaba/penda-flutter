import 'package:flutter/material.dart';
// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
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
  // {
  //   "title": "event une",
  //   "description": "",
  //   "creator": "Daudi Kaze",
  //   "target_amount": 100000,
  //   "due_date": "31/12/2020",
  //   "current_amount": 20000,
  //   "category": "event",
  //   "contributors": ["", ""]
  // },
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Penda")),
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return _buildList(context, dummyUserSnapshot, dummyCauseSnapshot);
}

Widget _buildList(
    BuildContext context, List<Map> userSnapshot, List<Map> causeSnapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children:
        causeSnapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, Map data) {
  return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Card(
              margin: EdgeInsets.all(10),
              child: Column(children: <Widget>[Text('Dummy text here')]))));
}
