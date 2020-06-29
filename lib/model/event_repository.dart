// TO-DO: Connect to firestore

import 'event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventRepository {
  static const _allEvents = <Event>[
    Event(
        category:
            'event', // Turn into somthing like Category.event after creating the Category enum in event.dart
        id: 0,
        title: 'test event',
        description: 'test description',
        targetAmount: 1200000,
        currentAmount: 50000,
        dueDate: '30/07/2020',
        creator: 'Jackson',
        contributors: {'Jackson': 10000, 'Trevor': 50000}),
    Event(
        category:
            'event', // Turn into somthing like Category.event after creating the Category enum in event.dart
        id: 0,
        title: 'test event',
        description: 'test description',
        targetAmount: 1200000,
        currentAmount: 50000,
        dueDate: '30/07/2020',
        creator: 'Jackson',
        contributors: {'Jackson': 10000, 'Trevor': 50000})
  ];

  static List<Event> loadEvents() {
    return _allEvents;
  }
}

// class EventStream {
//   static List<QuerySnapshot> loadEvents() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Firestore.instance.collection('causes').snapshots(), 
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return LinearProgressIndicator();

//         return _buildList(context, snapshot.data.documents);
//       },
//     );
//   }
// }