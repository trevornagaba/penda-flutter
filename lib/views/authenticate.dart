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

    await authService.signInWithGoogle(context).then((result) {
      
      Map<String, String> userInfoMap = {
        'name': 'test_name',
        'email': 'test_email'
      };

      databaseMethods.uploadUserInfo(userInfoMap);
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