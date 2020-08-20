import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'app.dart';
import 'model/app_state_model.dart' show AppStateModel;

void main() { // Added to work with environment variables
  return runApp(
    ChangeNotifierProvider<AppStateModel>(
      create: (context) => AppStateModel()..loadEvents(),
      child: CollectApp(),
    ),
  );
}