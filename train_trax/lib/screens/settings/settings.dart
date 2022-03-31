import 'package:flutter/material.dart';
import 'package:train_trax/screens/settings/local_widgets/settingsForm.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';
import 'package:train_trax/widgets/TopBar.dart';

class OurSettings extends StatelessWidget {
  String currentPage = "SETTINGS";
  String name ='John Smith';
  String token;

  OurSettings({Key? key, required this.token}) : super(key: key);

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
                //OurHomepage(),
                const SizedBox(
                  height: 20.0,
                ),
                OurSettingsForm(token: token,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
