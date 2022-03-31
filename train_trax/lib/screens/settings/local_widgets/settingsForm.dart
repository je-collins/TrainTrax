import 'package:train_trax/screens/home/Homepage.dart';
import 'package:flutter/material.dart';

class OurSettingsForm extends StatelessWidget {

  String token;

  OurSettingsForm({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              "SETTINGS",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text("User Information:"),
          const SizedBox(
            height: 5.0,
          ),

          //Email
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '   Email:  ',
                ),
                TextSpan(
                  text: 'john.smith@usnavy.com',
                ),
              ],
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),

          //Password
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '   Password:  ',
                ),
                TextSpan(
                  text: '*************',
                ),
              ],
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),

          //Change Password
          Text("Change Password?"),
          const SizedBox(
            height: 5.0,
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.password), hintText: "Odd Password"),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.password), hintText: "New Password"),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: RaisedButton(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  "Change password",
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
                    builder: (context) => OurHome(token: token,),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
