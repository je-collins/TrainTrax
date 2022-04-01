import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:train_trax/utils/urls.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';
import 'package:train_trax/widgets/TopBar.dart';
import 'package:train_trax/utils/APICall.dart';
import 'package:train_trax/utils/urls.dart';

class OurLibrary extends StatelessWidget {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');
  final fieldText = TextEditingController();
  String currentPage = "LIBRARY";
  var _hover = false;
  String name ='John Smith';
  String token;
  List articles;
  //required this.articles

  OurLibrary({Key? key, required this.token, required this.articles}) : super(key: key);

  Widget createListView(BuildContext context, String token) {
    //List values = snapshot.data;
    //if(snapshot.data != null)
      //values = snapshot.data;

    //return new ListView.builder()
    return new FutureBuilder(
        //itemCount: 5,
        //itemBuilder: (BuildContext context, int index) 
        //itemBuilder: (BuildContext context, int index)

        future: APICall.getStarredArticleRequest(token),
        builder: (context, snapshot){
          if (snapshot.hasData) {
              final articles = snapshot.data as List;
              return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return new Column(
                      children: <Widget>[
                        new Text(
                          'working',),

                        new Divider(height: 2.0,),
                      ],
                    );
                    //Text(articles[index]);
                  });
            } else if (snapshot.hasError) {
              // handle error here
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator(); // displays while loading data
            }
          /*
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Text('loading...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else{
                //List values = snapshot.data;
                if(values == null){
                  return new Text('No articles');
                }
                else
                  return new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if(values.length > 0)
                        Container(
                          child: Column(
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
                                    TextSpan(
                                      style: TextStyle(
                                        color: Theme.of(context).secondaryHeaderColor,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.underline,
                                      ),
                                      text: values[index],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                );
              }
          */      
          }
          
    );
  }

  /*
  Future convertFutureListToList(String token) async {
    Future<List> _futureOfList = APICall.getStarredArticleRequest(token);
    List list = await _futureOfList ;
    return list;
  }

  Widget projectWidget(String token) {
  return FutureBuilder(
    builder: (context, projectSnap) {
      List? values = projectSnap.data as List?;
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
*/

  @override
  Widget build(BuildContext context) {
    
  int len=articles.length;

    
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                TopBar.createTopBar(context, name, currentPage, token),
                //Logo
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset(
                    "assets/NETC_Logo.jpg",
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                //Page bar
                NavBar.createNavBar(context, currentPage, token),

                //Library Search
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                    child: Text(
                      "LIBRARY SEARCH",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                //Search bar
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: Center(
                    child: TextField(
                      controller: fieldText,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              /* Clear the search field */
                              fieldText.clear();
                            },
                          ),
                          hintText: 'Search...',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),

                //Recommmended list
                Container(
                  child: Text(
                    "RECOMMENDED",
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //createListView(context,token),
                //*
                for (var i = 0; i < len; i++)
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
                              TextSpan(
                                style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline,
                                ),
                                //name of article
                                text: articles[i], 
                                  recognizer: TapGestureRecognizer()..onTap =  () async{
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) => 
                                        Dialog(
                                          child: Center(
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(15.0),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 6*24,
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          Urls.createUrl(
                                                              url: articles[i],
                                                              txt: articles[i],
                                                              context: context),
                                                        ],
                                                      ),
                                                    )
                                                  ),
                                                ),

                                                Wrap(
                                                  spacing: 20.0,
                                                  children: [
                                                    RaisedButton(
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 100),
                                                        child: Text(
                                                          "Favorite",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        //delete[i] = true;
                                                        //Navigator.pop(context, delete);
                                                        //APICall.addFavoriteRequest(token, articleid);
                                                      },
                                                    ),

                                                    RaisedButton(
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 100),
                                                        child: Text(
                                                          "Download",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        //delete[i] = false;
                                                        //Navigator.pop(context, delete);
                                                        //APICall.addDownloadRequest(token, articleid);
                                                      },
                                                    )
                                                    //if(delete)

                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          //if(delete)
                                        ));
                                        
                                  }
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //

                SizedBox(
                  height: 40.0,
                ),

                //USED BY OTHERS list
                /*
                Container(
                  child: Text(
                    "USED BY OTHERS",
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                for (var i = 0; i < 5; i++)
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
                                  url: 'https://www.youtube.com/',
                                  txt: 'Testing',
                                  context: context),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  */
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
