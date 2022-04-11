// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:train_trax/utils/APICall.dart';

import '../../../utils/profile.dart';


class DropDown extends StatefulWidget {
  List<String> listOfM;
  DropDown({Key? key, required this.listOfM}) : super(key: key);
  

  @override
  State<DropDown> createState() => _MyDropDown(listOfM: listOfM);
}

class _MyDropDown extends State<DropDown> {
  final addMember = TextEditingController();
  List<String> listOfTeams = ['Team 1', 'Team 2', 'Team 3', 'Team 4'];
  late String dropdownValue= listOfTeams.elementAt(0);

  List<String> listOfM = [];
  var numTeamates = 0;

  _MyDropDown({required this.listOfM});
  List<bool>  delete = [];

  @override
  Widget build(BuildContext context) {
    numTeamates=listOfM.length;
    delete = List.filled(numTeamates, false);
    return Column(
      children: [
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: listOfTeams
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
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
                                                delete[i] = true;
                                                Navigator.pop(context, delete);
                                                //delete members
                                                //APICall.deleteMemberRequest( token,  teamid,  memberid);
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
                                                delete[i] = false;
                                                Navigator.pop(context, delete);
                                              },
                                            )
                                          //if(delete)

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  //if(delete)
                                )
                              );
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
                          //add team member
                          //APICall.addMemberRequest(token, teamid, memberid);
                        },
                      ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                Center(
                  child: RaisedButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: Text(
                            "Delete Team",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          //delete team
                          //APICall.deleteTeamRequest(token, String teamid);
                        },
                      ),
                ),
      ],
    );
  }
}
