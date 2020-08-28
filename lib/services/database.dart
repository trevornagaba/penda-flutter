import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getEventById(String id) async {
    return await Firestore.instance
        .collection('causes')
        .where('id', isEqualTo: id)
        .getDocuments();
  }

  getEventByTitle(String title) async {
    return await Firestore.instance
        .collection('causes')
        .where('title', isEqualTo: title)
        .getDocuments();
  }

  uploadUserInfo(userMap) async {
    // User map comprises name and email
    return await Firestore.instance
        .collection('users')
        .add(userMap); //Alternative is to use .document(). rather than .add()
  }

  createCause(causeMap) async {
    return await Firestore.instance.collection('causes').add(causeMap);
  }

  updateProfile(userProfile, id) { //TODO: This is not working
    Firestore.instance
        .collection('users')
        .document(id)
        .updateData(userProfile);
  }

  getEventbyUserId(userId) async {
    return await Firestore.instance
        .collection('causes')
        .where('creatorId', isEqualTo: userId)
        .getDocuments();
  }

  getUserbyEmail(String email) async {
    return await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
  }

  getEventbyContributorId(id) async {
    return await Firestore.instance
        .collection('causes')
        .where('contributors', isEqualTo: id)
        .getDocuments();
  }

  getUserbyId(userId) async {
    return await Firestore.instance
        .collection('causes')
        .where('id', isEqualTo: userId)
        .getDocuments();
  }
}
