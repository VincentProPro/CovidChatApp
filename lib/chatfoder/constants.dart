import 'package:flutter/material.dart';
import 'package:gtuc_covid19/models/request_model.dart';
import 'package:gtuc_covid19/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluttertoast/fluttertoast.dart';
String urlgtuc="https://site.gtuc.edu.gh";
String urlghs="https://ghanahealthservice.org";
String wlcghs="Welcome To Ghana Health Service";
String wlcgtuc="Welcome To GTUC";

enum LoginStatus { notSignIn, signIn }
enum ReqstStatus { requested, norequested }
var id,email,role,username,backgroundImageUrl,profileImageUrl;
var emailRqst,fullnameRqst,statusRqst,jobRqst,functionRqst,phonRqst,purpRqst;
Request reqst=new Request(emailRqst: emailRqst,fullnameRqst: fullnameRqst,statusRqst: statusRqst,jobRqst: jobRqst,functionRqst: functionRqst,phonRqst: phonRqst,purpRqst: purpRqst);

User user=new User(profileImageUrl: profileImageUrl,backgroundImageUrl: backgroundImageUrl,username: username,email: email,role: role);
User getUser(){
  getPreffromConstant();
  User user=new User(profileImageUrl: profileImageUrl,backgroundImageUrl: backgroundImageUrl,username: username,email: email,role: role);
return user;
}
Request getRequest(){
  getPrefRequest();
  Request reqst=new Request(emailRqst: email,fullnameRqst: fullnameRqst,statusRqst: statusRqst,jobRqst: jobRqst,functionRqst: functionRqst,phonRqst: phonRqst,purpRqst: purpRqst);
  return reqst;
}
getPrefRequest() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
    emailRqst = preferences.getString("emailRqst");
    purpRqst = preferences.getString("purpRqst");
    phonRqst = preferences.getString("phonRqst");
    functionRqst = preferences.getString("functionRqst");
    statusRqst = preferences.getString("statusRqst");
    jobRqst = preferences.getString("jobRqst");
    fullnameRqst = preferences.getString("fullnameRqst");
}


getPrefrole() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  role = preferences.getString("role");
}


editPreusername(String newusername) async {

  SharedPreferences preferences = await SharedPreferences.getInstance();
  //remove();
  preferences.setString("username", newusername);
username=newusername;
  preferences.commit();

}
savePrefRequest(int newvalueRqst, String newemailRqst,String newfullnameRqst,String newjobRqst,String newfunctionRqst,String newphonRqst,String newpurpRqst,String newstatusRqst) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("valueRqst", newvalueRqst);
    preferences.setString("emailRqst", newemailRqst);
    preferences.setString("fullnameRqst", newfullnameRqst);
    preferences.setString("jobRqst", newjobRqst);
    preferences.setString("functionRqst", newfunctionRqst);
    preferences.setString("phonRqst", newphonRqst);
    preferences.setString("purpRqst", newpurpRqst);
    preferences.setString("statusRqst", newstatusRqst);
    preferences.commit();

}

getPreusername() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  username = preferences.getString("username");

}
getPreffromConstant() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  id = preferences.getString("id");
  email = preferences.getString("email");
  role = preferences.getString("role");
  username = preferences.getString("username");
  backgroundImageUrl = preferences.getString("backgroundImageUrl");
  profileImageUrl = preferences.getString("profileImageUrl");

}

signOutfromconsant() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt("value", 0);
  preferences.setString("role", null);
  preferences.setString("email", null);
  preferences.setString("username", null);

  preferences.setInt("valueRqst", null);
  preferences.setString("emailRqst", null);
  preferences.setString("fullnameRqst", null);
  preferences.setString("jobRqst", null);
  preferences.setString("functionRqst", null);
  preferences.setString("phonRqst", null);
  preferences.setString("purpRqst", null);
  preferences.setString("statusRqst", null);
  preferences.commit();
}
callToast(String msg) {
  Fluttertoast.showToast(
      msg: "$msg",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

