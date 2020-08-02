import 'package:flutter/material.dart';
import 'package:gtuc_covid19/widgetPacket/requestPage.dart';
import 'package:gtuc_covid19/widgetPacket/webDisplay.dart';

import 'chatfoder/chat_screen.dart';
import 'chatfoder/constants.dart';
import 'chatfoder/login_screen.dart';
import 'chatfoder/profile_screen.dart';
import 'dashboard/dashboard.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgetPacket/reportPage.dart';


class CustomDrawer extends StatelessWidget {

  _buildDrawerOption(Icon icon, String title, Function onTap) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      onTap: onTap,
    );
  }
  _buildDrawerSetting(Icon icon, String title, Function onTap) {
    getPrefrole();
    if(role=="Admin"){
      return ListTile(
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        onTap: onTap,
      );
    }else{
      return SizedBox();
    }

  }
  //var id,email,role,username;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image(
                height: 200.0,
                width: double.infinity,
                image: AssetImage(
                  backgroundImageUrl,
                ),
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 20.0,
                left: 20.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: ClipOval(
                        child: Image(
                          image: AssetImage(
                            profileImageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 6.0),
          Container(
            child: Text(
              email,softWrap: true, overflow: TextOverflow.ellipsis,

              style: TextStyle(
                color: Colors.green,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          _buildDrawerOption(
            Icon(Icons.dashboard),
            'Home',
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => MyHomePage(),
              ),
            ),
          ),
          _buildDrawerOption(Icon(Icons.chat), 'Chat', () {
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(),
            ),
          );
          }),

          _buildDrawerOption(
            Icon(Icons.account_circle),
            'Your Profile',
            () =>  Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(user: getUser(),),
              ),
            ),//fin signOutfromconsant()
          ),
          _buildDrawerOption(Icon(Icons.create), 'Request', () {
            getPrefRequest();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => RequestPage(),
              ),
            );

          }),

          _buildDrawerOption(Icon(Icons.school), 'Visit GTUC', () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Affiche(urlgtuc,wlcgtuc),
              ),
            );
          }),
          _buildDrawerOption(Icon(Icons.account_balance), 'Ghana Health Service', () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Affiche(urlghs,wlcghs),
              ),
            );
          }),
    _buildDrawerSetting(Icon(Icons.settings), 'Go To DashBoard', () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Dashboard(),
        ),
      );
    }),
          _buildDrawerOption(Icon(Icons.help), 'Help & Report', () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HelpAndReport(),
              ),
            );
          }),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: _buildDrawerOption(
                Icon(Icons.directions_run),
                'Logout',
                () =>functionontap(context)
              ),
            ),
          ),
        ],
      ),
    );
  }
  functionontap(BuildContext context){
    signOutfromconsant();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(),
      ),
    );
  }


  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");
    email = preferences.getString("email");
    role = preferences.getString("role");
    username = preferences.getString("username");
  }
}
