// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:train_trax/utils/APICall.dart';
import 'package:train_trax/utils/urls.dart';
import 'package:train_trax/utils/NavBar.dart';
import 'package:train_trax/widgets/TopBar.dart';
import 'package:train_trax/utils/profile.dart';
import 'package:train_trax/screens/admin/local_widgets/adminTeamMangForm.dart';


class OurAdminTeamMang extends StatelessWidget {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');
  final addMember = TextEditingController();
  final newTeam = TextEditingController();
  String currentPage = "MANAGE_TEAMS";
  String name ='John Smith';
  List<String> listOfM = ['John Smith1', 
                          'John Smith2',
                          'John Smith3',
                          'John Smith4',
                          'John Smith5',
                          'John Smith6'];
  var numTeamates = 6;
  var _hover = false;
  var teamateNum =0;
  bool isAdmin =true;
  var listOfTeams;
  var numTeams = 0;

  String token;
  List<bool>  delete = [false, 
                          false,
                          false,
                          false,
                          false,
                          false];

  OurAdminTeamMang({Key? key, required this.token, required this.name, required this.listOfTeams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                TopBar.createTopBar(context, name, currentPage, token, isAdmin),
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
                NavBar.createNavBar(context, currentPage, token, name, isAdmin),
                SizedBox(
                  height: 20.0,
                ),
                NavBar.createAdminNavBar(context, currentPage, token, name),

                SizedBox(
                  height: 20.0,
                ),

                Center(
                  child: DropDown(listOfM: listOfM,),
                ),

                SizedBox(
                  height: 20.0,
                ),

                SizedBox(
                  height: 20.0,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                      child: Text(
                      "New Team:",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ),

                SizedBox(
                  height: 10.0,
                ),

                //create team
               Wrap(
                 alignment: WrapAlignment.center,
                 children: [
                    Container(
                      child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: Text(
                      "Team Name",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                  ),

                ),
                    ),

                    Container(
                      width: 750,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)
                        ),
                    
                      child: TextField(
                        controller: newTeam,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                /* Clear the search field */
                                 newTeam.clear(); 
                              },
                            ),
                            hintText: '',
                            border: InputBorder.none),
                      ),
                      ),
                Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: RaisedButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: Text(
                            "Create",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          //create team
                          //APICall.createTeamRequest(String token, String teamName);
                        },
                      ),
                      ),
                 ],
               ),
                
                SizedBox(
                  height: 40.0,
                ),


              ],
            ),
            ),
        ],
      ),
    );
  }
}
