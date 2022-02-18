import 'package:train_trax/widgets/shadowContainer.dart';
import 'package:train_trax/screens/login/forgot.dart';
import 'package:train_trax/screens/login/register.dart';
import 'package:train_trax/screens/home/Homepage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum LoginType {
  email,
  google,
}

class OurLoginForm extends StatelessWidget {

   late List data;
   

  //https://train-trax.herokuapp.com/api/login Uri.parse(Uri.encodeFull('https://train-trax.herokuapp.com/api/login'))
  Future<void> getGoodRequest1() async{
    var url = 'https://train-trax.herokuapp.com/api/login';
    http.Response response = await http.get(Uri.parse(url));
    String data = response.body;
    
    print(jsonDecode(data));
    

  }

  @override
  Widget build(BuildContext context) {
    //getGoodRequest1();
    return ShadowContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Login",
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
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Log in",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            onPressed: () {
              //getData();
              
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>OurHome(),
                ),
              );
              //*/
            },
          ),
          FlatButton(
            child: Text("Don't have an account? Sign up here"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>OurRegister(),
                ),
              );
            },
          ),
          FlatButton(
            child: Text("Forgot Password"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>OurForgot(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
