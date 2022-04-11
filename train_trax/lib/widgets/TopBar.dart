import 'package:flutter/material.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/profile.dart';

class TopBar extends StatelessWidget{
  String? name = null;

  void setPage(String? pname){
    name=pname;

  }

  static Row createTopBar(BuildContext context, String name, String currentPage, String tokn, bool isAdmin){
    return Row(
      children: [
      Profile.createProfile(context, name, true),
      Spacer(),
      ProfileBar.createProfileBar(context, currentPage, tokn, name, isAdmin,),
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
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }
}
