import 'package:penda/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    } else {
      print('user' + result.user.toString());
      Navigator.pushReplacementNamed(context, '/home'); // Note that we would otherwise use pushReplacement for signin as this prevents the user from going back
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
