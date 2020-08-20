// Flutter code sample for Form

// This example shows a [Form] with one [TextFormField] to enter an email
// address and a [RaisedButton] to submit the form. A [GlobalKey] is used here
// to identify the [Form] and validate input.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/widgets/form.png)

import 'package:flutter/material.dart';
import 'package:penda/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

/// This Widget is the main application widget.
class CreateCause extends StatefulWidget {
  CreateCause({Key key}) : super(key: key); // What is this??
  @override
  _CreateCauseState createState() => _CreateCauseState();
}

class _CreateCauseState extends State<CreateCause> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();
  final _privacyController = TextEditingController();
  String _ErrorText; //TODO: Operationalize for all categories to catch errors

  createCause(
      title, description, targetAmount, dueDate, category, privacy) async {
    final FirebaseUser currentUser = await _auth.currentUser();
    Map<String, String> causeMap = {
      //T0DO: Do not add user if already exists
      'id': Uuid().v1(),
      'title': title.text,
      'description': description.text,
      'target_amount': targetAmount.text,
      'due_date': dueDate.text,
      'creator': currentUser.displayName,
      'creatorId': currentUser.uid,
      'category': category.text,
      'privacy': privacy.text
    };
    databaseMethods.createCause(causeMap);
    Navigator.pushReplacementNamed(context, '/home');
    // return Scaffold.of(context)
    //     .showSnackBar(SnackBar(content: Text("Cause succesfully created")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create cause"),
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
                    hintText: 'title',
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
                  controller: _titleController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'description',
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
                  controller: _descriptionController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'target amount',
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
                  controller: _targetAmountController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'due date', //TODO: Make this a date picker
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
                  controller: _dueDateController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText:
                        'category (event, fundraiser or other)', //TODO: Make this a dropdown list
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
                  controller: _categoryController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText:
                        'private or public event', //TODO: Make this a dropdown list
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
                  controller: _privacyController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'upload image', //TODO: Make this a dropdown list
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
                  controller: _imageController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(color: Colors.blue,textColor: Colors.white,
                    onPressed: () {
                      // TODO: Add functionality for validation
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate()) {
                        // Process data.
                        createCause(
                            _titleController,
                            _descriptionController,
                            _targetAmountController,
                            _dueDateController,
                            _categoryController,
                            _privacyController);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
