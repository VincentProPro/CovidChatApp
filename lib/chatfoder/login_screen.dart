import 'package:flutter/material.dart';
import 'package:gtuc_covid19/chatfoder/welcome_screen.dart';
import 'rounded_button.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = Firestore.instance;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  LoginStatus _loginStatus = LoginStatus.notSignIn;
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
        //print("document is empty");
        setState(() {
          showSpinner = false;
        });
      } else{

        for(var datapiece in datamessage.documents){
          //newString=datapiece.data['email'].toString();
          print("executing the loop ");
          String newfunction=datapiece.data['function'].toString();
          //print("savind in the pref new role: "+newfunction);
          saverole(newfunction);
          print("finish saving");
          //callToast("new user set role done"+newfunction);

          print(datapiece.data);
        }
        setState(() {
          getPrefrole();


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
  checkdatarqst()async{
    setState(() {
      showSpinner = true;
    });
    try{

      final datamessage= await _firestore.collection('request').where('email', isEqualTo: email).getDocuments();
      if(datamessage.documents.isEmpty){
        print("document is empty");

        setState(() {
          showSpinner = false;
        });
      } else{

        for(var datapiece in datamessage.documents){
          //newString=datapiece.data['email'].toString();
setState(() {
  savePrefRequest(1,datapiece.data['email'].toString(),datapiece.data['fullname'].toString(),datapiece.data['job'].toString(),datapiece.data['function'].toString(),datapiece.data['phone'].toString(),datapiece.data['purpose'].toString(),datapiece.data['status'].toString());
  getPrefRequest();
});          print("executing the loop ");
          print("finish saving");

          print(datapiece.data);
        }
          // print("my role is "+role);

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
  savePref(int value, String email,String username,String role,String backgroundImageUrl,String profileImageUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("role", role);
      preferences.setString("email", email);
      preferences.setString("username", username);
      preferences.setString("backgroundImageUrl", backgroundImageUrl);
      preferences.setString("profileImageUrl", profileImageUrl);
      preferences.commit();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/gtucapp.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                colour: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      setState(() {
                        _loginStatus = LoginStatus.signIn;
                        savePref(1, email,"changeusername", "user","images/gtucapp.png","images/gtucLogo.png");
                        checkdatarqst();
                        checkdata();
                        //savePref(1, email, "user");

                      });
                      Navigator.pushNamed(context, ChatScreen.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    callToast("something went wrong! check your internet connexion and try again");
                    Navigator.pushNamed(context, WelcomeScreen.id);

                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
