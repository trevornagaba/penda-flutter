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
  var events;

  DatabaseMethods databaseMethods = new DatabaseMethods();

  void getEventbyUserId() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    Navigator.pushNamed(context, '/myEvents',
        arguments:
            currentUser.uid); //TODO: Define my causes class; style this also
  }

  buildStream() {
    return StreamBuilder(
        stream: Firestore.instance.collection('causes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return null;
          events = snapshot.data.documents;
          return snapshot.data.documents;
        });
  }

  getCurrentUserName() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    return currentUser.displayName;
  }

  void getContributions() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    var userSnapshot = databaseMethods.getUserbyId(currentUser.uid);
    print(userSnapshot);
    Navigator.pushNamed(context, '/myContributionsSummary',
        arguments: currentUser.uid);
  }

  void getProfile() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    Navigator.pushNamed(context, '/myProfile', arguments: {
      'name': currentUser.displayName,
      'email': currentUser.email,
      'photo': currentUser.photoUrl,
      'phoneNumber': currentUser.phoneNumber,
      'id': currentUser.uid
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Collect"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: EventSearch());
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
            onTap: getContributions,
          ),
          ListTile(
            title: Text('My profile'),
            onTap: () {
              getProfile(); //TODO: Define my profile class; style this also
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
    // TODO
    // The below gets actual snapshot from Cloud Firestore
    return StreamBuilder<QuerySnapshot>(
      //TODO: Take this out so you can call it only once even for the search, look at implementations of blocs
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

class EventSearch extends SearchDelegate {
  // final Future<QuerySnapshot> events;

  // EventSearch(this.events);

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('causes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('No Data'));
          }
          final results = snapshot.data.documents
              .where((a) => a['title'].toLowerCase().contains(query.toLowerCase()));

          return ListView(
              children: results
                  .map<ListTile>((a) => ListTile(
                        title: Text(
                          a['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          a['creator'].toString(),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/detail', arguments: a);
                        },
                      ))
                  .toList());
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('causes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('No Data'));
          }
          final results = snapshot.data.documents
              .where((a) => a['title'].toLowerCase().contains(query.toLowerCase()));

          return ListView(
              children: results
                  .map<ListTile>((a) => ListTile(
                        title: Text(
                          a['title'],
                          style: TextStyle(color: Colors.blue),
                        ),
                        trailing: Text(a['creator'].toString(),
                            style: TextStyle(color: Colors.blue)),
                        onTap: () {
                          Navigator.pushNamed(context, '/detail', arguments: a);
                        },
                      ))
                  .toList());
        });
  }
}
