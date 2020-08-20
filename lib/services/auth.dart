import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penda/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:penda/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

  // Return a userid from the firebase user object
  // This is done by calling the User method from the User class
  User _userFromFirebaseUser(FirebaseUser user) {
    //TO-DO: Maybe include username as
    return user != null
        ? User(uid: user.uid)
        : null; // So as not to crash the app incase user returns null. Everything is null by default
  }

  Future<FirebaseUser> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = new GoogleSignIn();
    DatabaseMethods databaseMethods = new DatabaseMethods();
    DocumentSnapshot userSnapshot;

    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser userDetails = result.user;

    if (result == null) {
      print('Result is null');
      return null;
    } else {
      //     Navigator.pushReplacementNamed(context, '/home');
      return userDetails;
      //     // return _auth.currentUser(); //TODO: This i believe is the real way to get user details
      //   }
      // });
    }
  }

  Future signOut() async {
    try {
      await _googleSignIn.disconnect(); //TODO: This isn't working as expected to make the signin select a google account
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
