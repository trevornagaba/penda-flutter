import 'package:flutter/material.dart';
import 'package:penda/services/auth.dart';
import 'package:penda/services/database.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  bool isLoading = false;

  loadingSignInfunction() async {
    setState(() {
      isLoading = true;
    });
    
    await authService.signInWithGoogle(context).then((result) async { //TODO: Every signin should allow user select and account
    //TODO: Signin should persist until user selects to signout
      if (result != null) {
        Map<String, String> userInfoMap = {
          //T0DO: Do not add user if already exists
          'name': result.displayName,
          'email': result.email,
          'photoUrl': result.photoUrl,
          'id': result.uid
        };

        var userDocument;

        databaseMethods.getUserbyEmail(result.email).then((val) {
          if (val.documents.length > 0) {
            val.documents.forEach((document) {
              userDocument = document.data;
            });
          } else {
            databaseMethods.uploadUserInfo(userInfoMap);
          }
          Navigator.pushReplacementNamed(context, '/home');
        });
      } else {
        setState(() {
          isLoading = false;
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Login failed"), //T0DO: This is not working
          ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hello")),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Spacer(),

                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Defined at the top of this class
                      //TODO: Causes load before signin is complete yet async loading function is expected first
                      loadingSignInfunction();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Sign In with Google",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ), // Creates space between elements
                ],
              ),
            ),
    );
  }
}
