import 'package:flutter/material.dart';
import 'package:train_trax/utils/APICall.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';
import 'package:train_trax/widgets/TopBar.dart';
import 'package:train_trax/utils/urls.dart';

class OurHome extends StatelessWidget {
  String currentPage = "HOME";
  String name = 'John Smith';
  String token;
  var searches;
  var names;
  var toBeComplete;
  var namestoBe;
  var recommended;
  var namesRecommended;
  bool isAdmin;

  OurHome({Key? key, required this.token, required this.name, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    searches = [
      'https://www.youtube.com/',
      'https://www.navy.mil/',
      'https://en.wikipedia.org/wiki/Sharable_Content_Object_Reference_Model'
    ];
    names = ['youtube', 'navy website', 'SCORM Reference'];
    toBeComplete = [
      'https://www.youtube.com/watch?v=JSIXnw3hoOg',
      'https://scorm.com/scorm-explained/one-minute-scorm-overview/',
    ];
    namestoBe = ['cmi5 Youtube', 'SCORM Explained'];
    recommended = [
      'https://www.youtube.com/watch?v=JSIXnw3hoOg',
      'https://scorm.com/scorm-explained/one-minute-scorm-overview/',
    ];
    namesRecommended = ['cmi5 Youtube', 'SCORM Explained'];
    
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                TopBar.createTopBar(context, name, currentPage, token, isAdmin),

                //Logo
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    "assets/NETC_Logo.jpg",
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                NavBar.createNavBar(context, currentPage, token, name, isAdmin),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                    child: Text(
                      "USER DASHBOARD",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                    child: Text(
                      "RECOMMENDED",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                for (var i = 0; i < recommended.length; i++)
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                text: "\u2022 ",
                              ),
                              Urls.createUrl(
                                  url: recommended[i],
                                  txt: namesRecommended[i],
                                  context: context),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                    child: Text(
                      "STARTED CONTENT",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                for (var i = 0; i < toBeComplete.length; i++)
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                text: "\u2022 ",
                              ),
                              Urls.createUrl(
                                  url: toBeComplete[i],
                                  txt: namestoBe[i],
                                  context: context),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                    child: Text(
                      "COMPLETED CONTENT",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                for (var i = 0; i < searches.length; i++)
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                text: "\u2022 ",
                              ),
                              Urls.createUrl(
                                  url: searches[i],
                                  txt: names[i],
                                  context: context),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
