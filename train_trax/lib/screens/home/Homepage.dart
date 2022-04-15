import 'package:flutter/material.dart';
import 'package:train_trax/utils/APICall.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';
import 'package:train_trax/widgets/TopBar.dart';
import 'package:train_trax/utils/urls.dart';
import 'package:flutter/gestures.dart';

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
  List articles;
  var userStats;
  List myArticles;
  List completedArticles;

  OurHome(
      {Key? key,
      required this.token,
      required this.name,
      required this.isAdmin,
      required this.articles,
      required this.userStats,
      required this.myArticles,
      required this.completedArticles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int len = articles.length;
    int leng = myArticles.length;
    int lengt = completedArticles.length;

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    text: "Total Articles Started: " +
                                        userStats["total_articles_started"]
                                            .toString()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    text: "Average Articles Started: " +
                                        userStats["average_articles_started"]
                                            .toString()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    text: "Average Articles Completed: " +
                                        userStats["average_articles_completed"]
                                            .toString()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    text: "Total Articles Completed: " +
                                        userStats["total_articles_completed"]
                                            .toString()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
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

                for (var i = 0; i < 5; i++)
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                text: "",
                              ),
                              TextSpan(
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.underline,
                                  ),
                                  //name of article
                                  text: articles[i],
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              Dialog(
                                                child: Center(
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            15.0),
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 6 * 24,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  Urls.createUrl(
                                                                      url: articles[
                                                                          i],
                                                                      txt: articles[
                                                                          i],
                                                                      context:
                                                                          context),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                      Wrap(
                                                        spacing: 20.0,
                                                        children: [
                                                          RaisedButton(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          100),
                                                              child: Text(
                                                                "Favorite",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          RaisedButton(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          100),
                                                              child: Text(
                                                                "Download",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          RaisedButton(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          100),
                                                              child: Text(
                                                                "Mark as Completed",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    }),
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

                for (var i = 0; i < leng; i++)
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                text: "",
                              ),
                              TextSpan(
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.underline,
                                  ),
                                  //name of article

                                  text: myArticles[i]["article"],
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              Dialog(
                                                child: Center(
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            15.0),
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 6 * 24,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  Urls.createUrl(
                                                                      url: myArticles[
                                                                              i]
                                                                          [
                                                                          "article"],
                                                                      txt: myArticles[
                                                                              i]
                                                                          [
                                                                          "article"],
                                                                      context:
                                                                          context),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                      Wrap(
                                                        spacing: 20.0,
                                                        children: [
                                                          RaisedButton(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          100),
                                                              child: Text(
                                                                "Favorite",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          RaisedButton(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          100),
                                                              child: Text(
                                                                "Download",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          RaisedButton(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          100),
                                                              child: Text(
                                                                "Mark as Completed",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    }),
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

                for (var i = 0; i < lengt; i++)
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                text: "",
                              ),
                              TextSpan(
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.underline,
                                  ),
                                  //name of article

                                  text: completedArticles[i]["article"],
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              Dialog(
                                                child: Center(
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            15.0),
                                                        child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 6 * 24,
                                                            child: RichText(
                                                              text: TextSpan(
                                                                children: [
                                                                  Urls.createUrl(
                                                                      url: completedArticles[
                                                                              i]
                                                                          [
                                                                          "articles"],
                                                                      txt: completedArticles[
                                                                              i]
                                                                          [
                                                                          "articles"],
                                                                      context:
                                                                          context),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                      Wrap(
                                                        spacing: 20.0,
                                                        children: [
                                                          RaisedButton(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          100),
                                                              child: Text(
                                                                "Favorite",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          RaisedButton(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          100),
                                                              child: Text(
                                                                "Download",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                          RaisedButton(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          100),
                                                              child: Text(
                                                                "Mark as Completed",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0,
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    }),
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
