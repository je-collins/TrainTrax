import 'package:train_trax/screens/library/local_widgets/NavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OurLibrary extends StatelessWidget {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');
  final fieldText = TextEditingController();
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
                OurLibrarypage(),
                
                //Library Search
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
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
                        border: Border.all(color: Colors.black)
                        ),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                /* Clear the search field */
                                 TextEditingController().clear(); 
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
                for(var i=0; i<5; i++) 
                  Container(
                    child: Text(
                    "\u2022 "+"testing",
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                  height: 40.0,
                ),

                  //USED BY OTHERS list
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
                for(var i=0; i<5; i++) 
                  Container(
                    child: Text(
                    "\u2022 "+"testing",
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      ),
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
