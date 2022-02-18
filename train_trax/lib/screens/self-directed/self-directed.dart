import 'package:train_trax/screens/self-directed/local_widgets/NavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:train_trax/utils/urls.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';

class OurSelfDirected extends StatelessWidget {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');
  final fieldText = TextEditingController();
  String currentPage = "SELF-DIRECTED";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                ProfileBar.createProfileBar(context, currentPage),
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
                NavBar.createNavBar(context, currentPage),
                //OurLibrarypage(),
                
                //Search
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                      child: Text(
                      "SEARCH ONLINE",
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
                        border: Border.all(color: Colors.black)
                        ),
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

                  //USED BY OTHERS list
                Container(
                  child: Text(
                  "MOST RECENTLY SEARCHED:",
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                for(var i=0; i<5; i++) 
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
                        Urls.createUrl(url: 'https://www.youtube.com/', txt: 'Testing', context: context),
                      ],
                      
                    ),
                  )
                  
                      ],

                    ),
                  ),
              ],
            ),
            ),
        ],
      ),
    );
  }
}
