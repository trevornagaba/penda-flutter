import 'package:flutter/foundation.dart';

class User {
  
  final String uid;
  User({this.uid});

/*
Consider whether the below is necessary considering how i had defined a users collection in firebase
But looks like it is unnecessary with firebase users
Perhaps change the collection to contributos
Or perhaps it is actually not necessary at all
 */
  // const User({
  //   @required this.email,
  //   @required this.name,
  //   @required this.phoneNumber,
  //   @required this.myCauses,
  //   @required this.myContributions
  // })  : assert(email != null),
  //       assert(name != null),
  //       assert(phoneNumber != null),
  //       assert(myCauses != null),
  //       assert(myContributions != null);

  // final String email;
  // final String name;
  // final String phoneNumber;
  // final List<int> myCauses; // These are stored as cause ids in the backend
  // final List<Map<String, String>> myContributions;

/*
TO-DO: Include image upload for profile
*/
}