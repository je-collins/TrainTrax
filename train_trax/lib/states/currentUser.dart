import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser extends ChangeNotifier {
  String _uid = "";
  String _email = "";

  String get getUid => _uid;

  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(String email, String password) async {
    String retVal = "Error";

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      retVal = "Success!";
    } catch (e) {
      retVal = e.toString();
    }

    return retVal;
  }
}
