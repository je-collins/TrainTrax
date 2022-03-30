import 'package:train_trax/screens/home/admin/admin_widgets/admin_nav_bar.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:train_trax/widgets/TopBar.dart';

class OurManageTeams extends StatelessWidget {
  String currentPage = "MANAGE TEAMS";
  String name ='John Smith';
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
                TopBar.createTopBar(context, name, currentPage),
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

                NavBar.createNavBar(context, currentPage),
                const SizedBox(
                  height: 20.0,
                ),
                //Page bar
                OurAdminNavigation.createAdminBar(context, currentPage),

                const SizedBox(
                  height: 20.0,
                ),

                //USED BY OTHERS list
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                    child: Text(
                      "MANAGE TEAMS",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
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
