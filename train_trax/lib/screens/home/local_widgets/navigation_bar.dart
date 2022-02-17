import 'package:train_trax/screens/home/Homepage.dart';
import 'package:train_trax/screens/library/library.dart';
import 'package:train_trax/widgets/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:train_trax/screens/self-directed/self-directed.dart';

class OurHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigation(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
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
          FlatButton(
            textColor: Colors.yellow,
            child: Text("LIBRARY"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {},
          ),
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
          FlatButton(
            textColor: Colors.white,
            child: Text("CERTIFICATIONS"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
