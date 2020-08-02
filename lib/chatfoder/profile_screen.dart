import 'package:flutter/material.dart';
import 'package:gtuc_covid19/models/user_model.dart';
import 'package:gtuc_covid19/widgetPacket/profile_clipper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../custom_drawer.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
final _firestore = Firestore.instance;

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseUser loggedInUser;
  bool showSpinner = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final usernameController = TextEditingController();
  String newusername="";
  saverole(String newrole) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("role", newrole);
      preferences.commit();
    });

  }
  checkdata()async{
    setState(() {
      showSpinner = true;
    });
    try{

      final datamessage= await _firestore.collection('role').where('email', isEqualTo: email).getDocuments();
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
          String newfunction=datapiece.data['function'].toString();
          print("savind in the pref new role: "+newfunction);
          saverole(newfunction);
          print("finish saving");
          //callToast("new user set role done"+newfunction);

          print(datapiece.data);
        }
        callToast("update done");
        setState(() {
          getPrefrole();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileScreen(user: getUser(),)),
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
      print("printing message");
      print(e.toString());
      print("error printed above this one");
    }

  }
  @override
  void initState() {
    super.initState();
    //getPref();
    getPreffromConstant();

  }

  @override
  Widget build(BuildContext context) {

    TextEditingController newUsername = new TextEditingController();
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipPath(
                    clipper: ProfileClipper(),
                    child: Image(
                      height: 300.0,
                      width: double.infinity,
                      image: AssetImage(widget.user.backgroundImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 50.0,
                    left: 20.0,
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      iconSize: 30.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image(
                          height: 120.0,
                          width: 120.0,
                          image: AssetImage(widget.user.profileImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  widget.user.email,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        widget.user.username,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Refresh"),
                    onPressed: (){
                      setState(() {
                        checkdata();

                      });
                    },
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'role',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        widget.user.role,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(height:50,
                        width:200,
                        decoration: kMessageContainerDecoration,

                        child: null,),
                      Text(
                        'Change Username',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Container(

                        width: 200,
                        child: TextField(
                          decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Enter your username'),
                          controller: usernameController,
                          onChanged: (value) {
                            newusername = value;
                          },
                        ),
                      ),
                      RaisedButton(
                        elevation: 10,
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                        onPressed: () {
if(newusername.isEmpty){
  callToast(" Please fill the field");
}else{
  setState(() {
    print("newusername is now: "+ newusername);

    editPreusername(newusername);
    getPreusername();
    //getPreffromConstant();
    print("username is now: "+ username);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen(user: getUser(),)),
    );
  });
  //User user=new User(profileImageUrl: profileImageUrl,backgroundImageUrl: backgroundImageUrl,username: username,email: email,role: role);

}
                        },
                        child: Text(
                          'Save',style: TextStyle(fontSize: 20),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
