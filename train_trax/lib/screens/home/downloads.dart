//import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';
import 'package:train_trax/widgets/TopBar.dart';
import 'package:pspdfkit_flutter/src/main.dart';
import 'package:path/path.dart';

// URL of the PDF file you'll download.

class OurDownload extends StatelessWidget {
  String currentPage = "DOWNLOAD";
  String name = 'John Smith';
  String token;
  bool isAdmin = false;

  OurDownload({Key? key, required this.token, required this.name, required this.isAdmin}) : super(key: key);

  double progress = 0;

  // Track if the PDF was downloaded here.
  bool didDownloadPDF = false;

  Future<List<String>> getDownloadedFiles(Dio dio, String url, String savePath) async {
    Directory? dir = await getExternalStorageDirectory();
    if (dir == null) {
      return [];
    }

    await for (var file in dir.list(recursive: false, followLinks: false)) {}
    return [];
  }

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
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                    child: Text(
                      "DOWNLOADS",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.download),
                        color: Theme.of(context).secondaryHeaderColor,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
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
