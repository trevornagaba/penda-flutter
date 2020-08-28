// Flutter code sample for Form

// This example shows a [Form] with one [TextFormField] to enter an email
// address and a [RaisedButton] to submit the form. A [GlobalKey] is used here
// to identify the [Form] and validate input.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)

import 'package:flutter/material.dart';
import 'package:penda/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// This Widget is the main application widget.
class MyProfile extends StatefulWidget {
  MyProfile({Key key}) : super(key: key); // What is this??
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _ErrorText; //TODO: Operationalize for all categories to catch errors

  updateProfile(name, email, phoneNumber, id) async {
    Map<String, String> userProfile = {
      //T0DO: Do not add user if already exists
      'name': name.text,
      'email': email.text,
      'phone number': phoneNumber.text,
    };
    databaseMethods.updateProfile(userProfile, id);
    Navigator.pushReplacementNamed(context, '/home');
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Profile Updated'),
      duration: Duration(milliseconds: 1000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Map user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("My profile"),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: user['name'],
                    // errorText: _phoneErrorText,
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey.shade500,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: _nameController,
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter some text';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: user['email'],
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey.shade500,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: _emailController,
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter some text';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: user['phoneNumber'],
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey.shade500,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: _phoneNumberController,
                  // validator: (value) {
                  //   if (value.isEmpty) {
                  //     return 'Please enter some text';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      // TODO: Add functionality for validation
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        // Process data.
                        updateProfile(_nameController, _emailController,
                            _phoneNumberController, user['id']);
                      }
                    },
                    child: Text('Update'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
