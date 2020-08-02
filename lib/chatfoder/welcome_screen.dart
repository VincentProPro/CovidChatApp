import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'constants.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'rounded_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  var id,email,role;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getInt("value");
      email = preferences.getString("email");
      role = preferences.getString("role");
      _loginStatus = id == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;

    });
    print("id" + id);
    print("user" + email);
    print("name" + role);
  }
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  @override
  void initState() {
    super.initState();
    getPref();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: animation.value,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        child: Image.asset('images/gtucapp.png'),
                        height: 60.0,
                      ),
                    ),

                  ],
                ),
                Container(
                  width: screenSize.width,
                  child: TypewriterAnimatedTextKit(
                    text: ['Welcome to gtucCovidChat'],
                    textStyle: TextStyle(
                      fontSize: screenSize.width<300?45.0:35,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                RoundedButton(
                  title: 'Log In',
                  colour: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
                RoundedButton(
                  title: 'Register',
                  colour: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                ),
              ],
            ),
          ),
        );
        break;

      case LoginStatus.signIn:
        return ChatScreen();
//        return ProfilePage(signOut);
        break;
    }

  }
}
