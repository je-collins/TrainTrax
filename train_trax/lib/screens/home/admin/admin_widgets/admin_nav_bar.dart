import 'package:train_trax/widgets/Navigation.dart';
import 'package:flutter/material.dart';

class OurAdminNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigation(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          FlatButton(
              textColor: Colors.white,
              child: Text("MANAGE TEAMS"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {}),
          FlatButton(
            textColor: Colors.yellow,
            child: Text("TEAM STATS"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {},
          ),
          FlatButton(
              textColor: Colors.white,
              child: Text("ADD RESOURCES"),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {}),
        ],
      ),
    );
  }
}
