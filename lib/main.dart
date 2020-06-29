import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import 'app.dart';
import 'model/app_state_model.dart';

void main() {
  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (context) => AppStateModel()..loadEvents(),
      child: PendaApp(),
    ),
  );
}