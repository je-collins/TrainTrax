import 'package:train_trax/screens/home/admin/add_resources.dart';
import 'package:train_trax/screens/home/admin/manage_teams.dart';
import 'package:train_trax/screens/home/admin/team_statistics.dart';
import 'package:train_trax/widgets/Navigation.dart';
import 'package:flutter/material.dart';

class OurAdminNavigation {
  String? currentPage = null;

  void setPage(String? current) {
    currentPage = current;
  }

  static Navigation createAdminBar(BuildContext context, String currentPage) {
    return Navigation(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          //HOME
          if (currentPage == "MANAGE TEAMS")
            FlatButton(
              textColor: Colors.yellow,
              child: Text("MANAGE TEAMS"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {},
            ),
          if (currentPage != "MANAGE TEAMS")
            FlatButton(
              textColor: Colors.white,
              child: Text("MANAGE TEAMS"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OurManageTeams(),
                  ),
                );
              },
            ),

          //LIBRARY
          if (currentPage == "TEAM STATS")
            FlatButton(
              textColor: Colors.yellow,
              child: Text("TEAM STATS"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {},
            ),
          if (currentPage != "TEAM STATS")
            FlatButton(
              textColor: Colors.white,
              child: Text("TEAM STATS"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OurTeamStatistics(),
                  ),
                );
              },
            ),

          //SELF-DIRECTED
          if (currentPage == "ADD RESOURCES")
            FlatButton(
              textColor: Colors.yellow,
              child: Text("ADD RESOURCES"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {},
            ),
          if (currentPage != "ADD RESOURCES")
            FlatButton(
              textColor: Colors.white,
              child: Text("ADD RESOURCES"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OurAddResources(),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
