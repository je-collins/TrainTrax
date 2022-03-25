import 'package:flutter/material.dart';
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
                TopBar.createTopBar(context, name, currentPage),
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
                NavBar.createNavBar(context, currentPage),
                SizedBox(
                  height: 20.0,
                ),
                NavBar.createAdminNavBar(context, currentPage),

                SizedBox(
                  height: 20.0,
                ),

                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      for(int i=0; i<numTeamates; i++)
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 23.0,
                                  child: IconButton(
                                    alignment: Alignment.bottomCenter,
                                    splashRadius: 26,
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                    onPressed:  () {
                                      //remove from team
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => 
                                        Dialog(
                                          child: Center(
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(15.0),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 6*24,
                                                    child: Text(
                                                      "Do you want to remove this member from the team"
                                                    ),
                                                  ),
                                                ),

                                                Wrap(
                                                  spacing: 20.0,
                                                  children: [
                                                    RaisedButton(
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 100),
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        //send response
                                                      },
                                                    ),

                                                    RaisedButton(
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 100),
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20.0,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        //send response
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));

                                    },
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                              child:Profile.createProfile(context, listOfM[i], true),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                Center(
                  child: DropDown(),
                ),

                SizedBox(
                  height: 20.0,
                ),

                //add member
                
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Container(
                  width: 750,
                  height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)
                        ),
                    child: Center(
                      child: TextField(
                        controller: addMember,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                /* Clear the search field */
                                 addMember.clear(); 
                              },
                            ),
                            hintText: 'Team Member',
                            border: InputBorder.none),
                      ),
                    ),
                ),
                
                Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: RaisedButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                        },
                      ),
                      ),
                  ],
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
