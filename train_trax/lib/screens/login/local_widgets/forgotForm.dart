import 'package:train_trax/widgets/shadowContainer.dart';
import 'package:flutter/material.dart';

enum LoginType {
  email,
  google,
}

class OurForgotForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Forgot Password",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email), hintText: "Email"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
          ),
          RaisedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Send Reset Link",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
