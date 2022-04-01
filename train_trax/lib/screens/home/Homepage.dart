import 'package:flutter/material.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';
import 'package:train_trax/widgets/TopBar.dart';

class OurHome extends StatelessWidget {
  String currentPage = "HOME";
<<<<<<< HEAD
  String name ='John Smith';
=======
  String name = 'John Smith';
>>>>>>> 7c287ab622b70fe0f1901ff562560334450b1d19
  String token;

  OurHome({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                TopBar.createTopBar(context, name, currentPage, token),

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

                NavBar.createNavBar(context, currentPage, token),

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

                for (var i = 0; i < 5; i++)
                  Container(
                    child: Text(
                      "\u2022 " + "testing",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                      ),
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

                for (var i = 0; i < 5; i++)
                  Container(
                    child: Text(
                      "\u2022 " + "testing",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                      ),
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

                for (var i = 0; i < 5; i++)
                  Container(
                    child: Text(
                      "\u2022 " + "testing",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                      ),
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
