import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class APICall {


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
            //cd .\train_trax\
            //flutter run -d web-server
            

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }

  static Future<String> registerRequest(String email, String password, String phone, String name) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/register");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"email": email,
           "password": password,
           "name": name,
           "phone_number": phone});

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    if(response.statusCode == 401)
      return "Duplicate email";
    
    //check missing error

    return "failure";

  }

  //does not work
  static Future<String> getArticleRequest(String token) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/get_articles");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"token": token
        });

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }

  //works
  static Future<String> getStarredArticleRequest(String token) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/get_starred_articles");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"token": token
        });

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }

  //works
  static Future<String> getStarredDomainsRequest(String token) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/get_starred_domains");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"token": token
        });

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }

  static Future<String> createTeamRequest(String token, String teamName) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/create_team");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"token": token,
           "team_name": teamName
        });

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }

  static Future<String> deleteTeamRequest(String token) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/delete_team");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"token": token
        });

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }

  static Future<String> addMemberRequest(String token, String teamid, String memberid) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/add_member");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"token": token,
           "team_id": teamid,
           "member_id": memberid,
        });

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }

  static Future<String> deleteMemberRequest(String token, String teamid, String memberid) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/delete_member");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"token": token,
           "team_id": teamid,
           "member_id": memberid,
        });

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }

  static Future<String> answerQuestionRequest(String token, String qid, String answer) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/answer_question");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"token": token,
           "question_id": qid,
           "answer_text": answer,
        });

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }
  
  static Future<String> addFavoriteRequest(String token, String articleid) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/add_favorite");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"token": token,
           "article_id": articleid,
        });

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }

  static Future<String> removeFavoriteRequest(String token, String articleid) async{
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/remove_favorite");
    
    var response = await http.post(url,
    headers: <String, String>{
      "JSON": "application/json",
        },
    body: {"token": token,
           "article_id": articleid,
        });

    print(response.statusCode);
    //print(response.body);
    
    if(response.statusCode == 200)
      return "success";

    return "failure";

  }



}