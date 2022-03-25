import 'package:train_trax/screens/home/Homepage.dart';
import 'package:train_trax/screens/library/library.dart';
import 'package:train_trax/screens/self-directed/self-directed.dart';
import 'package:train_trax/widgets/Navigation.dart';
import 'package:flutter/material.dart';

class NavBar {
  String? currentPage = null;

  void setPage(String? current) {
    currentPage = current;
  }

  static Navigation createNavBar(BuildContext context, String currentPage) {
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
                    builder: (context) => OurHome(),
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OurLibrary(),
                  ),
                );
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
                    builder: (context) => OurSelfDirected(),
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

  static Navigation createAdminNavBar(BuildContext context, String currentPage){
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
              onPressed: () {}),

          //LIBRARY
          if(currentPage == "TEAM_STATS")
          FlatButton(
            textColor: Colors.yellow,
            child: Text("TEAM STATS"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
            },
          ),
          if(currentPage != "TEAM_STATS")
          FlatButton(
            textColor: Colors.white,
            child: Text("TEAM STATS"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>OurLibrary(),
                ),
              );
            },
          ),

          //SELF-DIRECTED
          if(currentPage == "ADD_RESOURCES")
          FlatButton(
            textColor: Colors.yellow,
            child: Text("ADD RESOURCES"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
            },
          ),
          if(currentPage != "ADD_RESOURCES")
          FlatButton(
            textColor: Colors.white,
            child: Text("ADD RESOURCES"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>OurSelfDirected(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
