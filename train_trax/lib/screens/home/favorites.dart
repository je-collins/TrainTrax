import 'package:flutter/material.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';
import 'package:train_trax/widgets/TopBar.dart';
import 'package:train_trax/utils/APICall.dart';

class OurFavorite extends StatelessWidget {
  String currentPage = "FAVORITE";
  String name = 'John Smith';
  String token;
  List articles;
  bool isAdmin = false;

  Future<String> parseFavorites({required String token}) async {
    try {
      List _returnString;

      //_returnString = await APICall.getFavoritesRequest(token);

      return '';
    } catch (e) {
      print(e);
    }
    throw (e) {};
  }

  OurFavorite({Key? key, required this.token, required this.articles, required this.name, required this.isAdmin}) : super(key: key);

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
                TopBar.createTopBar(context, name, currentPage, token, isAdmin),
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
                      "FAVORITES",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                for (var i = 0; i < 5; i++)
                  Row(
                    children: [
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.favorite),
                          color: Theme.of(context).secondaryHeaderColor,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        child: Text(
                          "testing",
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
