import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:train_trax/screens/home/downloads.dart';
import 'package:train_trax/screens/home/faq.dart';
import 'package:train_trax/screens/home/favorites.dart';
import 'package:train_trax/screens/settings/settings.dart';
import 'package:train_trax/screens/home/admin/team_statistics.dart';
import 'package:train_trax/utils/APICall.dart';

class ProfileBar extends StatelessWidget {
  String? currentPage = null;

  void setPage(String? current) {
    currentPage = current;
  }

  static Wrap createProfileBar(BuildContext context, String currentPage,
      String tokn, String name, bool isAdmin) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: <Widget>[
        //DOWNLOAD
        if (currentPage == "DOWNLOAD")
          IconButton(
            color: Colors.yellow,
            icon: const Icon(Icons.download),
            onPressed: () {},
          ),
        if (currentPage != "DOWNLOAD")
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OurDownload(
                    token: tokn,
                    name: name,
                    isAdmin: isAdmin,
                  ),
                ),
              );
            },
          ),

        //FAQ
        if (currentPage == "FAQ")
          IconButton(
            color: Colors.yellow,
            icon: const Icon(Icons.help),
            onPressed: () {},
          ),
        if (currentPage != "FAQ")
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OurFAQ(
                    token: tokn,
                    name: name,
                    isAdmin: isAdmin,
                  ),
                ),
              );
            },
          ),

        //FAVORITE
        if (currentPage == "FAVORITE")
          IconButton(
            color: Colors.yellow,
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
        if (currentPage != "FAVORITE")
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              _toFavorites(
                context: context,
                tokn: tokn,
                name: name,
                isAdmin: isAdmin,
              );
            },
          ),

        //SETTINGS
        if (currentPage == "SETTINGS")
          IconButton(
            color: Colors.yellow,
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        if (currentPage != "SETTINGS")
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _toSettings(
                  context: context, tokn: tokn, name: name, isAdmin: isAdmin);
            },
          ),

        //ADMINISTRATION
        if (isAdmin && currentPage == "ADMINISTRATION")
          IconButton(
            color: Colors.yellow,
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {},
          ),
        if (isAdmin && currentPage != "ADMINISTRATION")
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {
              _toTeamStats(tokn: tokn, name: name, context: context);
            },
          ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.end,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  static void _toFavorites({
    required String tokn,
    required String name,
    required BuildContext context,
    required bool isAdmin,
  }) async {
    try {
      Response _returnString;
      var token;

      _returnString = (await APICall.getFavoritesRequest(tokn)) as Response;
      token = jsonDecode(_returnString.body);

      if (_returnString.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            //articles: token["results"]
            builder: (context) => OurFavorite(
              token: tokn,
              articles: token["results"],
              name: name,
              isAdmin: isAdmin,
            ),
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

      _returnString = (await APICall.getUserInfo(tokn)) as Response;
      token = jsonDecode(_returnString.body);
      Response _userStats = (await APICall.getUserStats(tokn)) as Response;
      var userstats = jsonDecode(_userStats.body);

      if (_returnString.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            //articles: token["results"]
            builder: (context) => OurTeamStatistics(
                token: tokn, name: name, teamStats: userstats),
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

  static void _toSettings({
    required String tokn,
    required String name,
    required BuildContext context,
    required bool isAdmin,
  }) async {
    try {
      Response _returnString;
      var token;

      _returnString = (await APICall.getUserInfo(tokn)) as Response;
      token = jsonDecode(_returnString.body);

      if (_returnString.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            //articles: token["results"]
            builder: (context) => OurSettings(
              token: tokn,
              email: token["email"],
              name: name,
              isAdmin: isAdmin,
            ),
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
