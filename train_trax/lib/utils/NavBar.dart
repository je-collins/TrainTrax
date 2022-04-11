import 'dart:convert';
import 'package:http/http.dart';
import 'package:train_trax/screens/home/Homepage.dart';
import 'package:train_trax/screens/library/library.dart';
import 'package:train_trax/screens/self-directed/self-directed.dart';
import 'package:train_trax/widgets/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:train_trax/screens/admin/adminFAQ.dart';
import 'package:train_trax/screens/admin/adminTeamMang.dart';
import 'package:train_trax/screens/home/admin/team_statistics.dart';
import 'package:train_trax/screens/home/admin/add_resources.dart';
import 'package:train_trax/utils/APICall.dart';

class NavBar {
  String? currentPage = null;
  void setPage(String? current) {
    currentPage = current;
  }

  static Navigation createNavBar(BuildContext context, String currentPage, String tokn, String name, bool isAdmin) {
    return Navigation(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          //HOME
          if (currentPage == "HOME")
            FlatButton(
              textColor: Colors.yellow,
              child: Text("HOME"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {},
            ),
          if (currentPage != "HOME")
            FlatButton(
              textColor: Colors.white,
              child: Text("HOME"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OurHome(token: tokn, name: name, isAdmin: isAdmin, ),
                  ),
                );
              },
            ),

          //LIBRARY
          if (currentPage == "LIBRARY")
            FlatButton(
              textColor: Colors.yellow,
              child: Text("LIBRARY"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {},
            ),
          if (currentPage != "LIBRARY")
            FlatButton(
              textColor: Colors.white,
              child: Text("LIBRARY"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                _toLibrary(context: context, 
                           tokn: tokn,
                           name: name,
                           isAdmin: isAdmin);
              },
            ),

          //SELF-DIRECTED
          if (currentPage == "SELF-DIRECTED")
            FlatButton(
              textColor: Colors.yellow,
              child: Text("SELF-DIRECTED"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {},
            ),
          if (currentPage != "SELF-DIRECTED")
            FlatButton(
              textColor: Colors.white,
              child: Text("SELF-DIRECTED"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OurSelfDirected(token: tokn, name: name, isAdmin: isAdmin,articles: null,),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  static Navigation createAdminNavBar(BuildContext context, String currentPage, String tokn, String name){
    return Navigation(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[

          //HOME
          if(currentPage == "MANAGE_TEAMS")
            FlatButton(
              textColor: Colors.yellow,
              child: Text("MANAGE TEAMS"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {                
              },
            ),
          if(currentPage != "MANAGE_TEAMS")
          FlatButton(
              textColor: Colors.white,
              child: Text("MANAGE TEAMS"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OurAdminTeamMang(token: tokn, name: name,),
                  ),
                );
              }),

          //LIBRARY
          if(currentPage == "TEAM STATS")
          FlatButton(
            textColor: Colors.yellow,
            child: Text("TEAM STATS"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
            },
          ),
          if(currentPage != "TEAM STATS")
          FlatButton(
            textColor: Colors.white,
            child: Text("TEAM STATS"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>OurTeamStatistics(token: tokn, name: name,),
                ),
              );
            },
          ),

          //SELF-DIRECTED
          if(currentPage == "ADD RESOURCES")
          FlatButton(
            textColor: Colors.yellow,
            child: Text("ADD RESOURCES"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
            },
          ),
          if(currentPage != "ADD RESOURCES")
          FlatButton(
            textColor: Colors.white,
            child: Text("ADD RESOURCES"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>OurAddResources(token: tokn, name: name,),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static void _toHome({
    required String tokn,
    required String name,
    required BuildContext context,
    required bool isAdmin,
  }) async {
    try {
      Response _returnString;
      var token;

      _returnString = (await APICall.getStarredArticleRequest(tokn)) as Response;
      token = jsonDecode(_returnString.body);
          
      if (_returnString.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            //articles: token["results"]
            builder: (context) => OurHome(token: tokn, name: name, isAdmin: isAdmin,),
          ),
          (route) => false,
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(token["message"]),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  static void _toLibrary({
    required String tokn,
    required String name,
    required BuildContext context,
    required bool isAdmin,
  }) async {
    try {
      Response _returnString;
      var token;

      _returnString = (await APICall.getStarredArticleRequest(tokn)) as Response;
      token = jsonDecode(_returnString.body);
          
      if (_returnString.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            //articles: token["results"]
            builder: (context) => OurLibrary(token: tokn,  articles: token["results"], name: name, isAdmin: isAdmin,),
          ),
          (route) => false,
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(token["message"]),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  static void _toSelfDirect({
    required String tokn,
    required String name,
    required BuildContext context,
    required bool isAdmin,
  }) async {
    try {
      Response _returnString;
      var token;

      _returnString = (await APICall.getStarredArticleRequest(tokn)) as Response;
      token = jsonDecode(_returnString.body);
          
      if (_returnString.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            //articles: token["results"]
            builder: (context) => OurSelfDirected(token: tokn,  articles: token["results"], name: name, isAdmin: isAdmin,),
          ),
          (route) => false,
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(token["message"]),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  static void _toManageTeams({
    required String tokn,
    required String name,
    required BuildContext context,
  }) async {
    try {
      Response _returnString;
      var token;

      _returnString = (await APICall.getStarredArticleRequest(tokn)) as Response;
      token = jsonDecode(_returnString.body);
          
      if (_returnString.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            //articles: token["results"]
            builder: (context) => OurAdminTeamMang(token: tokn, name: name,),
          ),
          (route) => false,
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(token["message"]),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  static void _toTeamStats({
    required String tokn,
    required String name,
    required BuildContext context,
  }) async {
    try {
      Response _returnString;
      var token;

      _returnString = (await APICall.getStarredArticleRequest(tokn)) as Response;
      token = jsonDecode(_returnString.body);
          
      if (_returnString.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            //articles: token["results"]
            builder: (context) => OurTeamStatistics(token: tokn, name: name,),
          ),
          (route) => false,
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(token["message"]),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  static void _toAddResources({
    required String tokn,
    required String name,
    required BuildContext context,
  }) async {
    try {
      Response _returnString;
      var token;

      _returnString = (await APICall.getStarredArticleRequest(tokn)) as Response;
      token = jsonDecode(_returnString.body);
          
      if (_returnString.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            //articles: token["results"]
            builder: (context) => OurAddResources(token: tokn, name: name,),
          ),
          (route) => false,
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(token["message"]),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
  
}
