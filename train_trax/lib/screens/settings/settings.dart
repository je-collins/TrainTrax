import 'package:train_trax/screens/home/local_widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:train_trax/screens/settings/local_widgets/settingsForm.dart';

class OurSettings extends StatelessWidget {
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
                OurHomepage(),
                const SizedBox(
                  height: 20.0,
                ),
                OurSettingsForm(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
