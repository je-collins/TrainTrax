import 'package:train_trax/screens/home/Homepage.dart';
import 'package:train_trax/screens/self-directed/self-directed.dart';
import 'package:train_trax/widgets/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:train_trax/screens/home/downloads.dart';
import 'package:train_trax/screens/home/faq.dart';
import 'package:train_trax/screens/home/favorites.dart';
import 'package:train_trax/screens/settings/settings.dart';

class ProfileBar extends StatelessWidget{
  String? currentPage = null;

  void setPage(String? current){
    currentPage=current;

  }

  static Container createProfileBar(BuildContext context, String currentPage){
    return Container(
      child: Wrap(
        alignment: WrapAlignment.end,
        children: <Widget>[

          //DOWNLOAD
          if(currentPage == "DOWNLOAD")
          IconButton(
            color: Colors.yellow,
            icon: const Icon(Icons.download),
            onPressed: () {
            },
          ),
          if(currentPage != "DOWNLOAD")
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OurDownload(),
                ),
              );
            },
          ),
          
          //FAQ
          if(currentPage == "FAQ")
          IconButton(
            color: Colors.yellow,
            icon: const Icon(Icons.help),
            onPressed: () {
            },
          ),
          if(currentPage != "FAQ")
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OurFAQ(),
                ),
              );
            },
          ),

          //FAVORITE
          if(currentPage == "FAVORITE")
          IconButton(
            color: Colors.yellow,
            icon: const Icon(Icons.favorite),
            onPressed: () {
            },
          ),
          if(currentPage != "FAVORITE")
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OurFavorite(),
                ),
              );
            },
          ),

          //SETTINGS
          if(currentPage == "SETTINGS")
          IconButton(
            color: Colors.yellow,
            icon: const Icon(Icons.settings),
            onPressed: () {
            },
          ),
          if(currentPage != "SETTINGS")
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OurSettings(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.end,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }
}
