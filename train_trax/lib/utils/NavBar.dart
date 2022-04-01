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

  static void _toLibrary({
    required String tokn,
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
            builder: (context) => OurLibrary(token: tokn,  articles: token["results"],),
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

  static Navigation createNavBar(BuildContext context, String currentPage, String tokn) {
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
                    builder: (context) => OurHome(token: tokn,),
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
                           tokn: tokn);
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
                    builder: (context) => OurSelfDirected(token: tokn),
                  ),
                );
              },
            ),

          //CERTIFICATIONS
          if(currentPage == "CERTIFICATIONS")
          FlatButton(
            textColor: Colors.yellow,
            child: Text("CERTIFICATIONS"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
            },
          ),
          if(currentPage != "CERTIFICATIONS")
          FlatButton(
            textColor: Colors.white,
            child: Text("CERTIFICATIONS"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }

  static Navigation createAdminNavBar(BuildContext context, String currentPage, String tokn){
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
                    builder: (context) => OurAdminTeamMang(token: tokn),
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
                  builder: (context)=>OurTeamStatistics(token: tokn),
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
                  builder: (context)=>OurAddResources(token: tokn),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
