import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penda/services/auth.dart';
import 'package:penda/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:penda/views/authenticate.dart';
import 'package:penda/widgets/eventCard.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = new AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DatabaseMethods databaseMethods = new DatabaseMethods();

  void getEventbyUserId() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    Navigator.pushNamed(context, '/myEvents',
        arguments:
            currentUser.uid); //TODO: Define my causes class; style this also
  }

  getCurrentUserName() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    return currentUser.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collect"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
              Navigator.pushReplacementNamed(
                  context, '/search'); //TODO: Implement search functionality
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.search)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/createCause');
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.add)),
          )
        ],
      ),
      drawer: Drawer(
          //TODO; Consider making this drawer a seperate class
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Icon(Icons.tune,
                size:
                    50), //TODO: Replace this with either an image or user name icon
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(title: Text('My events'), onTap: getEventbyUserId),
          ListTile(
            title: Text('My contributions'),
            onTap: () {
              Navigator.pushNamed(context, '/myContributions');
            },
          ),
          ListTile(
            title: Text('My profile'),
            onTap: () {
              Navigator.pushNamed(context,
                  '/myprofile'); //TODO: Define my profile class; style this also
            },
          ),
          ListTile(
            title: Text('Signout'),
            onTap: () {
              authService.signOut();
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Authenticate()),
              );
              ;
            },
          )
        ],
      )),
      //TODO: Populate with my causes, my contributions, signout and profile etc
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
    return new EventCard(data);
  }
}
