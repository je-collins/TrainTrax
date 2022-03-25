// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:train_trax/utils/urls.dart';
import 'package:train_trax/utils/ProfileBar.dart';
import 'package:train_trax/utils/NavBar.dart';


class OurAdminFAQ extends StatelessWidget {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('My Personal Journal');
  final fieldText = TextEditingController();
  String currentPage = "FAQ";
  TextEditingController answerController = TextEditingController();
  var _hover = false;
  int maxLine = 8;
  List<String> listOfQ = ['How can we claim credit for the Cybersecurity class?', 
                          'Can regular users add a link  to the Library?',
                          'How do I know which courses I have completed?'];
  List<String> listOfM = ['John Smith', 
                          'John Smith',
                          'John Smith'];
  var numQuest = 3;

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
                ProfileBar.createProfileBar(context, currentPage),
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

                //QUESTIONS FOR ADMIN
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                  child: Center(
                    child: Text(
                      "QUESTIONS FOR ADMIN",
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(
                  height: 20.0,
                ),

                Wrap(
                  children: <Widget>[
                    //QUESTIONS
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                        width: 500.0,
                        child: Text(
                          "QUESTIONS",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //MEMBER
                      Container(
                        width: 300.0,
                        child: Text(
                          "MEMBER",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                ),

                SizedBox(
                  height: 20.0,
                ),

                for(var i=0; i<numQuest; i++) 
                  Wrap(
                    children: <Widget>[
                      //QUESTIONS
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        width: 500.0,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                text: "\u2022 ",
                              ),
                              TextSpan(
                                text: listOfQ[i],
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //MEMBER
                      Container(
                        width: 300.0,
                        child: Text(
                          listOfM[i],
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                           ),
                        ),
                      ),

                      //ANSWER BUTTON
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: RaisedButton(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                              child: Text(
                                "Answer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => 
                              Dialog(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Container(
                                          height: 6*24,
                                          decoration: BoxDecoration(
                                            color: Colors.white, 
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.black)
                                          ),
                                          child: TextField(
                                            controller: answerController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(

                                              ),
                                            ),
                                            keyboardType: TextInputType.multiline,
                                            maxLines: 6,// when user presses enter it will adapt to it
                                          ),
                                        ),
                                        /*
                                        TextField(
                                        
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,//Normal textInputField will be displayed
                                          maxLines: 5,// when user presses enter it will adapt to it
                                        ),
                                        */
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),

                                      RaisedButton(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 100),
                                          child: Text(
                                            "Send",
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
                                    ],
                                  ),
                                ),
                              ));
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))
                         
                          /*
                          TextFormField(
                            controller: answerController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),
                              obscureText: true,
                            );
                          SizedBox(
                            height: 20.0,
                          );
                          */
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
