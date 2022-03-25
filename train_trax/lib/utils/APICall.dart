import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class APICall {

  //https://train-trax.herokuapp.com/api/login Uri.parse(Uri.encodeFull('https://train-trax.herokuapp.com/api/login'))
  //String url = "https://cors-anywhere.herokuapp.com/https://train-trax.herokuapp.com/api/login";
  //print(await http.read(Uri.parse('https://train-trax.herokuapp.com/api/login')));
  
  Future<http.Response> getGoodRequest1(String email, String password) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/login");
    var response = await http.post(url,
    headers: <String, String>{
          "JSON": "application/json",
        },
    body: {"email": "christopher@email.com", 
            "password": "admin"});
    
    //flutter run -d web-server

    //Dio().post("https://train-trax.herokuapp.com/api/login", queryParameters: {"email":"christopher@email.com", "password":"admin"});
   //post(url,
    //body: {"email":"christopher@email.com", "password":"admin"});
    //var responses = await http.get('https://train-trax.herokuapp.com/api/login',
    /*
    headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
          "Access-Control-Allow-Origin": "*"

        });
        */
    /*
    final response = await http.get(url,
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        });
        */
    print(response.statusCode);
    print(response.body);
    return response;

    //if(response.statusCode == 401)
    //return "Success";

    //return "Failure";
    

  }

  //flutter run -d web-server
  static Future<String> loginRequest(String email, String password) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/login");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"email": email, 
            "password": password});
            //"email": "ebtran8745@gmail.com", 
            //"password": "tran"
            

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }

}