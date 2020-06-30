import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getEventById(String id) async {
    return await Firestore.instance
        .collection('causes')
        .where('id', isEqualTo: id)
        .getDocuments();
  }

  uploadUserInfo(userMap) async {
    // User map comprises name and email
    Firestore.instance
        .collection('users')
        .add(userMap); //Alternative is to use .document(). rather than .add()
  }
}
