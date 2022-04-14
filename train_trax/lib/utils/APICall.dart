import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class APICall {
  //flutter run -d web-server
  static Future<String> loginRequest(String email, String password) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/login");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "email": email,
      "password": password
    });
    //"email": "ebtran8745@gmail.com",
    //"password": "tran"
    //cd .\train_trax\
    //flutter run -d web-server

    //dummy@email.com
    //12345

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    var token = jsonDecode(response.body);
    return token["message"];
  }

  static Future<String> loginTokenRequest(String email, String password) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/login");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "email": email,
      "password": password
    });
    //"email": "ebtran8745@gmail.com",
    //"password": "tran"
    //cd .\train_trax\
    //flutter run -d web-server
    //token last an hour

    //if (response.statusCode == 200)
    //return "success";
    //var token = jsonDecode(response.body);

    //return token["token"];
    var decoded = json.decode(response.body);

    return decoded["token"];
  }

  //1234@12mail.com
  //1234

  static Future<String> registerRequest(
      String email, String password, String phone, String name) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/register");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "email": email,
      "password": password,
      "name": name,
      "phone_number": phone
    });

    print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    //check missing error

    return "failure";
  }

  static Future<String> forgotPasswordRequest(String email) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/forgot_password");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "email": email,
    });

    print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    //check missing error

    return "failure";
  }

  static Future<String> resetPasswordRequest(
      String token, String password) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/reset_password");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "validation_token": token,
      "password": password,
    });

    print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    //check missing error

    return "failure";
  }

  static Future<http.Response> getUserStats(String token) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/get_user_stats");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token
    });

    //print(response.statusCode);
    //print(response.body);

    //if(response.statusCode == 200)
    //return jsonDecode(response.body);
    var decoded = json.decode(response.body);
    var stats = decoded["stats"];
    var users = stats["users"];

    return response;
  }

  static Future<http.Response> getUserInfo(String token) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/get_user_info");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token
    });

    //print(response.statusCode);
    //print(response.body);

    //if(response.statusCode == 200)
    //return jsonDecode(response.body);
    var decoded = json.decode(response.body);

    return response;
  }

  static Future<List> getUsers(String token) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/get_users");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token
    });

    //print(response.statusCode);
    //print(response.body);

    //if(response.statusCode == 200)
    //return jsonDecode(response.body);
    var decoded = json.decode(response.body);
    var users = decoded["users"];

    return users;
  }

  static Future<String> getUserName({
    required String tokn,
    required BuildContext context,
  }) async {
    try {
      Response _returnString;
      var token;

      _returnString = (await getUserStats(tokn)) as Response;
      token = jsonDecode(_returnString.data);

      if (_returnString.statusCode == 200) {
        return token["stats"]["users"][0]["name"];
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(token["message"]),
            duration: Duration(seconds: 3),
          ),
        );
        return '';
      }
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Future<List> getArticleRequest(String token) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/get_articles");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token
    });

    //print(response.statusCode);
    //jsonDecode(response.body);
    //print(response.body);

    //if(response.statusCode == 200)
    //return "success";
    var file = jsonDecode(response.body);

    if (response.statusCode == 200) return file["results"];

    return file["message"];
  }

  static Future<List> getAllArticleRequest(String token) async {
    Uri url =
        Uri.parse("https://train-trax.herokuapp.com/api/get_all_articles");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token
    });

    //print(response.statusCode);
    //jsonDecode(response.body);
    //print(response.body);

    //if(response.statusCode == 200)
    //return "success";
    var file = jsonDecode(response.body);

    if (response.statusCode == 200) return file["results"];

    return file["message"];
  }

  //works
  static Future<http.Response> getStarredArticleRequest(String token) async {
    Uri url =
        Uri.parse("https://train-trax.herokuapp.com/api/get_starred_articles");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token
    });

    //print(response.statusCode);
    //print(response.body);

    //if(response.statusCode == 200)
    //return "success";

    //return jsonDecode(response.body);
    var file = jsonDecode(response.body);

    //if(response.statusCode == 200)
    //return file["results"];

    //return file["message"];
    return response;
  }

  //works
  static Future<List> getStarredDomainsRequest(String token) async {
    Uri url =
        Uri.parse("https://train-trax.herokuapp.com/api/get_starred_domains");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token
    });

    //print(response.statusCode);
    //print(response.body);

    //if(response.statusCode == 200)
    //return "success";
    var file = jsonDecode(response.body);

    return file["results"];
  }

  static Future<String> createTeamRequest(String token, String teamName) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/create_team");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "team_name": teamName
    });

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }

  static Future<String> deleteTeamRequest(String token, int teamid) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/delete_team");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "teamid": teamid
    });

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }

  static Future<http.Response> getFavoritesRequest(String token) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/get_favorites");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token
    });

    //print(response.statusCode);
    //print(response.body);

    //if(response.statusCode == 200)
    //return jsonDecode(response.body);

    return response;
  }

  static Future<String> addMemberRequest(
      String token, int teamid, String memberid) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/add_member");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "team_id": teamid,
      "member_id": memberid,
    });

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }

  static Future<String> deleteMemberRequest(
      String token, int teamid, String memberid) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/delete_member");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "team_id": teamid,
      "member_id": memberid,
    });

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }

  static Future<String> answerQuestionRequest(
      String token, int qid, String answer) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/answer_question");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "question_id": qid,
      "answer_text": answer,
    });

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }

  static Future<String> askQuestionRequest(
      String token, String qusetion) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/ask_question");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "question_text": qusetion,
    });

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }

  static Future<http.Response> getQuestionsAnswerRequest(String token) async {
    Uri url =
        Uri.parse("https://train-trax.herokuapp.com/api/get_questions_answers");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token
    });

    return response;
  }

  static Future<String> addFavoriteRequest(
      String token, String articleid) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/add_favorite");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "article_id": articleid,
    });

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }

  static Future<String> removeFavoriteRequest(
      String token, int articleid) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/remove_favorite");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "article_id": articleid,
    });

    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }

  //flutter run -d web-server
  static Future<http.Response> getTeamStatsRequest(String token, int team_id) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/get_team_stats");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "team_id": team_id
    });

    var decode = jsonDecode(response.body);

    return response;
  }

  static Future<http.Response> getTeamInfoRequest(String token, int team_id) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/get_team_info");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "team_id": team_id
    });

    var decode = jsonDecode(response.body);

    return response;
  }

  static Future<String> addArticleRequest(String token, String article) async {
    Uri url = Uri.parse("https://train-trax.herokuapp.com/api/add_article");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "article": article
    });

    //print(response.statusCode);
    //jsonDecode(response.body);
    //print(response.body);

    //if(response.statusCode == 200)
    //return "success";
    var file = jsonDecode(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }

  static Future<String> addStarredArticleRequest(
      String token, String article) async {
    Uri url =
        Uri.parse("https://train-trax.herokuapp.com/api/add_starred_article");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "article": article
    });

    //print(response.statusCode);
    //jsonDecode(response.body);
    //print(response.body);

    //if(response.statusCode == 200)
    //return "success";
    var file = jsonDecode(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }

  static Future<String> addStarredDomainRequest(
      String token, String domain) async {
    Uri url =
        Uri.parse("https://train-trax.herokuapp.com/api/add_starred_domain");

    var response = await http.post(url, headers: <String, String>{
      "JSON": "application/json",
    }, body: {
      "token": token,
      "domain": domain
    });

    //print(response.statusCode);
    //jsonDecode(response.body);
    //print(response.body);

    //if(response.statusCode == 200)
    //return "success";
    var file = jsonDecode(response.body);

    if (response.statusCode == 200) return "success";

    return "failure";
  }
}
