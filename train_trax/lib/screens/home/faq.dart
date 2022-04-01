import 'package:flutter/material.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';
import 'package:train_trax/widgets/TopBar.dart';

class OurFAQ extends StatelessWidget {
  String currentPage = "FAQ";
  String name ='John Smith';
  final fieldText = TextEditingController();
  String token;

  OurFAQ({Key? key, required this.token}) : super(key: key);

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
                      "FREQUENTLY ASKED QUESTIONS",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text("\u2022 " + "How do I complete a module?",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                Container(
                  child: Text("\u2022 " + "How do I complete a module?",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                Container(
                  child: Text("\u2022 " + "How do I complete a module?",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                Container(
                  child: Text("\u2022 " + "How do I complete a module?",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                    child: Text(
                      "Ask Our Admins Questions",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: Center(
                    child: TextField(
                      controller: fieldText,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              /* Clear the search field */
                              fieldText.clear();
                            },
                          ),
                          hintText: "  What can we help you with?",
                          border: InputBorder.none),
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