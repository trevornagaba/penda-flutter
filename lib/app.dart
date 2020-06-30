import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penda/views/authenticate.dart';
import 'package:penda/views/details.dart';
import 'package:penda/views/goto.dart';
import 'package:penda/views/homepage.dart';

class PendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      title: 'Collect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Authenticate(), // becomes the route named '/'
      routes: <String, WidgetBuilder>{
        '/detail': (BuildContext context) => DetailPage(), //TDO; perhaps add arguement by incuding a /$eventId
        '/home': (BuildContext context) => HomePage(),
        '/goto': (BuildContext context) => Goto(), // Point to the Goto class
        // TODO: Add routes to other pages like payments, and later create cause, mycause and withdraw
      },
    );
  }
}
