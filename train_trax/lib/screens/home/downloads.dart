import 'package:train_trax/screens/home/local_widgets/navigation_bar.dart';
import 'package:train_trax/screens/home/local_widgets/downloads_list.dart';
import 'package:flutter/material.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';

class OurDownload extends StatelessWidget {
  String currentPage = "DOWNLOAD";
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
                ProfileBar.createProfileBar(context, currentPage),
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
                //OurHomepage(),
                OurDownloads(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
