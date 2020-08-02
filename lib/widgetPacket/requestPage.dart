import 'package:flutter/material.dart';
import 'package:gtuc_covid19/chatfoder/constants.dart';
import 'package:gtuc_covid19/chatfoder/profile_screen.dart';
import 'package:gtuc_covid19/models/request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../custom_drawer.dart';
final _firestore = Firestore.instance;
bool showSpinner = false;

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
 // final _auth = FirebaseAuth.instance;
  var timestamp=FieldValue.serverTimestamp();
  var value;

  final messageTextController = TextEditingController();

  getPrefRqst() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("valueRqst");

      _reqstStatus = value == 1 ? ReqstStatus.requested : ReqstStatus.norequested;
    });
  }
  ReqstStatus _reqstStatus = ReqstStatus.norequested;


  @override
  void initState() {
   setState(() {
     getPrefRqst();
     getPreffromConstant();
   });
  }
  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    switch (_reqstStatus) {
      case ReqstStatus.norequested:
        return ModalProgressHUD(
          inAsyncCall: showSpinner,

          child: Scaffold(
            appBar: AppBar(title: Text("Request"),),
            drawer: CustomDrawer(),

            body: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[

                        Container(
                          height: screenSize.height / 9,
                          child: Center(
                            child: Card(
                                elevation: 10,

                                child: Container(
                                    height: screenSize.height / 9,
                                    width: screenSize.width - 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Please fill this form with valid information",
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        style: TextStyle(fontSize: 22),),
                                    ))),
                          ),
                        )
                      ],),

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
                                SizedBox(width: 10,),
                                //SizedBox(width: 10,),

                                Text("FullName", style: TextStyle(fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),),
                                SizedBox(height: 10,),
                                Flexible(
                                  child: Container(

                                    color: Colors.white,
                                    margin: EdgeInsets.only(right: 10),
                                    width: screenSize.width,
                                    child: TextField(

                                      onChanged: (value) {
                                        fullnameRqst = value;
                                      },

                                      //controller: messageTextController,

                                    ),
                                  ),
                                )
                              ],),
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
                                SizedBox(width: 10,),
                                //SizedBox(width: 10,),

                                Text("Function", style: TextStyle(fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),),
                                SizedBox(height: 10,),
                                Flexible(
                                  child: Container(

                                    color: Colors.white,
                                    margin: EdgeInsets.only(right: 10),
                                    width: screenSize.width,
                                    child: TextField(
                                      onChanged: (value) {
                                        functionRqst = value;
                                      },

                                      //controller: messageTextController,

                                    ),
                                  ),
                                )
                              ],),
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
                                SizedBox(width: 10,),
                                //SizedBox(width: 10,),

                                Text("Job", style: TextStyle(fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),),
                                SizedBox(height: 10,),
                                Flexible(
                                  child: Container(

                                    color: Colors.white,
                                    margin: EdgeInsets.only(right: 10),
                                    width: screenSize.width,
                                    child: TextField(
                                      onChanged: (value) {
                                        jobRqst = value;
                                      },

                                     // controller: messageTextController,

                                    ),
                                  ),
                                )
                              ],),
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
                                SizedBox(width: 10,),
                                //SizedBox(width: 10,),

                                Text("Phone", style: TextStyle(fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),),
                                SizedBox(height: 10,),
                                Flexible(
                                  child: Container(

                                    color: Colors.white,
                                    margin: EdgeInsets.only(right: 10),
                                    width: screenSize.width,
                                    child: TextField(
                                      keyboardType: TextInputType.number,

                                      onChanged: (value) {
                                        phonRqst = value;
                                      },

                                     // controller: messageTextController,

                                    ),
                                  ),
                                )
                              ],),
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
                                SizedBox(width: 10,),
                                //SizedBox(width: 10,),

                                Text("Purpose", style: TextStyle(fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),),
                                SizedBox(height: 10,),
                                Flexible(
                                  child: Container(

                                    color: Colors.white,
                                    margin: EdgeInsets.only(right: 10),
                                    width: screenSize.width,
                                    child: TextField(
                                      onChanged: (value) {
                                        purpRqst = value;
                                      },

                                      //controller: messageTextController,

                                    ),
                                  ),
                                )
                              ],),
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
                                SizedBox(width: 10,),
                                //SizedBox(width: 10,),

                                Text("Click here to send", style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),),
                                SizedBox(height: 10,),
                                RaisedButton(
                                  color: Colors.white,
                                  child: Text("Request"),
                                  onPressed: () {
                                 if( fullnameRqst==null || functionRqst==null || jobRqst==null || phonRqst==null || purpRqst==null){
                                   callToast("Please all the field are required!!");


                                 }else{
                                   if(email.isEmpty || fullnameRqst.isEmpty || functionRqst.isEmpty || jobRqst.isEmpty || phonRqst.isEmpty || purpRqst.isEmpty){
                                     callToast("Please all the field are required!!");
                                   }else{
                                     setState(() {
                                       showSpinner = true;
                                     });
                                     try {
                                       messageTextController.clear();
                                       _firestore.collection('request').add({
                                         'email': email,
                                         'fullname': fullnameRqst,
                                         'function': functionRqst,
                                         'job': jobRqst,
                                         'phone': phonRqst,
                                         'purpose': purpRqst,
                                         'status': "Pending",
                                         'timestamp': timestamp,

                                       });
                                       sentcheckdata();
                                     } catch (e) {
                                       callToast(
                                           "something went wrong! check your internet connexion and try again");
                                     }
                                   }
                                 }
                                  },
                                ),
                              ],),
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
        break;
      case ReqstStatus.requested:return SeeRequst(request: getRequest());
    break;
  }
  }

   sentcheckdata()async{
   final datamessage= await _firestore.collection('request').where("email",isEqualTo: email).getDocuments();
  try{
    if(datamessage.documents.isEmpty){
      callToast("something went wrong! check your internet connexion please");
    } else{
      callToast("your request has been sent, Thank you!!");
      setState(() {
        savePrefRequest(1, email,fullnameRqst,jobRqst, functionRqst, phonRqst, purpRqst,"Pending...");
        getPrefRequest();
      });
      setState(() {
        showSpinner = false;

      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SeeRequst(request: getRequest(),)),
      );

    }
  }catch(e){
    print(e.toString());
    setState(() {
      showSpinner = false;

    });
  }

  }
}


class SeeRequst extends StatefulWidget {
  final Request request;

  SeeRequst({this.request});

  @override
  _SeeRequstState createState() => _SeeRequstState();
}

class _SeeRequstState extends State<SeeRequst> {
  getPrefRequest() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      emailRqst = preferences.getString("emailRqst");
      purpRqst = preferences.getString("purpRqst");
      phonRqst = preferences.getString("role");
      functionRqst = preferences.getString("functionRqst");
      statusRqst = preferences.getString("statusRqst");
      jobRqst = preferences.getString("jobRqst");
      fullnameRqst = preferences.getString("fullnameRqst");
      preferences.commit();
    });
  }
   savePrefstatus(String newstate) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

   setState(() {
     preferences.setString("statusRqst", newstate);
     preferences.commit();
   });
  }
  getPrefstate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      statusRqst = preferences.getString("statusRqst");
    });
  }
  checkdata()async{
    setState(() {
      showSpinner = true;

    });
    try{

      final datamessage= await _firestore.collection('request').where('email', isEqualTo: email).getDocuments();
      if(datamessage.documents.isEmpty){
        print("document is empty");
        callToast("nothing has been changed");
        setState(() {
          showSpinner = false;

        });
      } else{

        for(var datapiece in datamessage.documents){
          //newString=datapiece.data['email'].toString();
          print("executing the loop ");
          String newstaterqst=datapiece.data['status'].toString();
          print("savind in the pref new staterqst: "+newstaterqst);
setState(() {
  savePrefstatus(newstaterqst);

});          print("finish saving");
          //callToast("new user set role done"+newstaterqst);

          print(datapiece.data);
        }
        callToast("update done");
        setState(() {
          getPrefstate();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SeeRequst(request: getRequest(),)),
          );
        });       // print("my role is "+role);

        setState(() {
          showSpinner = false;

        });

      }
    }catch(e){
      callToast("something went wrong! check your internet connexion please");
      setState(() {
        showSpinner = false;

      });
    }

  }
  @override
  void initState() {
setState(() {
  getPrefRequest();

});  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: showSpinner,

      child: Scaffold(
        appBar: AppBar(title: Row(children: <Widget>[
          Text('Your Request'),
          SizedBox(
            width: 15,
          ),IconButton(
              icon: Icon(Icons.update),
              onPressed: () {
                checkdata();
              }),

        ]),),
        drawer: CustomDrawer(),

        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    Container(
                      height: screenSize.height / 9,
                      child: Center(
                        child: Card(
                            elevation: 10,

                            child: Container(
                                height: screenSize.height / 9,
                                width: screenSize.width - 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Request Details",
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    style: TextStyle(fontSize: 22),),
                                ))),
                      ),
                    )
                  ],),

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
                  SizedBox(width: 10,),
                  //SizedBox(width: 10,),

                  Text("Request Status:", style: TextStyle(fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),),
                  SizedBox(height: 10,),
                  Flexible(
                    child: Container(

                      color: Colors.white,
                      margin: EdgeInsets.only(right: 10),
                      width: screenSize.width,
                      child: Text(widget.request.statusRqst),
                    ),
                  )
                ],),
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
                            SizedBox(width: 10,),
                            //SizedBox(width: 10,),

                            Text("FullName", style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            Flexible(
                              child: Container(

                                color: Colors.white,
                                margin: EdgeInsets.only(right: 10),
                                width: screenSize.width,
                                child: Text(fullnameRqst),
                              ),
                            )
                          ],),
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
                            SizedBox(width: 10,),
                            //SizedBox(width: 10,),

                            Text("Email", style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            Flexible(
                              child: Container(

                                color: Colors.white,
                                margin: EdgeInsets.only(right: 10),
                                width: screenSize.width,
                                child: Text(widget.request.emailRqst),
                              ),
                            )
                          ],),
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
                            SizedBox(width: 10,),
                            //SizedBox(width: 10,),

                            Text("Function", style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            Flexible(
                              child: Container(

                                color: Colors.white,
                                margin: EdgeInsets.only(right: 10),
                                width: screenSize.width,
                                child: Text(widget.request.functionRqst),
                              ),
                            )
                          ],),
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
                            SizedBox(width: 10,),
                            //SizedBox(width: 10,),

                            Text("Job", style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            Flexible(
                              child: Container(

                                color: Colors.white,
                                margin: EdgeInsets.only(right: 10),
                                width: screenSize.width,
                                child: Text(widget.request.jobRqst),
                              ),
                            )
                          ],),
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
                            SizedBox(width: 10,),
                            //SizedBox(width: 10,),

                            Text("Phone", style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            Flexible(
                              child: Container(

                                color: Colors.white,
                                margin: EdgeInsets.only(right: 10),
                                width: screenSize.width,
                                child: Text(widget.request.phonRqst),
                              ),
                            )
                          ],),
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
                            SizedBox(width: 10,),
                            //SizedBox(width: 10,),

                            Text("Purpose", style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            Flexible(
                              child: Container(

                                color: Colors.white,
                                margin: EdgeInsets.only(right: 10),
                                width: screenSize.width,
                                child: Text(widget.request.purpRqst),
                              ),
                            )
                          ],),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text("Quit"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(user: getUser(),),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }


}

