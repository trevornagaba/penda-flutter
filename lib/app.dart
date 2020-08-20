import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penda/views/authenticate.dart';
import 'package:penda/views/contribute.dart';
import 'package:penda/views/contributeWebView.dart';
import 'package:penda/views/createCause.dart';
import 'package:penda/views/details.dart';
import 'package:penda/views/goto.dart';
import 'package:penda/views/home.dart';
import 'package:penda/views/myContributions.dart';
import 'package:penda/views/myEvents.dart';

class CollectApp extends StatefulWidget {
  _CollectAppState createState() => _CollectAppState();
}

class _CollectAppState extends State<CollectApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isSignedIn = false;

  isSignedInFunction() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser.uid != null) {
      setState(() {
        isSignedIn = true;
      });
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isSignedInFunction();
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      title: 'Collect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: isSignedIn ? Home() : Authenticate(), // becomes the route named '/'
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home(),
        '/detail': (BuildContext context) =>
            Details(), //TDO; perhaps add arguement by incuding a /$eventId
        '/goto': (BuildContext context) => Goto(), // Point to the Goto class
        '/contribute': (BuildContext context) =>
            Contribute(), // Point to the Contribute class
        '/createCause': (BuildContext context) =>
            CreateCause(), // Point to the createCause class
        '/myEvents': (BuildContext context) =>
            MyEvents(), // Point to the myEvents class
        '/myContributions': (BuildContext context) => MyContributions(),
        '/contributeWebView': (BuildContext context) => ContributeWebView() //Point to the ContributeWebView class
        // '/myProfile': (BuildContext context) => MyProflie(), // Point to the Goto class
      },
    );
  }
}
