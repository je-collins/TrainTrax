import 'package:train_trax/widgets/shadowContainer.dart';
import 'package:train_trax/screens/login/login.dart';
import 'package:flutter/material.dart';

enum LoginType {
  email,
  google,
}

class OurRegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Register",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //First Name
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person), hintText: "First Name"),
          ),
          SizedBox(
            height: 20.0,
          ),
          //Last Name
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person), hintText: "Last Name"),
          ),
          SizedBox(
            height: 20.0,
          ),
          //Phone Number
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.call), hintText: "Phone Number"),
          ),
          SizedBox(
            height: 20.0,
          ),
          //Email
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email), hintText: "Email"),
          ),
          SizedBox(
            height: 20.0,
          ),
          //Password
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          //Confirm Password
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                hintText: "Confirm Password"),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          //Register Button
          RaisedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>OurLogin(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
