import 'package:flutter/material.dart';
import 'package:gtuc_covid19/chatfoder/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

bool showSpinner = false;

class HelpAndReport extends StatefulWidget {
  @override
  _HelpAndReportState createState() => _HelpAndReportState();
}

class _HelpAndReportState extends State<HelpAndReport> {
  var timestamp = FieldValue.serverTimestamp();
  final _firestore = Firestore.instance;
  var fullname, emailadd, mssg, phon;

  sentcheckdata() async {
    final datamessage = await _firestore
        .collection('appreport')
        .where("email", isEqualTo: email)
        .getDocuments();
    try {
      if (datamessage.documents.isEmpty) {
        callToast("something went wrong! check your internet connexion please");
        setState(() {
          showSpinner = false;
        });
      } else {
        callToast("your request has been sent, Thank you!!");

        setState(() {
          showSpinner = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    } catch (e) {
      callToast("something went wrong! check your internet connexion please");
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Help And Complain"),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //height: screenSize.height / 9,
                      child: Center(
                        child: Card(
                            elevation: 10,
                            child: Container(
                              //height: screenSize.height / 9,
                                width: screenSize.width - 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Please Read these informations to help you understand the app",
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ))),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),

                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: screenSize.width - 20,
                        child: Text(
                            "Access the public chat after a click on these icons below:",
                            softWrap: true),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: <Widget>[
                          Icon(Icons.chat, size: 35),
                          Text(" OR "),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.account_circle,
                              size: 35,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: screenSize.width - 20,
                        child: Text(
                            "Access only the counselor or advisor messages  in the chat interface after a click on this icon below:",
                            softWrap: true),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Icon(Icons.visibility, size: 35),

                        ],
                      ),
                      Container(
                        width: screenSize.width - 20,
                        child: Text("Counselors or advisors are those who have experienced the virus or the community of doctors on the platform. Their messages are in a red square. You can easily distinguish their messages from the rest of users. \n",softWrap: true),
                      ),
                      Container(
                        width: screenSize.width - 20,
                        child: Text(
                            "Access the menu in your chat interface, profile inteface, request interface after a click on this icon below:",
                            softWrap: true),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: <Widget>[
                          Icon(Icons.menu, size: 35),

                        ],
                      ),
                      Container(
                        width: screenSize.width - 20,
                        child: Text(
"From the menu you can navigate to the home interface, chat interface, profile interface, request interface, visit GTUC website, Ghana Health Services  website, access the help & report interface and log out.\n ",                            softWrap: true),
                      ),
                      Container(
                        width: screenSize.width - 20,
                        child: Text("When doing a request, you need to provide valid informations. \nAfter a request, you need to refresh often in case any update has been made by the admin. The status will be either Accepted Or Rejected. \nClick on the icon below to refresh:",softWrap: true),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: <Widget>[
                          Icon(Icons.update, size: 35),

                        ],
                      ),
                      Container(
                        width: screenSize.width - 20,
                        child: Text("You can change your username in the profile interface. Type in the textfield provided and click on the buton save. Nice you changed your username. The username is the name that appears on the patform.",softWrap: true),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: screenSize.width - 20,
                  //height: 50,
                  child: Text(
                      "For your first time, you need to register with an email and password, for the next time, just click on login button. After the login you will not be required to log in unless you decide to sign out by a click on these icons below:",
                      softWrap: true),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.directions_run),
                      SizedBox(
                        width: 20,
                      ),
                      Text(" or"),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.close),
                    ]),
                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //height: screenSize.height / 9,
                      child: Center(
                        child: Card(
                            elevation: 10,
                            child: Container(
                                //height: screenSize.height / 9,
                                width: screenSize.width - 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Please in case you need assistance, fill this form with valid information",
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ))),
                      ),
                    )
                  ],
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height / 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            //SizedBox(width: 10,),

                            Text(
                              "FullName",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(right: 10),
                                width: screenSize.width,
                                child: TextField(
                                  onChanged: (value) {
                                    fullname = value;
                                  },

                                  //controller: messageTextController,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height / 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            //SizedBox(width: 10,),

                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(right: 10),
                                width: screenSize.width,
                                child: TextField(
                                  onChanged: (value) {
                                    emailadd = value;
                                  },

                                  //controller: messageTextController,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height / 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            //SizedBox(width: 10,),

                            Text(
                              "Phone",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(right: 10),
                                width: screenSize.width,
                                child: TextField(
                                  keyboardType: TextInputType.number,

                                  onChanged: (value) {
                                    phon = value;
                                  },

                                  // controller: messageTextController,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height / 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            //SizedBox(width: 10,),

                            Text(
                              "Message",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Flexible(
                              child: Container(
                                color: Colors.white,
                                margin: EdgeInsets.only(right: 10),
                                width: screenSize.width,
                                child: TextField(
                                  onChanged: (value) {
                                    mssg = value;
                                  },

                                  //controller: messageTextController,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height / 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            //SizedBox(width: 10,),

                            Text(
                              "Click here to send",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RaisedButton(
                              color: Colors.white,
                              child: Text("Send"),
                              onPressed: () {
                                if (fullname == null ||
                                    phon == null ||
                                    emailadd == null ||
                                    mssg == null) {
                                  callToast(
                                      "Please all the field are required!!");
                                } else {
                                  if (emailadd.isEmpty ||
                                      fullname.isEmpty ||
                                      mssg.isEmpty ||
                                      phon.isEmpty) {
                                    callToast(
                                        "Please all the field are required!!");
                                  } else {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    try {
                                      _firestore.collection('appreport').add({
                                        'email': emailadd,
                                        'fullname': fullname,
                                        'content': mssg,
                                        'phone': phon,
                                        'timestamp': timestamp,
                                      });
                                      sentcheckdata();
                                    } catch (e) {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      callToast(
                                          "something went wrong! check your internet connexion and try again");
                                    }
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
